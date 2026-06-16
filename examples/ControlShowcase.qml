import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    visible: true
    width: 1180
    height: 820
    color: Quark.Palette.window
    title: "QmlQuark Control Showcase"

    property int selectedMode: 0

    header: ToolBar {
        height: 64

        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 12

            ColumnLayout {
                spacing: 2

                Quark.QuarkLabel {
                    text: "QmlQuark 控件展台"
                    font.pixelSize: Quark.Typography.xl
                    font.bold: true
                }

                Quark.QuarkLabel {
                    text: "集中验证基础控件的状态、布局和滚动表现"
                    muted: true
                    font.pixelSize: Quark.Typography.sm
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Quark.QuarkIconButton {
                iconSource: "qrc:/Icons/chevron-down.svg"
                iconRotation: 270
                display: AbstractButton.IconOnly
                onClicked: showcaseFlickable.contentY = 0
            }
        }

        background: Rectangle {
            color: Quark.Palette.surface
            border.width: 1
            border.color: Quark.Palette.border
        }
    }

    Flickable {
        id: showcaseFlickable

        anchors.fill: parent
        anchors.margins: 20
        contentWidth: width
        contentHeight: contentColumn.implicitHeight
        clip: true

        ScrollBar.vertical: Quark.QuarkScrollBar {
            anchors.right: parent.right
            anchors.rightMargin: 4
        }

        ColumnLayout {
            id: contentColumn

            width: showcaseFlickable.width - 18
            spacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "状态与反馈"

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 18

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Quark.QuarkLabel {
                            text: "加载态"
                            font.bold: true
                        }

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
                            text: "标签色板"
                            font.bold: true
                        }

                        RowLayout {
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
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Quark.QuarkLabel {
                            text: "图标按钮"
                            font.bold: true
                        }

                        RowLayout {
                            spacing: 12

                            Quark.QuarkIconButton {
                                iconSource: "qrc:/Icons/chevron-down.svg"
                            }

                            Quark.QuarkIconButton {
                                iconSource: "qrc:/Icons/chevron-down.svg"
                                iconRotation: 180
                                outlined: false
                            }

                            Quark.QuarkIconButton {
                                iconSource: "qrc:/Icons/chevron-down.svg"
                                iconRotation: 90
                                enabled: false
                            }
                        }

                        Quark.QuarkLabel {
                            text: "进度状态"
                            font.bold: true
                        }

                        Quark.QuarkProgressBar {
                            Layout.fillWidth: true
                            value: 0.72
                        }
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 20

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "选择控件"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkCheckBox {
                            text: "启用实时刷新"
                            checked: true
                        }

                        Quark.QuarkCheckBox {
                            text: "将日志输出到状态面板"
                            checkState: Qt.PartiallyChecked
                        }

                        Quark.QuarkCheckBox {
                            text: "只读模式"
                            enabled: false
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 1
                            color: Quark.Palette.border
                            opacity: 0.8
                        }

                        Quark.QuarkLabel {
                            text: "运行模式"
                            font.bold: true
                        }

                        Quark.QuarkRadioButton {
                            text: "巡检模式"
                            checked: root.selectedMode === 0
                            onClicked: root.selectedMode = 0
                        }

                        Quark.QuarkRadioButton {
                            text: "维护模式"
                            checked: root.selectedMode === 1
                            onClicked: root.selectedMode = 1
                        }

                        Quark.QuarkRadioButton {
                            text: "离线模式"
                            checked: root.selectedMode === 2
                            onClicked: root.selectedMode = 2
                        }
                    }
                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "输入控件"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkTextField {
                            Layout.fillWidth: true
                            placeholderText: "输入设备名称"
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 12

                            Quark.QuarkSpinBox {
                                from: 0
                                to: 120
                                value: 24
                            }

                            Quark.QuarkSelectBox {
                                Layout.fillWidth: true
                                model: ["工业主题", "暗色主题", "调试主题"]
                            }
                        }

                        Quark.QuarkSlider {
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 64
                        }
                    }
                }
            }

            Quark.QuarkCard {
                Layout.fillWidth: true
                Layout.minimumHeight: 280
                title: "滚动与边界"

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 16

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 220
                        radius: 14
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border
                        clip: true

                        ListView {
                            anchors.fill: parent
                            anchors.margins: 10
                            model: 24
                            spacing: 8
                            clip: true

                            ScrollBar.vertical: Quark.QuarkScrollBar {
                                handleAccentColor: Quark.Palette.accentSoft
                            }

                            delegate: Rectangle {
                                required property int index

                                width: ListView.view.width
                                height: 44
                                radius: 10
                                color: index % 2 === 0 ? Quark.Palette.surface : Qt.darker(Quark.Palette.surface, 1.08)
                                border.width: 1
                                border.color: Quark.Palette.border

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 12
                                    anchors.rightMargin: 12

                                    Quark.QuarkLabel {
                                        Layout.fillWidth: true
                                        text: "监测通道 " + (index + 1)
                                    }

                                    Quark.QuarkLabel {
                                        text: index % 3 === 0 ? "ACTIVE" : "STANDBY"
                                        accent: index % 3 === 0
                                        muted: index % 3 !== 0
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 220
                        Layout.fillHeight: true
                        Layout.minimumHeight: 220
                        radius: 14
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "滚动条定制"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                text: "该区域用于验证垂直与水平滚动条的轨道、边框和高亮条表现。"
                                muted: true
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }

                            Flickable {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                contentWidth: 420
                                contentHeight: 320
                                clip: true

                                ScrollBar.vertical: Quark.QuarkScrollBar {
                                    handleAccentColor: Quark.Palette.success
                                }

                                ScrollBar.horizontal: Quark.QuarkScrollBar {
                                    handleAccentColor: Quark.Palette.accent
                                }

                                Rectangle {
                                    width: 420
                                    height: 320
                                    radius: 12
                                    color: Quark.Palette.surface
                                    border.width: 1
                                    border.color: Quark.Palette.border

                                    Repeater {
                                        model: 18

                                        Rectangle {
                                            required property int index

                                            x: 16 + (index % 3) * 130
                                            y: 16 + Math.floor(index / 3) * 48
                                            width: 112
                                            height: 32
                                            radius: 8
                                            color: Qt.darker(Quark.Palette.surfaceAlt, 1 + (index % 2) * 0.08)
                                            border.width: 1
                                            border.color: Quark.Palette.border

                                            Quark.QuarkLabel {
                                                anchors.centerIn: parent
                                                text: "NODE-" + (index + 1)
                                                font.pixelSize: Quark.Typography.sm
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}