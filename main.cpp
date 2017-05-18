#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "cpuinfo.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<CPUInfo>("org.device.info", 1, 0, "CPUInfo");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
