#ifndef UIDEVCONTROLLER_H
#define UIDEVCONTROLLER_H

#include <QGuiApplication>
#include <QObject>
#include <QQmlApplicationEngine>

class UiDevController : public QObject {
  Q_OBJECT
  Q_PROPERTY(bool reloadAvailable READ reloadAvailable CONSTANT)

public:
  UiDevController(QGuiApplication *app, QQmlApplicationEngine *engine,
                  const QUrl &mainUrl, bool reloadAvailable);

  bool reloadAvailable() const;

  bool isReloading() const;

  Q_INVOKABLE void reloadUi();

private:
  void performReload();

  QGuiApplication *m_app = nullptr;
  QQmlApplicationEngine *m_engine = nullptr;
  QUrl m_mainUrl;
  bool m_reloadAvailable = false;
  bool m_reloading = false;
};

#endif // UIDEVCONTROLLER_H
