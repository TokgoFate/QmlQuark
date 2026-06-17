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
        color: control.enabled ? Quark.Palette.surface : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: 1
        border.color: control.enabled ? Quark.Palette.border : Qt.darker(color, 1.08)
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
            color: control.enabled && (mouseArea.containsMouse || isSelected)
                   ? Quark.Palette.surfaceAlt
                   : "transparent"
            opacity: control.enabled ? 1.0 : 0.7

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 12
                anchors.right: parent.right
                anchors.rightMargin: 12
                text: typeof modelData === "string" ? modelData : (modelData.text || "")
                color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.md
                elide: Text.ElideRight
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                enabled: control.enabled
                hoverEnabled: control.enabled
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
