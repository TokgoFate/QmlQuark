import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Pane {
    id: control

    property string title: ""
    default property alias contentData: body.data

    padding: 16

    background: Rectangle {
        radius: 18
        color: Quark.Palette.surface
        border.width: 1
        border.color: Quark.Palette.border
    }

    contentItem: Column {
        spacing: 12
        width: control.availableWidth

        Text {
            visible: control.title.length > 0
            text: control.title
            color: Quark.Palette.text
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.lg
            font.bold: true
        }

        Column {
            id: body
            spacing: 8
            width: parent.width
        }
    }
}
