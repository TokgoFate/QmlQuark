import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Menu {
    id: control

    font.family: Quark.Typography.family
    font.pixelSize: Quark.Typography.md
    topPadding: 6
    bottomPadding: 6
    leftPadding: 4
    rightPadding: 4
    implicitWidth: 180

    // 上下文菜单标准关闭策略：Esc / 点击外部 / 释放外部均关闭
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside | Popup.CloseOnReleaseOutside

    // 用 Action + delegate 模式（Qt 官方推荐），避免子 MenuItem 声明不被识别
    delegate: Quark.QuarkMenuItem { }

    background: Rectangle {
        radius: 14
        color: control.enabled ? Quark.Palette.surface : Qt.darker(Quark.Palette.surfaceAlt, 1.02)
        border.width: 1
        border.color: control.enabled ? Quark.Palette.border : Qt.darker(color, 1.08)

        // 微阴影感：内缩 1px 的暗边
        Rectangle {
            anchors.fill: parent
            anchors.margins: 1
            radius: 13
            color: "transparent"
            border.width: 1
            border.color: control.enabled ? Qt.darker(Quark.Palette.border, 1.05) : Qt.darker(parent.color, 1.06)
        }
    }
}
