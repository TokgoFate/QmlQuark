import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Quark.QuarkCard {
    id: root

    property int previewTabIndex: 0
    property int matrixColumns: 3

    title: "导航与状态预览"

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 16

        TabBar {
            Layout.fillWidth: true
            currentIndex: root.previewTabIndex

            background: Rectangle {
                color: "transparent"
            }

            onCurrentIndexChanged: root.previewTabIndex = currentIndex

            Quark.QuarkTabButton {
                text: "常规态"
            }

            Quark.QuarkTabButton {
                text: "Disabled"
            }
        }

        StackLayout {
            Layout.fillWidth: true
            currentIndex: root.previewTabIndex

            Item {
                implicitHeight: regularMatrix.implicitHeight

                GridLayout {
                    id: regularMatrix

                    width: parent.width
                    columns: root.matrixColumns
                    columnSpacing: 12
                    rowSpacing: 12

                    Quark.QuarkButton {
                        Layout.fillWidth: true
                        text: "开始巡检"
                    }

                    Quark.QuarkTextField {
                        Layout.fillWidth: true
                        text: "设备名称"
                    }

                    Quark.QuarkSelectBox {
                        Layout.fillWidth: true
                        model: ["工业主题", "暗色主题", "调试主题"]
                        currentIndex: 0
                    }

                    Quark.QuarkCheckBox {
                        text: "启用复选框"
                        checked: true
                    }

                    Quark.QuarkSwitch {
                        text: "启用开关"
                        checked: true
                    }

                    Quark.QuarkSlider {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        value: 52
                    }

                    Quark.QuarkBusyIndicator {
                        running: true
                    }

                    Quark.QuarkProgressBar {
                        Layout.fillWidth: true
                        value: 0.58
                    }

                    Quark.QuarkPageIndicator {
                        count: 4
                        currentIndex: 1
                    }
                }
            }

            Item {
                implicitHeight: disabledMatrix.implicitHeight

                GridLayout {
                    id: disabledMatrix

                    width: parent.width
                    columns: root.matrixColumns
                    columnSpacing: 12
                    rowSpacing: 12

                    Quark.QuarkButton {
                        Layout.fillWidth: true
                        text: "禁用按钮"
                        enabled: false
                    }

                    Quark.QuarkTextField {
                        Layout.fillWidth: true
                        text: "禁用输入框"
                        enabled: false
                    }

                    Quark.QuarkSelectBox {
                        Layout.fillWidth: true
                        model: ["工业主题", "暗色主题", "调试主题"]
                        currentIndex: 2
                        enabled: false
                    }

                    Quark.QuarkCheckBox {
                        text: "禁用复选框"
                        checked: true
                        enabled: false
                    }

                    Quark.QuarkSwitch {
                        text: "禁用开关"
                        checked: true
                        enabled: false
                    }

                    Quark.QuarkSlider {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        value: 52
                        enabled: false
                    }

                    Quark.QuarkBusyIndicator {
                        running: true
                        enabled: false
                    }

                    Quark.QuarkProgressBar {
                        Layout.fillWidth: true
                        value: 0.58
                        enabled: false
                    }

                    Quark.QuarkPageIndicator {
                        count: 4
                        currentIndex: 1
                        enabled: false
                    }
                }
            }
        }
    }
}