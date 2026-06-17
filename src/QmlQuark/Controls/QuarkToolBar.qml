import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ToolBar {
    id: control

    leftPadding: 12
    rightPadding: 12
    implicitHeight: 56

    background: Rectangle {
        color: control.enabled ? Quark.Palette.surface : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: 1
        border.color: control.enabled ? Quark.Palette.border : Qt.darker(color, 1.08)
    }
}
