import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

PageIndicator {
    id: control

    interactive: true
    spacing: 8

    delegate: Rectangle {
        // PageIndicator 通过 index 属性识别当前页
        required property int index

        width: control.currentIndex === index ? 24 : 8
        height: 8
        radius: 4
         color: !control.enabled
             ? (control.currentIndex === index ? Quark.Palette.disabled : Qt.lighter(Quark.Palette.disabled, 1.18))
             : (control.currentIndex === index ? Quark.Palette.accent : Qt.darker(Quark.Palette.surfaceAlt, 1.1))
         opacity: control.enabled ? 1.0 : 0.8

        Behavior on width {
            NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
        }
        Behavior on color {
            ColorAnimation { duration: 180 }
        }
    }
}
