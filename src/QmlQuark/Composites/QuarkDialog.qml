import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ".." as Quark

Popup {
    id: control

    property string title: ""
    property string acceptText: qsTr("确认")
    property string rejectText: qsTr("取消")
    property bool showAcceptButton: true
    property bool showRejectButton: true
    default property alias contentData: body.data

    signal accepted()
    signal rejected()

    modal: true
    focus: true
    padding: 20
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    width: 420

    Overlay.modal: Rectangle {
        color: Quark.Palette.overlay
    }

    background: Rectangle {
        radius: 22
        color: Quark.Palette.window
        border.width: 1
        border.color: Quark.Palette.border
    }

    contentItem: ColumnLayout {
        spacing: 16

        Text {
            Layout.fillWidth: true
            visible: control.title.length > 0
            text: control.title
            color: Quark.Palette.text
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.xl
            font.bold: true
            wrapMode: Text.Wrap
        }

        Column {
            id: body
            Layout.fillWidth: true
            spacing: 10
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Item {
                Layout.fillWidth: true
            }

            Quark.QuarkButton {
                visible: control.showRejectButton
                text: control.rejectText
                accentColor: Quark.Palette.surfaceAlt
                foregroundColor: Quark.Palette.text
                onClicked: {
                    control.rejected()
                    control.close()
                }
            }

            Quark.QuarkButton {
                visible: control.showAcceptButton
                text: control.acceptText
                onClicked: {
                    control.accepted()
                    control.close()
                }
            }
        }
    }
}
