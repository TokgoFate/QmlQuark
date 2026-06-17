import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

MenuItem {
    id: control

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    implicitHeight: 40
    leftPadding: 14
    rightPadding: 14

    contentItem: Text {
        text: control.text
        color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
        font: control.font
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        radius: 8
        color: control.highlighted
               ? Quark.Palette.surfaceAlt
               : "transparent"
        border.width: 0

        Behavior on color {
            ColorAnimation { duration: 120 }
        }
    }

    // 箭头子菜单指示器
    arrow: Quark.QuarkLabel {
        text: "▸"
        font.pixelSize: Quark.Typography.sm
        color: control.enabled ? Quark.Palette.textMuted : Quark.Palette.disabled
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8
    }
}
