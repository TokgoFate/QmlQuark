#include <QCoreApplication>
#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QTimer>

class UiDevController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool reloadAvailable READ reloadAvailable CONSTANT)

public:
    UiDevController(QGuiApplication *app, QQmlApplicationEngine *engine, const QUrl &mainUrl, bool reloadAvailable)
        : m_app(app), m_engine(engine), m_mainUrl(mainUrl), m_reloadAvailable(reloadAvailable)
    {
    }

    bool reloadAvailable() const
    {
        return m_reloadAvailable;
    }

    bool isReloading() const
    {
        return m_reloading;
    }

    Q_INVOKABLE void reloadUi()
    {
        if (!m_reloadAvailable || !m_engine || m_reloading) {
            return;
        }

        m_reloading = true;

        // Defer the actual reload so the current QML signal handler can unwind first.
        QTimer::singleShot(0, this, &UiDevController::performReload);
    }

private:
    void performReload()
    {
        if (!m_engine) {
            m_reloading = false;
            return;
        }

        const auto roots = m_engine->rootObjects();
        if (!roots.isEmpty()) {
            roots.constFirst()->deleteLater();
        }

        QTimer::singleShot(0, this, [this]() {
            // Drop cached QML components so edited files are read from disk again.
            m_engine->clearComponentCache();
            m_engine->load(m_mainUrl);
            m_reloading = false;
        });
    }

    QGuiApplication *m_app = nullptr;
    QQmlApplicationEngine *m_engine = nullptr;
    QUrl m_mainUrl;
    bool m_reloadAvailable = false;
    bool m_reloading = false;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle(QStringLiteral("Basic"));
    app.setQuitOnLastWindowClosed(false);

    QQmlApplicationEngine engine;

    const QDir sourceDir(QStringLiteral(QMLQUARK_SOURCE_DIR));
    const QString localImportPath = sourceDir.filePath(QStringLiteral("src"));
    const QString localMainFile = sourceDir.filePath(QStringLiteral("examples/DebugWindow.qml"));

    engine.addImportPath(QStringLiteral("qrc:/src"));

    QUrl mainUrl(QStringLiteral("qrc:/examples/DebugWindow.qml"));
    bool reloadAvailable = false;

#if !defined(NDEBUG)
    if (QFileInfo::exists(localMainFile)) {
        engine.addImportPath(localImportPath);
        mainUrl = QUrl::fromLocalFile(localMainFile);
        reloadAvailable = true;
    }
#endif

    UiDevController devController(&app, &engine, mainUrl, reloadAvailable);
    engine.rootContext()->setContextProperty(QStringLiteral("devTools"), &devController);

    QObject::connect(&app, &QGuiApplication::lastWindowClosed, &app, [&app, &devController]() {
        if (!devController.isReloading()) {
            app.quit();
        }
    });

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [mainUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && objUrl == mainUrl) {
                QCoreApplication::exit(-1);
            }
        },
        Qt::QueuedConnection);

    engine.load(mainUrl);

    return app.exec();
}

#include "main.moc"
