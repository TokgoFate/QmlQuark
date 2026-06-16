#include <QCoreApplication>
#include <QDir>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QTimer>
#include <memory>

#include "QmlQuark/src/mainscreen.h"
#include "QmlQuark/src/uidevcontroller.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle(QStringLiteral("Basic"));
    app.setQuitOnLastWindowClosed(false);

    std::unique_ptr<UiDevController> devController;
    QQmlApplicationEngine            engine;

    const QDir    sourceDir(QStringLiteral(QMLQUARK_SOURCE_DIR));
    const QString localImportPath = sourceDir.filePath(QStringLiteral("src"));
    const QString localMainFile =
        sourceDir.filePath(QStringLiteral("examples/DebugWindow.qml"));

    engine.addImportPath(QStringLiteral("qrc:/src"));

    QUrl mainUrl(QStringLiteral("qrc:/examples/DebugWindow.qml"));
    bool reloadAvailable = false;

#if !defined(NDEBUG)
    if (QFileInfo::exists(localMainFile))
    {
        engine.addImportPath(localImportPath);
        mainUrl         = QUrl::fromLocalFile(localMainFile);
        reloadAvailable = true;
    }
#endif

    devController =
        std::make_unique<UiDevController>(&app, &engine, mainUrl, reloadAvailable);
    engine.rootContext()->setContextProperty(QStringLiteral("devTools"),
                                             devController.get());

    UiDevController *devTools = devController.get();

    QObject::connect(&app, &QGuiApplication::lastWindowClosed, &app, [&app, devTools]() {
        if (!devTools->isReloading())
        {
            app.quit();
        }
    });

    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [mainUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && objUrl == mainUrl)
            {
                QCoreApplication::exit(-1);
            }
        },
        Qt::QueuedConnection);

    MainScreen screen;
    screen.registerQmlTypes();
    screen.setupContextProperties(&engine);

    engine.load(mainUrl);

    return app.exec();
}
