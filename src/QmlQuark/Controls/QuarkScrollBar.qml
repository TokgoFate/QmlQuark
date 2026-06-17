import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

/*
 * 极简滚动条 — 透明轨道 + 6px 圆角药丸手柄
 *
 * 重叠问题解决方案：
 *   1. 优先使用 ScrollView（会自动为滚动条预留空间，不重叠）
 *   2. 若使用 Flickable，内容区域需预留滚动条宽度（如 rightMargin: 10）
 *   3. 本组件极细（6px）且半透明（idle: 0.35），重叠时侵入感很低
 */

ScrollBar {
    id: control

    // ---- 可定制属性 ----
    property color handleColor: Quark.Palette.accent
    readonly property color resolvedHandleColor: control.enabled ? handleColor : Quark.Palette.disabled

    // ---- 默认策略：始终显示极细条（使用者可按需覆盖） ----
    policy: ScrollBar.AlwaysOn

    // ---- 极简尺寸 ----
    padding: 0
    implicitWidth: orientation === Qt.Vertical ? 6 : 40
    implicitHeight: orientation === Qt.Vertical ? 40 : 6

    // ---- 轨道：完全透明（不绘制） ----
    background: Item {}

    // ---- 手柄：圆角药丸 ----
    contentItem: Rectangle {
        id: handle

        implicitWidth: control.orientation === Qt.Vertical ? 6 : 24
        implicitHeight: control.orientation === Qt.Vertical ? 24 : 6
        radius: 3
        color: control.resolvedHandleColor

        // 交互态透明度：idle → hover → pressed
        opacity: !control.enabled ? 0.2 : (control.pressed ? 1.0 : (control.hovered ? 0.70 : 0.35))

        Behavior on opacity {
            NumberAnimation { duration: 180 }
        }
    }
}
