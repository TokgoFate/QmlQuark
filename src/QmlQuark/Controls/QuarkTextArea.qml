import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

TextArea {
    id: control

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    leftPadding: 14
    rightPadding: 14
    topPadding: 12
    bottomPadding: 12

    color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
    placeholderTextColor: control.enabled ? Quark.Palette.textMuted : Quark.Palette.disabled
    selectedTextColor: Quark.Palette.textOnAccent
    selectionColor: Quark.Palette.accent

    background: Rectangle {
        radius: 12
        color: control.enabled
               ? Quark.Palette.surface
               : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: control.activeFocus ? 2 : 1
        border.color: control.enabled
                      ? (control.activeFocus ? Quark.Palette.accent : Quark.Palette.border)
                      : Qt.darker(color, 1.08)

        Behavior on border.color {
            ColorAnimation { duration: 150 }
        }
        Behavior on border.width {
            NumberAnimation { duration: 150 }
        }
    }
}
