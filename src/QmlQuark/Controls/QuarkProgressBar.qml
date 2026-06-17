import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ProgressBar {
    id: control

    implicitWidth: 240
    implicitHeight: 18

    background: Rectangle {
        radius: height / 2
        color: control.enabled ? Quark.Palette.surfaceAlt : Qt.darker(Quark.Palette.surfaceAlt, 1.04)
    }

    contentItem: Item {
        Rectangle {
            width: control.visualPosition * parent.width
            height: parent.height
            radius: height / 2
            color: control.enabled ? Quark.Palette.accent : Quark.Palette.disabled
        }
    }
}
