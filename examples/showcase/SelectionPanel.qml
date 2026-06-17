import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Quark.QuarkCard {
    id: root

    property int selectedMode: 0

    title: "选择与开关"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 12

        Quark.QuarkCheckBox {
            text: "启用实时刷新"
            checked: true
        }

        Quark.QuarkCheckBox {
            text: "将日志输出到状态面板"
            checkState: Qt.PartiallyChecked
        }

        Flow {
            Layout.fillWidth: true
            width: parent.width
            spacing: 14

            Quark.QuarkSwitch {
                text: "启用通知"
                checked: true
            }

            Quark.QuarkSwitch {
                text: "静默模式"
            }

            Quark.QuarkSwitch {
                text: "隐藏文本"
                showText: false
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: 1
            color: Quark.Palette.border
            opacity: 0.8
        }

        Quark.QuarkRadioButton {
            text: "巡检模式"
            checked: root.selectedMode === 0
            onClicked: root.selectedMode = 0
        }

        Quark.QuarkRadioButton {
            text: "维护模式"
            checked: root.selectedMode === 1
            onClicked: root.selectedMode = 1
        }

        Quark.QuarkRadioButton {
            text: "离线模式"
            checked: root.selectedMode === 2
            onClicked: root.selectedMode = 2
        }
    }
}