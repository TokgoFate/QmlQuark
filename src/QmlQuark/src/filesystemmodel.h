// filesystemmodel.h
#ifndef FILESYSTEMMODEL_H
#define FILESYSTEMMODEL_H

#include <QAbstractListModel>
#include <QDir>
#include <QFileInfo>
#include <QDateTime>

struct FileEntry {
  QString name;
  QString path;
  bool isDirectory;
  qint64 size;
  QDateTime modified;
  QString iconType;
};

class FileSystemModel : public QAbstractListModel {
  Q_OBJECT
  Q_PROPERTY(QString currentPath READ currentPath WRITE setCurrentPath NOTIFY
                 currentPathChanged)
  Q_PROPERTY(bool canNavigateUp READ canNavigateUp NOTIFY currentPathChanged)
  Q_PROPERTY(bool loading READ loading NOTIFY loadingChanged)

public:
  enum Roles {
    NameRole = Qt::UserRole + 1,
    PathRole,
    IsDirectoryRole,
    SizeRole,
    ModifiedRole,
    IconTypeRole
  };

  explicit FileSystemModel(QObject *parent = nullptr);

  int rowCount(const QModelIndex &parent = QModelIndex()) const override;
  QVariant data(const QModelIndex &index,
                int role = Qt::DisplayRole) const override;
  QHash<int, QByteArray> roleNames() const override;

  QString currentPath() const;
  bool canNavigateUp() const;
  bool loading() const;

public slots:
  void setCurrentPath(const QString &path);
  void navigateUp();
  void navigateTo(int index);
  void refresh();
  void createFolder(const QString &name);
  void deleteSelected(const QVariantList &indices);
  QString formatSize(qint64 bytes) const;

signals:
  void currentPathChanged();
  void loadingChanged();
  void errorOccurred(const QString &message);

private:
  void extracted(QFileInfoList &list);
  void loadDirectory(const QString &path);
  QString getIconType(const QString &suffix, bool isDir) const;
  void setLoading(bool loading);

  QString m_currentPath;
  QList<FileEntry> m_entries;
  bool m_loading = false;
};

#endif