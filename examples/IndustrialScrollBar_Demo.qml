/*
 * QuarkScrollBar 使用示例
 *
 * 重叠问题解决方案：
 *   ① ScrollView — 自动预留空间 + 处理角落间距，内容绝不重叠（推荐）
 *   ② Flickable — 内容列需预留 rightMargin（见右侧示例）
 *   ③ 极细手柄（6px）+ 半透明，即使重叠也几乎不可见
 */

import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    color: Quark.Palette.window
    implicitWidth: 900
    implicitHeight: 620

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "滚动与样式"

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                Quark.QuarkLabel {
                    Layout.fillWidth: true
                    text: "把滚动条测试按布局策略和视觉语义分开：上半区比较承载方式，下半区专门检查颜色和密度。"
                    muted: true
                    wrapMode: Text.Wrap
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 56
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "布局策略"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "ScrollView 预留空间，Flickable 适合做 overlay。"
                                muted: true
                            }

                        }

                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 56
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "视觉语义"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "默认 / 成功 / 警告 / 危险 四组滚动反馈色。"
                                muted: true
                            }

                        }

                    }

                }

            }

        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 20

            Quark.QuarkCard {
                id: leftCard

                Layout.preferredWidth: 340
                Layout.fillHeight: true
                title: "ScrollView（推荐 · 无重叠）"

                // QuarkCard 的 body 已经是 ColumnLayout，子项直接放进去即可
                Quark.QuarkLabel {
                    Layout.fillWidth: true
                    text: "ScrollView 自动为滚动条预留空间，\n内容不会被遮挡。角落间距也自动处理。"
                    muted: true
                    wrapMode: Text.Wrap
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    Column {
                        spacing: 8
                        padding: 4

                        Repeater {
                            model: 40

                            Rectangle {
                                width: 290
                                height: 52
                                radius: 10
                                color: index % 2 === 0 ? Quark.Palette.surface : Quark.Palette.surfaceAlt
                                border.width: 1
                                border.color: Quark.Palette.border

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12

                                    Quark.QuarkLabel {
                                        Layout.fillWidth: true
                                        text: "列表项 " + (index + 1)
                                    }

                                    Quark.QuarkLabel {
                                        text: index % 3 === 0 ? "● ACTIVE" : "○ IDLE"
                                        accent: index % 3 === 0
                                        muted: index % 3 !== 0
                                    }
                                }
                            }
                        }
                    }

                    ScrollBar.vertical: Quark.QuarkScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 20

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 260
                    title: "Flickable + Overlay（内容预留 margin）"

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "内容列右侧预留 10px，6px 滚动条居其中。\n内容 Right-Margin 方案：width = flick.width - 10"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    Flickable {
                        id: flick

                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        contentWidth: width
                        contentHeight: flickColumn.implicitHeight
                        clip: true

                        Column {
                            id: flickColumn

                            width: flick.width - 10
                            spacing: 8

                            Repeater {
                                model: 25

                                Rectangle {
                                    width: flickColumn.width
                                    height: 48
                                    radius: 10
                                    color: index % 2 === 0 ? Quark.Palette.surface : Quark.Palette.surfaceAlt
                                    border.width: 1
                                    border.color: Quark.Palette.border

                                    Quark.QuarkLabel {
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 12
                                        text: "通道 " + String(index + 1).padStart(2, '0')
                                    }

                                }

                            }

                        }

                        ScrollBar.vertical: Quark.QuarkScrollBar {
                            anchors.right: parent.right
                            anchors.rightMargin: 2
                        }

                    }

                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "颜色定制"

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "通过 handleColor 切换滚动条主题色。\n默认 / 成功 / 警告 / 危险 四种语义色。"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        Layout.topMargin: 4
                        columns: 2
                        rowSpacing: 14
                        columnSpacing: 12

                        Quark.QuarkLabel {
                            Layout.preferredWidth: 50
                            text: "默认"
                        }

                        Quark.QuarkScrollBar {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            height: 14
                            orientation: Qt.Horizontal
                            size: 0.35
                            position: 0.15
                        }

                        Quark.QuarkLabel {
                            text: "成功"
                            accent: true
                        }

                        Quark.QuarkScrollBar {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            height: 14
                            orientation: Qt.Horizontal
                            size: 0.5
                            position: 0.1
                            handleColor: Quark.Palette.success
                        }

                        Quark.QuarkLabel {
                            text: "警告"
                            color: "#eab308"
                        }

                        Quark.QuarkScrollBar {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            height: 14
                            orientation: Qt.Horizontal
                            size: 0.25
                            position: 0.4
                            handleColor: "#eab308"
                        }

                        Quark.QuarkLabel {
                            text: "危险"
                            color: "#ef4444"
                        }

                        Quark.QuarkScrollBar {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            height: 14
                            orientation: Qt.Horizontal
                            size: 0.2
                            position: 0.7
                            handleColor: "#ef4444"
                        }

                    }

                }
            }
        }
    }
}
