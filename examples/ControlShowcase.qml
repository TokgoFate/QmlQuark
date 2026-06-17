import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "showcase"

Item {
    id: showcaseRoot

    property int panelColumns: showcaseFlickable.width > 1240 ? 3 : (showcaseFlickable.width > 760 ? 2 : 1)
    property int matrixColumns: showcaseFlickable.width > 1320 ? 4 : (showcaseFlickable.width > 980 ? 3 : (showcaseFlickable.width > 700 ? 2 : 1))

    implicitWidth: 900
    implicitHeight: 700

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

            width: showcaseFlickable.width - 10
            spacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "基础控件矩阵"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 14

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "按类型重新拆分为输入、选择、反馈、导航四个区块。每个区块只保留同类控件，便于做视觉和交互回归。"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    GridLayout {
                        Layout.fillWidth: true
                        columns: showcaseRoot.matrixColumns
                        columnSpacing: 12
                        rowSpacing: 12

                        Repeater {
                            model: [
                                { title: "输入", desc: "TextField / TextArea / SpinBox" },
                                { title: "选择", desc: "CheckBox / Radio / Switch" },
                                { title: "反馈", desc: "Busy / Progress / Label" },
                                { title: "导航", desc: "Tab / PageIndicator / Dropdown" }
                            ]

                            delegate: Rectangle {
                                required property var modelData

                                Layout.fillWidth: true
                                implicitHeight: 76
                                radius: 12
                                color: Quark.Palette.surfaceAlt
                                border.width: 1
                                border.color: Quark.Palette.border

                                ColumnLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 4

                                    Quark.QuarkLabel {
                                        text: modelData.title
                                        font.bold: true
                                    }

                                    Quark.QuarkLabel {
                                        Layout.fillWidth: true
                                        text: modelData.desc
                                        muted: true
                                        wrapMode: Text.Wrap
                                    }
                                }
                            }
                        }
                    }
                }
            }

            GridLayout {
                Layout.fillWidth: true
                columns: showcaseRoot.panelColumns
                columnSpacing: 20
                rowSpacing: 20

                InputPanel {
                    Layout.fillWidth: true
                }

                SelectionPanel {
                    Layout.fillWidth: true
                }

                FeedbackPanel {
                    Layout.fillWidth: true
                }

                NavigationPreviewPanel {
                    Layout.fillWidth: true
                    Layout.columnSpan: showcaseRoot.panelColumns > 1 ? showcaseRoot.panelColumns : 1
                    matrixColumns: showcaseRoot.matrixColumns
                }
            }
        }
    }
}
