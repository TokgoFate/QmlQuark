// filesystemmodel.cpp
#include "filesystemmodel.h"
#include <QMimeDatabase>

FileSystemModel::FileSystemModel(QObject *parent)
    : QAbstractListModel(parent), m_currentPath(QDir::homePath()) {
  loadDirectory(m_currentPath);
}

int FileSystemModel::rowCount(const QModelIndex &parent) const {
  Q_UNUSED(parent)
  return m_entries.count();
}

QVariant FileSystemModel::data(const QModelIndex &index, int role) const {
  if (!index.isValid() || index.row() >= m_entries.count())
    return QVariant();

  const FileEntry &entry = m_entries.at(index.row());
  switch (role) {
  case NameRole:
    return entry.name;
  case PathRole:
    return entry.path;
  case IsDirectoryRole:
    return entry.isDirectory;
  case SizeRole:
    return entry.isDirectory ? "" : formatSize(entry.size);
  case ModifiedRole:
    return entry.modified.toString("yyyy-MM-dd hh:mm");
  case IconTypeRole:
    return entry.iconType;
  default:
    return QVariant();
  }
}

QHash<int, QByteArray> FileSystemModel::roleNames() const {
  QHash<int, QByteArray> roles;
  roles[NameRole] = "name";
  roles[PathRole] = "path";
  roles[IsDirectoryRole] = "isDirectory";
  roles[SizeRole] = "size";
  roles[ModifiedRole] = "modified";
  roles[IconTypeRole] = "iconType";
  return roles;
}

QString FileSystemModel::currentPath() const { return m_currentPath; }

bool FileSystemModel::canNavigateUp() const {
  QDir dir(m_currentPath);
  return dir.cdUp();
}

void FileSystemModel::setCurrentPath(const QString &path) {
  if (m_currentPath == path)
    return;
  loadDirectory(path);
}

void FileSystemModel::navigateUp() {
  QDir dir(m_currentPath);
  if (dir.cdUp()) {
    loadDirectory(dir.absolutePath());
  }
}

void FileSystemModel::navigateTo(int index) {
  if (index < 0 || index >= m_entries.count())
    return;
  const FileEntry &entry = m_entries.at(index);
  if (entry.isDirectory) {
    loadDirectory(entry.path);
  }
}

void FileSystemModel::refresh() { loadDirectory(m_currentPath); }

void FileSystemModel::createFolder(const QString &name) {
  QDir dir(m_currentPath);
  if (!dir.mkdir(name)) {
    emit errorOccurred(tr("无法创建文件夹: %1").arg(name));
  }
  refresh();
}

void FileSystemModel::deleteSelected(const QVariantList &indices) {
  // 实现删除逻辑
  for (const QVariant &var : indices) {
    int idx = var.toInt();
    if (idx < 0 || idx >= m_entries.count())
      continue;
    const FileEntry &entry = m_entries.at(idx);
    if (entry.isDirectory) {
      QDir dir(entry.path);
      dir.removeRecursively();
    } else {
      QFile::remove(entry.path);
    }
  }
  refresh();
}

QString FileSystemModel::formatSize(qint64 bytes) const {
  const QStringList units = {"B", "KB", "MB", "GB", "TB"};
  int unitIndex = 0;
  double size = bytes;
  while (size >= 1024.0 && unitIndex < units.count() - 1) {
    size /= 1024.0;
    unitIndex++;
  }
  return QString("%1 %2")
      .arg(size, 0, 'f', unitIndex == 0 ? 0 : 2)
      .arg(units[unitIndex]);
}

void FileSystemModel::extracted(QFileInfoList &list) {
  for (const QFileInfo &info : list) {
    FileEntry entry;
    entry.name = info.fileName();
    entry.path = info.absoluteFilePath();
    entry.isDirectory = info.isDir();
    entry.size = info.size();
    entry.modified = info.lastModified();
    entry.iconType = getIconType(info.suffix().toLower(), info.isDir());
    m_entries.append(entry);
  }
}
void FileSystemModel::loadDirectory(const QString &path) {
  setLoading(true);
  beginResetModel();
  m_entries.clear();
  m_currentPath = QDir(path).absolutePath();

  QDir dir(m_currentPath);
  dir.setFilter(QDir::AllEntries | QDir::NoDotAndDotDot);
  dir.setSorting(QDir::DirsFirst | QDir::Name);

  QFileInfoList list = dir.entryInfoList();
  extracted(list);
  endResetModel();
  setLoading(false);
  emit currentPathChanged();
}

QString FileSystemModel::getIconType(const QString &suffix, bool isDir) const {
  if (isDir)
    return "folder";
  static const QHash<QString, QString> typeMap = {
      {"jpg", "image"},   {"jpeg", "image"}, {"png", "image"},
      {"gif", "image"},   {"bmp", "image"},  {"svg", "image"},
      {"mp4", "video"},   {"avi", "video"},  {"mkv", "video"},
      {"mov", "video"},   {"mp3", "audio"},  {"wav", "audio"},
      {"flac", "audio"},  {"aac", "audio"},  {"txt", "text"},
      {"md", "text"},     {"doc", "doc"},    {"docx", "doc"},
      {"pdf", "pdf"},     {"js", "code"},    {"qml", "code"},
      {"cpp", "code"},    {"h", "code"},     {"py", "code"},
      {"json", "code"},   {"xml", "code"},   {"zip", "archive"},
      {"rar", "archive"}, {"7z", "archive"}, {"tar", "archive"},
      {"gz", "archive"}};
  return typeMap.value(suffix, "file");
}

void FileSystemModel::setLoading(bool loading) {
  if (m_loading == loading)
    return;
  m_loading = loading;
  emit loadingChanged();
}
bool FileSystemModel::loading() const { return m_loading; }
