import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ".." as Quark

Pane {
    id: control

    property string title: ""
    // Keep card children inside the body column and avoid overriding Pane.contentData.
    default property alias bodyContent: body.data

    padding: 16

    background: Rectangle {
        radius: 18
        color: Quark.Palette.surface
        border.width: 1
        border.color: Quark.Palette.border
    }

    contentItem: ColumnLayout {
        spacing: 12
        width: control.availableWidth
        height: control.availableHeight

        Text {
            Layout.fillWidth: true
            visible: control.title.length > 0
            text: control.title
            color: Quark.Palette.text
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.lg
            font.bold: true
        }

        Item {
            id: bodyHost
            Layout.fillWidth: true
            Layout.fillHeight: true
            implicitWidth: body.implicitWidth
            implicitHeight: body.implicitHeight

            ColumnLayout {
                id: body
                anchors.fill: parent
                spacing: 8
            }
        }
    }
}
