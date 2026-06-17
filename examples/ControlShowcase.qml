import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: showcaseRoot

    property int selectedMode: 0
    property int previewTabIndex: 0
    property bool compactCards: showcaseFlickable.width < 1040
    property int showcaseColumns: showcaseFlickable.width > 1260 ? 3 : (showcaseFlickable.width > 760 ? 2 : 1)

    implicitWidth: 900
    implicitHeight: 700

    Flickable {
        id: showcaseFlickable

        anchors.fill: parent
        anchors.margins: 20
        contentWidth: width
        contentHeight: contentColumn.height
        clip: true

        ScrollBar.vertical: Quark.QuarkScrollBar {
            anchors.right: parent.right
            anchors.rightMargin: 4
        }

        ColumnLayout {
            id: contentColumn

            width: showcaseFlickable.width - 10
            height: implicitHeight
            spacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "状态与反馈"

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 18

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Quark.QuarkLabel {
                            text: "加载状态"
                            font.bold: true
                        }

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

                        Quark.QuarkLabel {
                            text: "标签色板"
                            font.bold: true
                        }

                        RowLayout {
                            spacing: 12

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
                        }

                        Quark.QuarkLabel {
                            text: "截断 Tooltip"
                            font.bold: true
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 6

                            Quark.QuarkLabel {
                                Layout.preferredWidth: 120
                                text: "这段文字超长会被截断显示省略号"
                                accent: true
                            }

                            Quark.QuarkLabel {
                                Layout.preferredWidth: 100
                                text: "QmlQuark Control Showcase Label Truncate Demo"
                            }

                            Quark.QuarkLabel {
                                Layout.preferredWidth: 160
                                text: "工业设备监测面板数据显示完整路径"
                                muted: true
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 10

                        Quark.QuarkLabel {
                            text: "图标按钮"
                            font.bold: true
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
                            text: "进度状态"
                            font.bold: true
                        }

                        Quark.QuarkProgressBar {
                            Layout.fillWidth: true
                            value: 0.72
                        }
                    }
                }
            }

            GridLayout {
                Layout.fillWidth: true
                columns: compactCards ? 1 : 2
                columnSpacing: 20
                rowSpacing: 20

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "选择控件"

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

                        Rectangle {
                            Layout.fillWidth: true
                            implicitHeight: 1
                            color: Quark.Palette.border
                            opacity: 0.8
                        }

                        Quark.QuarkLabel {
                            text: "开关控件"
                            font.bold: true
                        }

                        Flow {
                            Layout.fillWidth: true
                            width: parent.width
                            spacing: 16

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

                        Quark.QuarkLabel {
                            text: "运行模式"
                            font.bold: true
                        }

                        Quark.QuarkRadioButton {
                            text: "巡检模式"
                            checked: showcaseRoot.selectedMode === 0
                            onClicked: showcaseRoot.selectedMode = 0
                        }

                        Quark.QuarkRadioButton {
                            text: "维护模式"
                            checked: showcaseRoot.selectedMode === 1
                            onClicked: showcaseRoot.selectedMode = 1
                        }

                        Quark.QuarkRadioButton {
                            text: "离线模式"
                            checked: showcaseRoot.selectedMode === 2
                            onClicked: showcaseRoot.selectedMode = 2
                        }

                        Quark.QuarkLabel {
                            text: "分页指示器"
                            font.bold: true
                        }

                        Quark.QuarkPageIndicator {
                            count: 5
                            currentIndex: 2
                        }
                    }
                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    title: "输入控件"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkTextField {
                            Layout.fillWidth: true
                            placeholderText: "输入设备名称"
                        }

                        GridLayout {
                            Layout.fillWidth: true
                            columns: showcaseColumns
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
                            Layout.fillWidth: true
                            from: 0
                            to: 100
                            value: 64
                        }

                        Quark.QuarkTextArea {
                            Layout.fillWidth: true
                            implicitHeight: 72
                            placeholderText: "多行输入（备注信息）"
                        }
                    }
                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    Layout.columnSpan: compactCards ? 1 : 2
                    title: "控件预览"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 16

                        TabBar {
                            Layout.fillWidth: true
                            currentIndex: showcaseRoot.previewTabIndex

                            background: Rectangle {
                                color: "transparent"
                            }

                            onCurrentIndexChanged: showcaseRoot.previewTabIndex = currentIndex

                            Quark.QuarkTabButton {
                                text: "常规态"
                            }

                            Quark.QuarkTabButton {
                                text: "Disabled"
                            }
                        }

                        StackLayout {
                            Layout.fillWidth: true
                            currentIndex: showcaseRoot.previewTabIndex

                            Item {
                                implicitHeight: normalPreview.implicitHeight

                                ColumnLayout {
                                    id: normalPreview

                                    width: parent.width
                                    spacing: 12

                                    GridLayout {
                                        width: parent.width
                                        columns: showcaseColumns
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
                            }

                            Item {
                                implicitHeight: disabledPreview.implicitHeight

                                ColumnLayout {
                                    id: disabledPreview

                                    width: parent.width
                                    spacing: 12

                                    GridLayout {
                                        width: parent.width
                                        columns: showcaseColumns
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

                                        Quark.QuarkTabButton {
                                            text: "禁用页签"
                                            enabled: false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Quark.QuarkCard {
                Layout.fillWidth: true
                Layout.minimumHeight: 280
                title: "滚动与边界"

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 16

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumHeight: 220
                        radius: 14
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border
                        clip: true

                        ListView {
                            anchors.fill: parent
                            anchors.margins: 10
                            model: 24
                            spacing: 8
                            clip: true

                            ScrollBar.vertical: Quark.QuarkScrollBar {
                                handleColor: Quark.Palette.accentSoft
                            }

                            delegate: Rectangle {
                                required property int index

                                width: ListView.view.width - 8
                                height: 44
                                radius: 10
                                color: index % 2 === 0 ? Quark.Palette.surface : Qt.darker(Quark.Palette.surface, 1.08)
                                border.width: 1
                                border.color: Quark.Palette.border

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.leftMargin: 12
                                    anchors.rightMargin: 12

                                    Quark.QuarkLabel {
                                        Layout.fillWidth: true
                                        text: "监测通道 " + (index + 1)
                                    }

                                    Quark.QuarkLabel {
                                        text: index % 3 === 0 ? "ACTIVE" : "STANDBY"
                                        accent: index % 3 === 0
                                        muted: index % 3 !== 0
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        Layout.preferredWidth: 220
                        Layout.fillHeight: true
                        Layout.minimumHeight: 220
                        radius: 14
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 14
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "滚动条定制"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                text: "验证垂直/水平极简滚动条，外部放置避免角落重叠。"
                                muted: true
                                wrapMode: Text.Wrap
                                Layout.fillWidth: true
                            }

                            Flickable {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                contentWidth: 420
                                contentHeight: 320
                                clip: true

                                ScrollBar.vertical: Quark.QuarkScrollBar {
                                    handleColor: Quark.Palette.success
                                }

                                ScrollBar.horizontal: Quark.QuarkScrollBar {
                                    handleColor: Quark.Palette.accent
                                }

                                Rectangle {
                                    width: 420
                                    height: 320
                                    radius: 12
                                    color: Quark.Palette.surface
                                    border.width: 1
                                    border.color: Quark.Palette.border

                                    Repeater {
                                        model: 18

                                        Rectangle {
                                            required property int index

                                            x: 16 + (index % 3) * 130
                                            y: 16 + Math.floor(index / 3) * 48
                                            width: 112
                                            height: 32
                                            radius: 8
                                            color: Qt.darker(Quark.Palette.surfaceAlt, 1 + (index % 2) * 0.08)
                                            border.width: 1
                                            border.color: Quark.Palette.border

                                            Quark.QuarkLabel {
                                                anchors.centerIn: parent
                                                text: "NODE-" + (index + 1)
                                                font.pixelSize: Quark.Typography.sm
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
