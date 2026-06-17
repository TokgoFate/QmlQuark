import ".." as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Switch {
    id: control

    property bool showText: true

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    spacing: 8
    leftPadding: 2
    rightPadding: 2
    readonly property real textImplicitWidth: showText
                                            ? Math.max(0, contentItem.implicitWidth - contentItem.leftPadding)
                                            : 0
    // 显式计算 implicitWidth，预留 4px 缓冲吸收字体 hinting 差异
    implicitWidth: Math.max(48, leftPadding + indicator.implicitWidth + (showText ? spacing + textImplicitWidth : 0) + rightPadding + 4)
    implicitHeight: Math.max(28, indicator.implicitHeight + topPadding + bottomPadding)
    Layout.minimumWidth: implicitWidth

    // 指示器：轨道 + 滑块
    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        radius: 13
        color: !control.enabled ? Qt.darker(Quark.Palette.surfaceAlt, 1.02) : control.checked ? (control.down ? Qt.darker(Quark.Palette.accent, 1.1) : (control.hovered ? Qt.lighter(Quark.Palette.accent, 1.04) : Quark.Palette.accent)) : (control.down ? Qt.darker(Quark.Palette.surfaceAlt, 1.1) : (control.hovered ? Qt.lighter(Quark.Palette.surfaceAlt, 1.05) : Qt.darker(Quark.Palette.surfaceAlt, 1.08)))
        border.width: control.visualFocus ? 2 : 1
        border.color: !control.enabled ? Qt.darker(color, 1.1) : control.checked ? (control.visualFocus ? Qt.lighter(Quark.Palette.accent, 1.1) : Qt.darker(Quark.Palette.accent, 1.12)) : (control.visualFocus ? Quark.Palette.accent : Quark.Palette.border)

        // 圆形滑块
        Rectangle {
            anchors.centerIn: knob
            width: knob.width + 6
            height: knob.height + 6
            radius: width / 2
            color: Quark.Palette.accentSoft
            opacity: control.checked ? (control.down ? 0.14 : 0.1) : 0
            scale: control.checked ? 1 : 0.92
            z: -1

            Behavior on opacity {
                NumberAnimation {
                    duration: 140
                }

            }

            Behavior on scale {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }

            }

        }

        Rectangle {
            id: knob

            width: 22
            height: 22
            radius: 11
            x: control.checked ? parent.width - width - 2 : 2
            y: (parent.height - height) / 2
            color: !control.enabled ? Qt.lighter(Quark.Palette.disabled, 1.08) : control.down ? Qt.darker("#eef4f8", 1.04) : (control.hovered ? Qt.lighter("#f6f9fc", 1.02) : "#eef4f8")
            border.width: 1
            border.color: !control.enabled ? Qt.darker(color, 1.08) : control.visualFocus ? Quark.Palette.accent : Qt.darker(color, 1.14)
            scale: control.down ? 0.97 : (control.checked ? 1.01 : 1)

            Behavior on x {
                NumberAnimation {
                    duration: 180
                    easing.type: Easing.OutCubic
                }

            }

            Behavior on scale {
                NumberAnimation {
                    duration: 160
                    easing.type: Easing.OutCubic
                }

            }

            Behavior on color {
                ColorAnimation {
                    duration: 120
                }

            }

            Behavior on border.color {
                ColorAnimation {
                    duration: 120
                }

            }

        }

        Behavior on color {
            ColorAnimation {
                duration: 160
            }

        }

        Behavior on border.color {
            ColorAnimation {
                duration: 160
            }

        }

    }

    contentItem: Text {
        text: control.showText ? control.text : ""
        visible: control.showText
        color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
        font: control.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        leftPadding: control.indicator.width + control.spacing
    }

}
