#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    int id = QFontDatabase::addApplicationFont("GL-MahjongTile.ttf");

    if (id != -1) {
        QString font_family = QFontDatabase::applicationFontFamilies(id).first();
        qDebug(font_family.toLatin1().constData());
    }

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
