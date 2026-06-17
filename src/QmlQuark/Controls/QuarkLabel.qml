import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Label {
    id: control

    property bool muted: false
    property bool accent: false

    // MouseArea 检测悬停
    MouseArea {
        id: labelMouse
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }

    // 隐式宽度 > 实际宽度 = 文本被截断
    readonly property bool truncated:
        text.length > 0 && implicitWidth > width + 1

    color: !control.enabled
            ? Quark.Palette.disabled
           : control.accent
             ? Quark.Palette.accent
             : control.muted
               ? Quark.Palette.textMuted
               : Quark.Palette.text
    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    elide: Text.ElideRight

    // 使用 Quark 主题 Tooltip
    Quark.QuarkToolTip {
        visible: control.truncated && labelMouse.containsMouse
        text: control.text
        delay: 500
    }
}
