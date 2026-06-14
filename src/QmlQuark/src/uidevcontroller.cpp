#include "uidevcontroller.h"
#include <QTimer>

UiDevController::UiDevController(QGuiApplication *app,
                                 QQmlApplicationEngine *engine,
                                 const QUrl &mainUrl, bool reloadAvailable)
    : m_app(app), m_engine(engine), m_mainUrl(mainUrl),
      m_reloadAvailable(reloadAvailable) {}

bool UiDevController::reloadAvailable() const { return m_reloadAvailable; }

bool UiDevController::isReloading() const { return m_reloading; }

void UiDevController::reloadUi() {
  if (!m_reloadAvailable || !m_engine || m_reloading) {
    return;
  }

  m_reloading = true;

  // Defer the actual reload so the current QML signal handler can unwind
  // first.
  QTimer::singleShot(0, this, &UiDevController::performReload);
}

void UiDevController::performReload() {
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
