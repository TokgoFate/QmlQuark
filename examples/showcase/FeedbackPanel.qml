import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Quark.QuarkCard {
    title: "反馈与样式"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 12

        RowLayout {
            spacing: 12

            Quark.QuarkBusyIndicator {
                running: true
            }

            Quark.QuarkBusyIndicator {
                running: true
                accentColor: Quark.Palette.success
                trackColor: Qt.darker(Quark.Palette.surfaceAlt, 1.15)
            }

            Quark.QuarkBusyIndicator {
                running: false
            }
        }

        RowLayout {
            spacing: 12

            Quark.QuarkIconButton {
                iconSource: "qrc:/Icons/chevron-down.svg"
            }

            Quark.QuarkIconButton {
                iconSource: "qrc:/Icons/chevron-down.svg"
                iconRotation: 180
                outlined: false
            }
        }

        Quark.QuarkLabel {
            text: "默认文本"
        }

        Quark.QuarkLabel {
            text: "强调文本"
            accent: true
        }

        Quark.QuarkLabel {
            text: "辅助文本"
            muted: true
        }

        Quark.QuarkLabel {
            Layout.preferredWidth: 160
            text: "工业设备监测面板数据显示完整路径"
            muted: true
        }
    }
}