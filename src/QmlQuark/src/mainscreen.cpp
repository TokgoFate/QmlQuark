#include "mainscreen.h"
#include "filesystemmodel.h"

#include <QQmlContext>
#include <QDebug>

void listResources(const QString &path = ":/") {
  QDir dir(path);
  for (const QString &file : dir.entryList(QDir::Files)) {
    qDebug() << "FILE = " << path + "/" + file;
  }
  for (const QString &subDir :
       dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
    listResources(path + "/" + subDir);
  }
}

MainScreen::MainScreen(QObject *parent) : QObject{parent} {}

void MainScreen::registerQmlTypes() {
  qmlRegisterType<FileSystemModel>("QmlQuark.FileSystem", 1, 0,
                                   "FileSystemModel");

  qDebug() << "MainScreen::registerQmlTypes";
  // 注册单例类型（QML 中通过 import 使用）
  // qmlRegisterSingletonType<<AppConfig>("QmlQuark.Config", 1, 0, "AppConfig",
  // createAppConfig);

  // listResources();
}

void MainScreen::setupContextProperties(QQmlEngine *engine) {
  // FileSystemModel *fsModel = new FileSystemModel(this);
  // engine->rootContext()->setContextProperty("fileSystem", fsModel);
}
