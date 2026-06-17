import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: galleryRoot

    // 弹窗触发信号（由外层 ApplicationWindow 连接实际弹窗）
    signal alertRequested()
    signal promptRequested()

    implicitWidth: 800
    implicitHeight: 600

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "基础控件"

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Quark.QuarkTextField {
                        Layout.fillWidth: true
                        placeholderText: "请输入内容"
                    }

                    Quark.QuarkSelectBox {
                        Layout.preferredWidth: 200
                        model: ["工业主题", "深色主题", "浅色主题"]
                    }
                }

                Quark.QuarkProgressBar {
                    Layout.fillWidth: true
                    value: 0.68
                }
            }
        }

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "下拉与弹窗"

            RowLayout {
                Layout.fillWidth: true
                spacing: 16

                Quark.QuarkButton {
                    text: "打开下拉菜单"
                    onClicked: galleryMenu.open()
                }

                Quark.QuarkButton {
                    text: "打开提示弹窗"
                    onClicked: galleryRoot.alertRequested()
                }

                Quark.QuarkButton {
                    text: "打开输入弹窗"
                    onClicked: galleryRoot.promptRequested()
                }

                // 右键菜单按钮：左键/右键均可弹出菜单
                // MouseArea 覆盖捕获右键（Button.onClicked 仅响应左键）
                Item {
                    id: menuBtnWrapper
                    implicitWidth: menuBtn.implicitWidth
                    implicitHeight: menuBtn.implicitHeight

                    Quark.QuarkButton {
                        id: menuBtn
                        anchors.fill: parent
                        text: "右键菜单"
                        onClicked: contextMenu.popup(menuBtnWrapper, 0, menuBtnWrapper.height + 4)
                    }

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.RightButton
                        onClicked: contextMenu.popup(menuBtnWrapper, 0, menuBtnWrapper.height + 4)
                    }
                }

                Quark.QuarkMenu {
                    id: contextMenu

                    // Action + delegate 模式（Qt 官方推荐）
                    Action { text: "新建文件" }
                    Action { text: "刷新目录" }
                    Action { text: "打开设置"; enabled: false }
                }

                // 文件管理器右键菜单
                Quark.QuarkMenu {
                    id: fileContextMenu
                    property var entryData: null

                    Action {
                        text: "进入目录"
                        enabled: fileContextMenu.entryData && fileContextMenu.entryData.isDirectory
                    }
                    Action {
                        text: "打开文件"
                        enabled: fileContextMenu.entryData && !fileContextMenu.entryData.isDirectory
                    }
                    Action { text: "刷新" }
                }
            }

            Quark.QuarkDropdown {
                id: galleryMenu

                y: 52
                model: ["新建文件", "刷新目录", "打开设置"]
            }
        }

        Quark.QuarkFileManager {
            id: galleryFileManager
            Layout.fillWidth: true
            Layout.fillHeight: true
            showSearch: false
            showToolbar: false
            showStatusBar: false
            currentPath: "/"

            onContextMenuRequested: function(entry, mouse) {
                fileContextMenu.entryData = entry
                fileContextMenu.popup()
            }
        }
    }
}
