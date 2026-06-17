import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Quark.QuarkCard {
    id: root

    property alias sliderValue: inputSlider.value

    title: "输入与数值"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 12

        Quark.QuarkTextField {
            Layout.fillWidth: true
            placeholderText: "输入设备名称"
        }

        Quark.QuarkTextArea {
            Layout.fillWidth: true
            implicitHeight: 78
            placeholderText: "多行输入（备注信息）"
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 2
            columnSpacing: 12
            rowSpacing: 12

            Quark.QuarkSpinBox {
                Layout.fillWidth: true
                from: 0
                to: 120
                value: 24
            }

            Quark.QuarkSelectBox {
                Layout.fillWidth: true
                model: ["工业主题", "暗色主题", "调试主题"]
            }
        }

        Quark.QuarkSlider {
            id: inputSlider

            Layout.fillWidth: true
            from: 0
            to: 100
            value: 64
        }

        Quark.QuarkProgressBar {
            Layout.fillWidth: true
            value: inputSlider.value / 100
        }
    }
}