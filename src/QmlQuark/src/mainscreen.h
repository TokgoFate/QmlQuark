#ifndef MAINSCREEN_H
#define MAINSCREEN_H

#include <QObject>
#include <QQmlEngine>

class MainScreen : public QObject {
  Q_OBJECT
public:
  explicit MainScreen(QObject *parent = nullptr);

  void registerQmlTypes();
  void setupContextProperties(QQmlEngine *engine);
};

#endif // MAINSCREEN_H
