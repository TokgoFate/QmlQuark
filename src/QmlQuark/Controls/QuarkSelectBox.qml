import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ComboBox {
    id: control

    implicitWidth: 220
    implicitHeight: 44
    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md

    delegate: Rectangle {
        property bool isSelected: index === control.highlightedIndex

        width: ListView.view ? ListView.view.width : control.width
        height: 40
        radius: 10
        color: mouseArea.containsMouse ? Quark.Palette.surfaceAlt : "transparent"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.right: parent.right
            anchors.rightMargin: 12
            text: typeof modelData === "string" ? modelData : (modelData.text || "")
            color: isSelected ? Quark.Palette.accent : Quark.Palette.text
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.md
            elide: Text.ElideRight
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                control.currentIndex = index;
                control.popup.close();
            }
        }
    }

    indicator: Image {
        width: 16
        height: 16
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/Icons/chevron-down.svg"
        fillMode: Image.PreserveAspectFit
        // color: Quark.Palette.textMuted
    }

    contentItem: Text {
        leftPadding: 12
        rightPadding: 36
        text: control.displayText
        color: Quark.Palette.text
        font: control.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        radius: 12
        color: Quark.Palette.surface
        border.width: control.visualFocus ? 2 : 1
        border.color: control.visualFocus ? Quark.Palette.accent : Quark.Palette.border
    }

    popup: Popup {
        y: control.height + 6
        width: control.width
        padding: 4
        background: Rectangle {
            radius: 14
            color: Quark.Palette.surface
            border.width: 1
            border.color: Quark.Palette.border
        }
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
        }
    }
}
