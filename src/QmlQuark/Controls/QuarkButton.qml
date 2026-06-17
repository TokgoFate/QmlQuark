import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Button {
    id: control

    property color accentColor: Quark.Palette.accent
    property color foregroundColor: control.enabled ? Quark.Palette.textOnAccent : Quark.Palette.disabled

    implicitWidth: Math.max(120, implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: 40
    leftPadding: 16
    rightPadding: 16
    topPadding: 10
    bottomPadding: 10

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md

    background: Rectangle {
        radius: 12
        color: !control.enabled
                             ? Qt.darker(Quark.Palette.surfaceAlt, 1.02)
               : control.down
                 ? Qt.darker(control.accentColor, 1.18)
                 : control.hovered
                   ? Qt.lighter(control.accentColor, 1.08)
                   : control.accentColor
        border.width: 1
                border.color: !control.enabled ? Qt.darker(color, 1.08) : Qt.darker(color, 1.15)
    }

    contentItem: Text {
        text: control.text
        color: control.foregroundColor
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
