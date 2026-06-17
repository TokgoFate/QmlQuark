import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

TextField {
    id: control

    implicitWidth: 240
    implicitHeight: 44
    padding: 12
    color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
    placeholderTextColor: control.enabled ? Quark.Palette.textMuted : Quark.Palette.disabled
    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    selectionColor: Quark.Palette.accentSoft
    selectedTextColor: Quark.Palette.textOnAccent

    background: Rectangle {
        radius: 12
        color: control.enabled ? Quark.Palette.surface : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: control.activeFocus ? 2 : 1
        border.color: control.enabled
                      ? (control.activeFocus ? Quark.Palette.accent : Quark.Palette.border)
                      : Qt.darker(color, 1.08)
    }
}
