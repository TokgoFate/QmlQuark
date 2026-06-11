import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Popup {
    id: control

    property var model: []
    property int currentIndex: -1
    signal activated(int index, string value)

    padding: 6
    implicitWidth: 220
    implicitHeight: Math.min(280, listView.contentHeight + (padding * 2))

    background: Rectangle {
        radius: 14
        color: Quark.Palette.surface
        border.width: 1
        border.color: Quark.Palette.border
    }

    contentItem: ListView {
        id: listView
        clip: true
        model: control.model
        spacing: 4

        delegate: Rectangle {
            property bool isSelected: index === control.currentIndex

            width: listView.width
            height: 40
            radius: 10
            color: mouseArea.containsMouse || isSelected ? Quark.Palette.surfaceAlt : "transparent"

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.right: parent.right
                anchors.rightMargin: 12
                text: typeof modelData === "string" ? modelData : (modelData.text || "")
                color: Quark.Palette.text
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.md
                elide: Text.ElideRight
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    var value = typeof modelData === "string" ? modelData : (modelData.text || "")
                    control.currentIndex = index
                    control.activated(index, value)
                    control.close()
                }
            }
        }
    }
}
