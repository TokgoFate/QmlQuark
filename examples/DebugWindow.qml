import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "qrc:/src/QmlQuark" as Quark

ApplicationWindow {
    id: root
    visible: true
    width: 1080
    height: 760
    color: Quark.Palette.window
    title: "QmlQuark Debug UI"

    header: ToolBar {
        background: Rectangle {
            color: Quark.Palette.surface
            border.width: 1
            border.color: Quark.Palette.border
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 12

            Label {
                text: "QmlQuark Debug"
                color: Quark.Palette.text
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.lg
                font.bold: true
            }

            Item { Layout.fillWidth: true }

            Quark.QuarkButton {
                text: "Alert"
                onClicked: debugAlert.open()
            }

            Quark.QuarkButton {
                text: "Prompt"
                onClicked: debugPrompt.open()
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Quark.QuarkCard {
            Layout.preferredWidth: 320
            Layout.fillHeight: true
            title: "调试面板"

            Text {
                text: "当前主题"
                color: Quark.Palette.text
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.md
                font.bold: true
            }

            Rectangle {
                width: parent.width
                height: 52
                radius: 12
                color: Quark.Palette.surfaceAlt
                border.width: 1
                border.color: Quark.Palette.border

                Text {
                    anchors.centerIn: parent
                    text: "Accent: " + Quark.Palette.accent
                    color: Quark.Palette.text
                    font.family: Quark.Typography.family
                    font.pixelSize: Quark.Typography.sm
                }
            }

            Quark.QuarkTextField {
                id: debugText
                width: parent.width
                placeholderText: "输入调试文本"
            }

            Quark.QuarkSelectBox {
                width: parent.width
                model: ["模式 A", "模式 B", "模式 C"]
            }

            Quark.QuarkProgressBar {
                width: parent.width
                value: slider.value
            }

            Slider {
                id: slider
                width: parent.width
                from: 0
                to: 1
                value: 0.45
            }
        }

        Quark.QuarkCard {
            Layout.fillWidth: true
            Layout.fillHeight: true
            title: "组件预览"

            ColumnLayout {
                width: parent.width
                spacing: 12

                Quark.QuarkButton {
                    text: "打开调试菜单"
                    onClicked: debugMenu.open()
                }

                Quark.QuarkDropdown {
                    id: debugMenu
                    y: 48
                    model: ["重载界面", "刷新数据", "打开日志"]
                }

                Quark.QuarkFileManager {
                    Layout.fillWidth: true
                    entries: [
                        { "name": "assets", "isDirectory": true },
                        { "name": "theme.conf", "isDirectory": false },
                        { "name": "ui-debug.log", "isDirectory": false }
                    ]
                }
            }
        }
    }

    Quark.QuarkAlertDialog {
        id: debugAlert
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "调试提醒"
        message: "这是一条用于调试组件状态的提示。"
    }

    Quark.QuarkPromptDialog {
        id: debugPrompt
        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "调试输入"
        message: "请输入测试值以验证输入组件。"
        placeholderText: "调试内容"
        onAccepted: debugText.text = text
    }
}
