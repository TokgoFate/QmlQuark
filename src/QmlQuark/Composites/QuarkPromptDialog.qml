import QtQuick 2.15
import ".." as Quark

Quark.QuarkDialog {
    id: control

    property alias text: inputField.text
    property alias placeholderText: inputField.placeholderText

    Quark.QuarkTextField {
        id: inputField
        width: parent ? parent.width : implicitWidth
    }
}
