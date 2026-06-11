import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../src/QmlQuark" as Quark

ApplicationWindow {
    visible: true
    width: 960
    height: 720
    color: Quark.Palette.window
    title: "QmlQuark Gallery"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "基础控件"

            RowLayout {
                width: parent.width
                spacing: 16

                Quark.QuarkTextField {
                    placeholderText: "请输入内容"
                }

                Quark.QuarkSelectBox {
                    model: ["工业主题", "深色主题", "浅色主题"]
                }
            }

            Quark.QuarkProgressBar {
                width: parent.width
                value: 0.68
            }
        }

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "下拉与弹窗"

            RowLayout {
                width: parent.width
                spacing: 16

                Quark.QuarkButton {
                    text: "打开下拉菜单"
                    onClicked: quickMenu.open()
                }

                Quark.QuarkButton {
                    text: "打开提示弹窗"
                    onClicked: alertDialog.open()
                }

                Quark.QuarkButton {
                    text: "打开输入弹窗"
                    onClicked: promptDialog.open()
                }
            }

            Quark.QuarkDropdown {
                id: quickMenu
                y: 52
                model: ["新建文件", "刷新目录", "打开设置"]
            }
        }

        Quark.QuarkFileManager {
            Layout.fillWidth: true
            entries: [
                { "name": "Documents", "isDirectory": true },
                { "name": "device-config.json", "isDirectory": false },
                { "name": "log-2026-06-11.txt", "isDirectory": false }
            ]
        }
    }

    Quark.QuarkAlertDialog {
        id: alertDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "删除提醒"
        message: "这是一个现代工业风格的提示弹窗示例。"
    }

    Quark.QuarkPromptDialog {
        id: promptDialog
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        title: "输入名称"
        message: "请输入一个新的卡片名称。"
        placeholderText: "例如：设备看板"
    }
}
