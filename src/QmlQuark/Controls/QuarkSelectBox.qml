import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ComboBox {
    id: control

    implicitWidth: 220
    implicitHeight: 44
    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: modelData
            color: Quark.Palette.text
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.md
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: highlighted ? Quark.Palette.surfaceAlt : Quark.Palette.surface
        }
    }

    indicator: Text {
        text: "⌄"
        color: Quark.Palette.textMuted
        font.family: Quark.Typography.family
        font.pixelSize: Quark.Typography.lg
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.verticalCenter: parent.verticalCenter
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
