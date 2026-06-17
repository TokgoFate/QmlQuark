import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

TabButton {
    id: control

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md

    topPadding: 10
    bottomPadding: 10
    leftPadding: 16
    rightPadding: 16

    // 预计算颜色为属性，避免 Qt.darker() 每次返回新对象导致 Behavior 误触发
    readonly property color bgNormal: "transparent"
    readonly property color bgHovered: Qt.darker(Quark.Palette.surface, 1.03)
    readonly property color bgChecked: Qt.darker(Quark.Palette.surface, 1.06)
    readonly property color bgDisabled: Qt.darker(Quark.Palette.surfaceAlt, 1.02)

    contentItem: Text {
        text: control.text
        // 直接绑定，不做逐色动画（避免临近按钮被 Behavior 波及产生闪烁）
        color: !control.enabled
               ? Quark.Palette.disabled
               : (control.checked ? Quark.Palette.accent : Quark.Palette.textMuted)
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 10
        // 颜色引用预计算属性，稳定值引用，不会在无关属性变化时误触发 Behavior
        color: !control.enabled ? control.bgDisabled
               : control.checked ? control.bgChecked
               : (control.hovered ? control.bgHovered : control.bgNormal)

        // 底部高亮指示条 — 仅此用动画，opacity 动画稳定可靠
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.6
            height: 2
            radius: 1
            color: control.enabled ? Quark.Palette.accent : Quark.Palette.disabled
            opacity: !control.enabled ? 0.0 : (control.checked ? 1.0 : (control.hovered ? 0.4 : 0.0))

            Behavior on opacity {
                NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
            }
        }
    }
}
