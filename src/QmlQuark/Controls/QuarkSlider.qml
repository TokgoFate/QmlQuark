import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Slider {
    id: control

    implicitWidth: orientation === Qt.Horizontal ? 240 : 18
    implicitHeight: orientation === Qt.Horizontal ? 18 : 240

    // 垂直时反转
    readonly property real invertedPosition: orientation === Qt.Vertical ? 1 - control.visualPosition : control.visualPosition

    // 轨道背景
    background: Rectangle {
        x: orientation === Qt.Horizontal ? control.leftPadding : control.leftPadding + control.availableWidth / 2 - width / 2
        y: orientation === Qt.Horizontal ? control.topPadding + control.availableHeight / 2 - height / 2 : control.topPadding
        width: orientation === Qt.Horizontal ? control.availableWidth : 6
        height: orientation === Qt.Horizontal ? 6 : control.availableHeight
        radius: width / 2
        color: control.enabled ? Quark.Palette.surfaceAlt : Qt.darker(Quark.Palette.surfaceAlt, 1.04)

        // 已填充部分
        Rectangle {
            x: orientation === Qt.Horizontal ? 0 : parent.width / 2 - width / 2
            y: orientation === Qt.Horizontal ? 0 : parent.height - control.invertedPosition * parent.height
            width: orientation === Qt.Horizontal ? control.invertedPosition * parent.width : parent.width
            height: orientation === Qt.Horizontal ? parent.height : control.invertedPosition * parent.height
            radius: parent.radius
            color: control.enabled ? Quark.Palette.accent : Quark.Palette.disabled
        }
    }

    // 滑块手柄
    handle: Rectangle {
        x: orientation === Qt.Horizontal ? control.leftPadding + control.invertedPosition * (control.availableWidth - width) : control.leftPadding + control.availableWidth / 2 - width / 2
        y: orientation === Qt.Horizontal ? control.topPadding + control.availableHeight / 2 - height / 2 : control.topPadding + control.availableHeight - control.invertedPosition * (control.availableHeight - height) - height
        width: 18
        height: 18
        radius: width / 2
        color: control.enabled ? Quark.Palette.accent : Qt.lighter(Quark.Palette.disabled, 1.08)
        border.width: 2
        border.color: !control.enabled
                  ? Qt.darker(color, 1.08)
                  : (control.pressed ? Quark.Palette.accentSoft : Quark.Palette.border)

        scale: control.hovered || control.pressed ? 1.4 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }
}
