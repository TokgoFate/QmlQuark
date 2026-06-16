import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QmlQuark 1.0 as Quark

/*
 * 工业风格滚动条使用示例
 * 演示如何在实际项目中使用该滚动条
 */

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Industrial ScrollBar Demo"

    // 深色工业背景
    color: "#0f0f12"

    // ============================================
    // 垂直滚动区域示例
    // ============================================

    ScrollView {
        id: verticalScrollView
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: 20
        }
        width: 300

        // 使用自定义工业风格滚动条
        ScrollBar.vertical: Quark.QuarkScrollBar {
            // 可以覆盖默认颜色
            handleAccentColor: "#ff6b35"  // 亮橙色
        }

        // 内容区域
        Column {
            spacing: 10
            padding: 15

            Repeater {
                model: 50

                Rectangle {
                    width: 250
                    height: 60
                    color: "#1e1e24"
                    radius: 4
                    border.color: "#2d2d35"
                    border.width: 1

                    // 工业风格内容项
                    Row {
                        anchors.centerIn: parent
                        spacing: 12

                        // 状态指示灯
                        Rectangle {
                            width: 12
                            height: 12
                            radius: 2
                            color: index % 3 === 0 ? "#e85d04" : "#4a4a52"

                            // 发光效果
                            Rectangle {
                                anchors.centerIn: parent
                                width: 16
                                height: 16
                                color: parent.color
                                opacity: 0.3
                                radius: 3
                            }
                        }

                        Text {
                            text: "System Module " + (index + 1)
                            color: "#c0c0c8"
                            font.pixelSize: 14
                            font.family: "Consolas, monospace"
                        }

                        Text {
                            text: index % 2 === 0 ? "[ACTIVE]" : "[STANDBY]"
                            color: index % 2 === 0 ? "#4ade80" : "#6b7280"
                            font.pixelSize: 12
                            font.family: "Consolas, monospace"
                        }
                    }
                }
            }
        }
    }

    // ============================================
    // 水平滚动区域示例
    // ============================================

    Rectangle {
        anchors {
            left: verticalScrollView.right
            right: parent.right
            top: parent.top
            margins: 20
        }
        height: 200
        color: "#1a1a1e"
        radius: 4
        border.color: "#2d2d35"
        border.width: 1

        // 标题
        Text {
            anchors {
                top: parent.top
                left: parent.left
                margins: 12
            }
            text: "HORIZONTAL SCROLL"
            color: "#6a6a72"
            font.pixelSize: 10
            font.family: "Consolas, monospace"
            font.letterSpacing: 2
        }

        ScrollView {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: 35
                margins: 10
            }

            // 水平滚动条
            ScrollBar.horizontal: Quark.QuarkScrollBar {
                handleAccentColor: "#3b82f6"  // 工业蓝
            }

            // 水平内容
            Row {
                spacing: 15
                height: 140

                Repeater {
                    model: 30

                    Rectangle {
                        width: 120
                        height: 140
                        color: "#25252e"
                        radius: 3
                        border.color: "#35353d"
                        border.width: 1

                        Column {
                            anchors.centerIn: parent
                            spacing: 8

                            Text {
                                text: "CH-" + String(index + 1).padStart(2, '0')
                                color: "#e0e0e8"
                                font.pixelSize: 16
                                font.family: "Consolas, monospace"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Rectangle {
                                width: 60
                                height: 4
                                color: "#e85d04"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: (Math.random() * 100).toFixed(1) + "°C"
                                color: "#9ca3af"
                                font.pixelSize: 12
                                font.family: "Consolas, monospace"
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }
    }

    // ============================================
    // 颜色定制示例
    // ============================================

    Rectangle {
        anchors {
            left: verticalScrollView.right
            right: parent.right
            top: parent.top
            topMargin: 240
            bottom: parent.bottom
            margins: 20
        }
        color: "#1a1a1e"
        radius: 4
        border.color: "#2d2d35"
        border.width: 1

        Text {
            anchors {
                top: parent.top
                left: parent.left
                margins: 12
            }
            text: "CUSTOM COLOR VARIANTS"
            color: "#6a6a72"
            font.pixelSize: 10
            font.family: "Consolas, monospace"
            font.letterSpacing: 2
        }

        Column {
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                margins: 40
            }
            spacing: 20

            // 红色警告风格
            Row {
                spacing: 10

                Text {
                    text: "ALERT"
                    color: "#9ca3af"
                    font.family: "Consolas, monospace"
                    width: 80
                    anchors.verticalCenter: parent.verticalCenter
                }

                Quark.QuarkScrollBar {
                    width: 200
                    height: 14
                    orientation: Qt.Horizontal
                    size: 0.3
                    position: 0.2

                    // 红色警告配色
                    trackColor: "#1a0505"
                    trackBorderColor: "#3d1515"
                    handleColor: "#7f1d1d"
                    handleHoverColor: "#991b1b"
                    handlePressedColor: "#450a0a"
                    handleBorderColor: "#b91c1c"
                    handleAccentColor: "#ef4444"
                }
            }

            // 绿色安全风格
            Row {
                spacing: 10

                Text {
                    text: "SAFE"
                    color: "#9ca3af"
                    font.family: "Consolas, monospace"
                    width: 80
                    anchors.verticalCenter: parent.verticalCenter
                }

                Quark.QuarkScrollBar {
                    width: 200
                    height: 14
                    orientation: Qt.Horizontal
                    size: 0.5
                    position: 0.3

                    // 绿色安全配色
                    trackColor: "#051a0a"
                    trackBorderColor: "#153d25"
                    handleColor: "#1d7f3d"
                    handleHoverColor: "#1b9952"
                    handlePressedColor: "#0a4518"
                    handleBorderColor: "#1cb94e"
                    handleAccentColor: "#22c55e"
                }
            }

            // 蓝色信息风格
            Row {
                spacing: 10

                Text {
                    text: "INFO"
                    color: "#9ca3af"
                    font.family: "Consolas, monospace"
                    width: 80
                    anchors.verticalCenter: parent.verticalCenter
                }

                Quark.QuarkScrollBar {
                    width: 200
                    height: 14
                    orientation: Qt.Horizontal
                    size: 0.4
                    position: 0.1

                    // 蓝色信息配色
                    trackColor: "#05101a"
                    trackBorderColor: "#15253d"
                    handleColor: "#1d4a7f"
                    handleHoverColor: "#1b5e99"
                    handlePressedColor: "#0a2045"
                    handleBorderColor: "#1c6cb9"
                    handleAccentColor: "#3b82f6"
                }
            }

            // 黄色警告风格
            Row {
                spacing: 10

                Text {
                    text: "WARN"
                    color: "#9ca3af"
                    font.family: "Consolas, monospace"
                    width: 80
                    anchors.verticalCenter: parent.verticalCenter
                }

                Quark.QuarkScrollBar {
                    width: 200
                    height: 14
                    orientation: Qt.Horizontal
                    size: 0.25
                    position: 0.5

                    // 黄色警告配色
                    trackColor: "#1a1505"
                    trackBorderColor: "#3d3315"
                    handleColor: "#7f6b1d"
                    handleHoverColor: "#99851b"
                    handlePressedColor: "#453a0a"
                    handleBorderColor: "#b9a01c"
                    handleAccentColor: "#eab308"
                }
            }
        }
    }
}