import QtQuick 2.15
import ".." as Quark

Quark.QuarkDialog {
    id: control

    property alias message: messageLabel.text

    showRejectButton: false

    Text {
        id: messageLabel
        width: parent ? parent.width : implicitWidth
        color: Quark.Palette.textMuted
        font.family: Quark.Typography.family
        font.pixelSize: Quark.Typography.md
        wrapMode: Text.Wrap
    }
}
