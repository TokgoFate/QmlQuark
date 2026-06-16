import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    visible: true
    width: 1080
    height: 760
    color: Quark.Palette.window
    title: "QmlQuark Debug UI"

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

            Quark.QuarkSlider {
                id: slider

                width: parent.width
                from: 0
                to: 1
                value: 0.45
            }

            Quark.QuarkSlider {
                id: slider1

                width: 18
                height: 240
                orientation: Qt.Vertical
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
                Layout.fillHeight: true
                spacing: 12

                Quark.QuarkButton {
                    id: debugBtn
                    text: "打开调试菜单"
                    onClicked: debugMenu.open()
                }

                Quark.QuarkDropdown {
                    id: debugMenu

                    y: debugBtn.height + 7
                    model: ["重载界面", "刷新数据", "打开日志"]
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Quark.QuarkFileManager {
                        id: fileManager
                        anchors.fill: parent
                        currentPath: "./"
                        showSearch: true
                        showFileSize: true
                        onEntryDoubleClicked: function(entry, index) {
                            console.log("双击:", entry.name);
                        }
                        Component.onCompleted: {
                            console.info("size " + width + ", " + height);
                        }
                    }

                    Rectangle {
                        anchors.fill: fileManager
                        color: "yellow"
                        opacity: 0.2
                        visible: false
                    }
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

    header: ToolBar {
        height: 60

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

            Item {
                Layout.fillWidth: true
            }

            Quark.QuarkButton {
                text: "Alert"
                onClicked: debugAlert.open()
            }

            Quark.QuarkButton {
                text: "Prompt"
                onClicked: debugPrompt.open()
            }

            Quark.QuarkButton {
                visible: devTools.reloadAvailable
                text: "Reload QML"
                onClicked: devTools.reloadUi()
            }

        }

        background: Rectangle {
            color: Quark.Palette.surface
            border.width: 1
            border.color: Quark.Palette.border
        }

    }

}
