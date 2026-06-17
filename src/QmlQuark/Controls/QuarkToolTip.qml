import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ToolTip {
    id: control

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.sm
    leftPadding: 12
    rightPadding: 12
    topPadding: 8
    bottomPadding: 8

    background: Rectangle {
        radius: 8
        color: control.enabled ? Quark.Palette.surface : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: 1
        border.color: control.enabled ? Quark.Palette.border : Qt.darker(color, 1.08)
    }

    contentItem: Text {
        text: control.text
        color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
        font: control.font
        wrapMode: Text.NoWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
