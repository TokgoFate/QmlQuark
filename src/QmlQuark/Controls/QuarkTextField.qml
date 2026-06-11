import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

TextField {
    id: control

    implicitWidth: 240
    implicitHeight: 44
    padding: 12
    color: Quark.Palette.text
    placeholderTextColor: Quark.Palette.textMuted
    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    selectionColor: Quark.Palette.accentSoft
    selectedTextColor: Quark.Palette.textOnAccent

    background: Rectangle {
        radius: 12
        color: Quark.Palette.surface
        border.width: control.activeFocus ? 2 : 1
        border.color: control.activeFocus ? Quark.Palette.accent : Quark.Palette.border
    }
}
