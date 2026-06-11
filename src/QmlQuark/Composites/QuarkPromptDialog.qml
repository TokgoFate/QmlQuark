import QtQuick 2.15
import ".." as Quark

Quark.QuarkDialog {
    id: control

    property string message: ""
    property alias text: inputField.text
    property alias placeholderText: inputField.placeholderText

    Text {
        visible: control.message.length > 0
        width: parent ? parent.width : implicitWidth
        text: control.message
        color: Quark.Palette.textMuted
        font.family: Quark.Typography.family
        font.pixelSize: Quark.Typography.md
        wrapMode: Text.Wrap
    }

    Quark.QuarkTextField {
        id: inputField
        width: parent ? parent.width : implicitWidth
    }
}
