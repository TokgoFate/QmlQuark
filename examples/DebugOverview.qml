import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: overviewRoot

    property int selectedMode: 1
    property real progressValue: previewSlider.value
    property int cardColumns: width > 1120 ? 3 : (width > 760 ? 2 : 1)

    signal alertRequested()
    signal promptRequested()

    function setDebugText(value) {
        debugInput.text = value;
    }

    Quark.QuarkMenu {
        id: debugMenu

        Action {
            text: "重载界面"
        }

        Action {
            text: "刷新数据"
        }

        Action {
            text: "打开日志"
        }

    }

    Flickable {
        id: overviewFlickable

        anchors.fill: parent
        anchors.margins: 24
        contentWidth: width
        contentHeight: contentColumn.implicitHeight
        clip: true

        ColumnLayout {
            id: contentColumn

            width: overviewFlickable.width - 10
            spacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "调试总览"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 14

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "将常用测试入口集中到一个面板：状态预览、快速操作与文件视图分区展示，避免调试页与组件页互相混杂。"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkButton {
                            text: "提示弹窗"
                            onClicked: overviewRoot.alertRequested()
                        }

                        Quark.QuarkButton {
                            text: "输入弹窗"
                            onClicked: overviewRoot.promptRequested()
                        }

                        Quark.QuarkButton {
                            text: "调试菜单"
                            onClicked: debugMenu.popup(this, 0, height + 6)
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Quark.QuarkLabel {
                            text: "Accent: " + Quark.Palette.accent
                            muted: true
                        }

                    }

                }

            }

            GridLayout {
                Layout.fillWidth: true
                columns: overviewRoot.cardColumns
                columnSpacing: 20
                rowSpacing: 20

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "主题与状态"

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 64
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6

                            Quark.QuarkLabel {
                                text: "当前主题色板"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "Window / Surface / Accent 已同步到当前控件主题。"
                                muted: true
                            }
                        }
                    }

                    Quark.QuarkTextField {
                        id: debugInput

                        Layout.fillWidth: true
                        placeholderText: "输入调试文本"
                    }

                    Quark.QuarkSelectBox {
                        Layout.fillWidth: true
                        model: ["模式 A", "模式 B", "模式 C"]
                        currentIndex: overviewRoot.selectedMode
                        onCurrentIndexChanged: overviewRoot.selectedMode = currentIndex
                    }

                    Quark.QuarkProgressBar {
                        Layout.fillWidth: true
                        value: overviewRoot.progressValue
                    }

                    Quark.QuarkSlider {
                        id: previewSlider

                        Layout.fillWidth: true
                        from: 0
                        to: 1
                        value: 0.45
                    }

                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "快捷开关"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkSwitch {
                            text: "启用热重载"
                            checked: devTools ? devTools.reloadAvailable : false
                        }

                        Quark.QuarkSwitch {
                            text: "显示辅助边界"
                            checked: false
                        }

                        Quark.QuarkCheckBox {
                            text: "自动刷新数据"
                            checked: true
                        }

                        Quark.QuarkCheckBox {
                            text: "写入调试日志"
                            checkState: Qt.PartiallyChecked
                        }

                        Quark.QuarkLabel {
                            text: "垂直刻度"
                            font.bold: true
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            Quark.QuarkSlider {
                                width: 18
                                height: 180
                                orientation: Qt.Vertical
                                from: 0
                                to: 1
                                value: 0.32
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Quark.QuarkLabel {
                                    Layout.fillWidth: true
                                    text: "将高频状态切换集中在总览页，减少切换到不同测试页反复操作。"
                                    muted: true
                                    wrapMode: Text.Wrap
                                }

                                Quark.QuarkButton {
                                    visible: devTools ? devTools.reloadAvailable : false
                                    text: "Reload QML"
                                    onClicked: devTools.reloadUi()
                                }

                            }

                        }

                    }

                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "反馈预览"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        RowLayout {
                            spacing: 12

                            Quark.QuarkBusyIndicator {
                                running: true
                            }

                            Quark.QuarkBusyIndicator {
                                running: true
                                accentColor: Quark.Palette.success
                                trackColor: Qt.darker(Quark.Palette.surfaceAlt, 1.15)
                            }

                            Quark.QuarkBusyIndicator {
                                running: false
                            }

                        }

                        Quark.QuarkLabel {
                            text: "标准标签 / 强调标签 / 辅助标签"
                            font.bold: true
                        }

                        Flow {
                            Layout.fillWidth: true
                            width: parent.width
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "默认文本"
                            }

                            Quark.QuarkLabel {
                                text: "强调文本"
                                accent: true
                            }

                            Quark.QuarkLabel {
                                text: "辅助文本"
                                muted: true
                            }

                        }

                        Quark.QuarkPageIndicator {
                            count: 5
                            currentIndex: 2
                        }

                    }

                }

            }

            Quark.QuarkCard {
                Layout.fillWidth: true
                Layout.preferredHeight: 400
                title: "文件管理器预览"

                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 12

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "保留一块完整的复合组件区域，用于验证搜索、列表、滚动与选择等多种控件在同一场景下的联动。"
                        muted: true
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Quark.QuarkFileManager {
                            anchors.fill: parent
                            currentPath: "./"
                            showSearch: true
                            showFileSize: true
                        }

                    }

                }

            }

        }

        ScrollBar.vertical: Quark.QuarkScrollBar {
            anchors.right: parent.right
        }

    }

}
