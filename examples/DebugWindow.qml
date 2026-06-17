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
        onAccepted: overviewPage.setDebugText(text)
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
                    text: "总览"
                }

                Quark.QuarkTabButton {
                    text: "基础控件"
                }

                Quark.QuarkTabButton {
                    text: "交互组合"
                }

                Quark.QuarkTabButton {
                    text: "滚动样式"
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

        Item {
            DebugOverview {
                id: overviewPage

                anchors.fill: parent

                onAlertRequested: debugAlert.open()
                onPromptRequested: debugPrompt.open()
            }
        }

        Item {
            ControlShowcase {
                anchors.fill: parent
            }
        }

        Item {
            Gallery {
                anchors.fill: parent

                onAlertRequested: galleryAlert.open()
                onPromptRequested: galleryPrompt.open()
            }
        }

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
