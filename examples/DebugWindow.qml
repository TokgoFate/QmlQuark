import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    visible: true
    width: 1180
    height: 820
    color: Quark.Palette.window
    title: "QmlQuark Debug UI"

    // ============================================================
    // 全局弹窗
    // ============================================================

    // --- 调试面板弹窗 ---
    Quark.QuarkAlertDialog {
        id: debugAlert

        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "调试提醒"
        message: "这是一条用于调试组件状态的提示。"
    }

    Quark.QuarkPromptDialog {
        id: debugPrompt

        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "调试输入"
        message: "请输入测试值以验证输入组件。"
        placeholderText: "调试内容"
        onAccepted: debugText.text = text
    }

    // --- 组件画廊弹窗 ---
    Quark.QuarkAlertDialog {
        id: galleryAlert

        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "删除提醒"
        message: "这是一个现代工业风格的提示弹窗示例。"
    }

    Quark.QuarkPromptDialog {
        id: galleryPrompt

        x: (root.width - width) / 2
        y: (root.height - height) / 2
        title: "输入名称"
        message: "请输入一个新的卡片名称。"
        placeholderText: "例如：设备看板"
    }

    // ============================================================
    // 顶部工具栏
    // ============================================================

    header: Quark.QuarkToolBar {

        RowLayout {
            anchors.fill: parent
            spacing: 12

            Label {
                text: "QmlQuark Debug"
                color: Quark.Palette.text
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.lg
                font.bold: true
            }

            TabBar {
                id: tabBar

                Layout.leftMargin: 24
                spacing: 4

                // TabBar ← SwipeView 双向同步：点击 Tab 或滑动 SwipeView 均能互相同步
                onCurrentIndexChanged: {
                    if (swipeView.currentIndex !== tabBar.currentIndex) {
                        swipeView.setCurrentIndex(tabBar.currentIndex)
                    }
                }

                background: Rectangle {
                    color: "transparent"
                }

                Quark.QuarkTabButton {
                    text: "调试面板"
                }

                Quark.QuarkTabButton {
                    text: "组件画廊"
                }

                Quark.QuarkTabButton {
                    text: "控件展台"
                }

                Quark.QuarkTabButton {
                    text: "滚动条示例"
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Quark.QuarkButton {
                visible: devTools ? devTools.reloadAvailable : false
                text: "Reload QML"
                onClicked: devTools.reloadUi()
            }
        }
    }

    // ============================================================
    // 主内容区：TabBar + SwipeView
    // ============================================================

    SwipeView {
        id: swipeView

        // SwipeView → TabBar 双向同步
        onCurrentIndexChanged: {
            if (tabBar.currentIndex !== swipeView.currentIndex) {
                tabBar.setCurrentIndex(swipeView.currentIndex)
            }
        }

        anchors.fill: parent

        // ---- Tab 0: 调试面板（内联） ----

        Item {
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 20

                Quark.QuarkCard {
                    Layout.preferredWidth: 320
                    Layout.fillHeight: true
                    title: "调试面板"

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Text {
                            text: "当前主题"
                            color: Quark.Palette.text
                            font.family: Quark.Typography.family
                            font.pixelSize: Quark.Typography.md
                            font.bold: true
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            height: 52
                            radius: 12
                            color: Quark.Palette.surfaceAlt
                            border.width: 1
                            border.color: Quark.Palette.border

                            Text {
                                anchors.centerIn: parent
                                text: "Accent: " + Quark.Palette.accent
                                color: Quark.Palette.text
                                font.family: Quark.Typography.family
                                font.pixelSize: Quark.Typography.sm
                            }
                        }

                        Quark.QuarkTextField {
                            id: debugText

                            Layout.fillWidth: true
                            placeholderText: "输入调试文本"
                        }

                        Quark.QuarkSelectBox {
                            Layout.fillWidth: true
                            model: ["模式 A", "模式 B", "模式 C"]
                        }

                        Quark.QuarkProgressBar {
                            Layout.fillWidth: true
                            value: slider.value
                        }

                        Quark.QuarkSlider {
                            id: slider
                            Layout.fillWidth: true
                            from: 0
                            to: 1
                            value: 0.45
                        }

                        Quark.QuarkSlider {
                            id: slider1

                            width: 18
                            height: 240
                            orientation: Qt.Vertical
                            from: 0
                            to: 1
                            value: 0.45
                        }
                    }
                }

                Quark.QuarkCard {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    title: "组件预览"

                    ColumnLayout {
                        width: parent.width
                        spacing: 12

                        Quark.QuarkButton {
                            id: debugBtn
                            text: "打开调试菜单"
                            onClicked: debugMenu.open()
                        }

                        Quark.QuarkDropdown {
                            id: debugMenu

                            y: debugBtn.height + 7
                            model: ["重载界面", "刷新数据", "打开日志"]
                        }

                        Item {
                            Layout.fillWidth: true
                            Layout.fillHeight: true

                            Quark.QuarkFileManager {
                                id: fileManager
                                anchors.fill: parent
                                currentPath: "./"
                                showSearch: true
                                showFileSize: true
                                onEntryDoubleClicked: function(entry, index) {
                                    console.log("双击:", entry.name);
                                }
                                Component.onCompleted: {
                                    console.info("size " + width + ", " + height);
                                }
                            }

                            Rectangle {
                                anchors.fill: fileManager
                                color: "yellow"
                                opacity: 0.2
                                visible: false
                            }
                        }
                    }
                }
            }
        }

        // ---- Tab 1: 组件画廊 ----

        Item {
            Gallery {
                anchors.fill: parent

                onAlertRequested: galleryAlert.open()
                onPromptRequested: galleryPrompt.open()
            }
        }

        // ---- Tab 2: 控件展台 ----

        Item {
            ControlShowcase {
                id: showcase
                anchors.fill: parent
            }
        }

        // ---- Tab 3: 工业风滚动条示例 ----

        Item {
            IndustrialScrollBar_Demo {
                anchors.fill: parent
            }
        }
    }

    // 页面指示器 — footer 区域，不遮挡 SwipeView 内容
    footer: Item {
        implicitHeight: 24

        Quark.QuarkPageIndicator {
            id: pageDots
            count: swipeView.count
            currentIndex: swipeView.currentIndex
            anchors.centerIn: parent
        }
    }
}
