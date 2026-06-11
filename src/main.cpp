#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle(QStringLiteral("Basic"));

    QQmlApplicationEngine engine;
    const QUrl debugUiUrl(QStringLiteral("qrc:/examples/DebugWindow.qml"));

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [debugUiUrl](QObject *obj, const QUrl &objUrl) {
            if (!obj && objUrl == debugUiUrl) {
                QCoreApplication::exit(-1);
            }
        },
        Qt::QueuedConnection);

    engine.load(debugUiUrl);

    return app.exec();
}
