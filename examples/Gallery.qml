import QmlQuark 1.0 as Quark
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: galleryRoot

    // 弹窗触发信号（由外层 ApplicationWindow 连接实际弹窗）
    signal alertRequested()
    signal promptRequested()

    implicitWidth: 800
    implicitHeight: 600

    Flickable {
        id: galleryFlickable

        anchors.fill: parent
        anchors.margins: 24
        contentWidth: width
        contentHeight: contentColumn.implicitHeight
        clip: true

        ScrollBar.vertical: Quark.QuarkScrollBar {
            anchors.right: parent.right
            anchors.rightMargin: 4
        }

        ColumnLayout {
            id: contentColumn

            width: galleryFlickable.width - 10
            spacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "交互与组合组件"

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 12

                Quark.QuarkLabel {
                    Layout.fillWidth: true
                    text: "这个页面专门验证菜单、弹窗和文件管理器等复合组件。与基础控件矩阵分离后，交互流程更集中，也便于检查弹层定位与右键行为。"
                    muted: true
                    wrapMode: Text.Wrap
                }

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 60
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "弹层"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "Alert / Prompt / Dropdown / Context Menu"
                                muted: true
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 60
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 12

                            Quark.QuarkLabel {
                                text: "文件流"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "Toolbar / Search / Right Click / Entry Action"
                                muted: true
                            }
                        }
                    }
                }
            }
        }

            GridLayout {
                Layout.fillWidth: true
                columns: width > 920 ? 2 : 1
                columnSpacing: 20
                rowSpacing: 20

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "菜单与弹窗"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "把常见交互入口集中在一个卡片中测试：普通按钮、右键菜单、下拉菜单和弹窗分开但相邻。"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12

                        Quark.QuarkButton {
                            text: "打开下拉菜单"
                            onClicked: galleryMenu.open()
                        }

                        Quark.QuarkButton {
                            text: "打开提示弹窗"
                            onClicked: galleryRoot.alertRequested()
                        }

                        Quark.QuarkButton {
                            text: "打开输入弹窗"
                            onClicked: galleryRoot.promptRequested()
                        }
                    }

                    Item {
                        id: menuBtnWrapper
                        implicitWidth: menuBtn.implicitWidth
                        implicitHeight: menuBtn.implicitHeight

                        Quark.QuarkButton {
                            id: menuBtn
                            anchors.fill: parent
                            text: "右键菜单"
                            onClicked: contextMenu.popup(menuBtnWrapper, 0, menuBtnWrapper.height + 4)
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.RightButton
                            onClicked: contextMenu.popup(menuBtnWrapper, 0, menuBtnWrapper.height + 4)
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 84
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 6

                            Quark.QuarkLabel {
                                text: "测试重点"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "验证 popup 相对定位、禁用 Action 呈现，以及右键鼠标事件是否被包装层正确转发。"
                                muted: true
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                }
            }

            Quark.QuarkCard {
                Layout.fillWidth: true
                title: "下拉菜单预览"

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 16

                    Quark.QuarkLabel {
                        Layout.fillWidth: true
                        text: "独立展示 Dropdown，避免和按钮群挤在同一个布局里。这样更容易看清弹出方向、宽度和边距。"
                        muted: true
                        wrapMode: Text.Wrap
                    }

                    Quark.QuarkDropdown {
                        id: galleryMenu
                        y: 52
                        model: ["新建文件", "刷新目录", "打开设置"]
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 120
                        radius: 12
                        color: Quark.Palette.surfaceAlt
                        border.width: 1
                        border.color: Quark.Palette.border

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 12
                            spacing: 8

                            Quark.QuarkLabel {
                                text: "结构建议"
                                font.bold: true
                            }

                            Quark.QuarkLabel {
                                Layout.fillWidth: true
                                text: "基础控件留在矩阵页，复合交互集中在这个页面；文件管理器单独占据大区域，减少调试视线切换。"
                                muted: true
                                wrapMode: Text.Wrap
                            }
                        }
                    }
                }
            }
        }

            Quark.QuarkMenu {
                id: contextMenu

                Action { text: "新建文件" }
                Action { text: "刷新目录" }
                Action { text: "打开设置"; enabled: false }
            }

            Quark.QuarkMenu {
                id: fileContextMenu
                property var entryData: null

                Action {
                    text: "进入目录"
                    enabled: fileContextMenu.entryData && fileContextMenu.entryData.isDirectory
                }
                Action {
                    text: "打开文件"
                    enabled: fileContextMenu.entryData && !fileContextMenu.entryData.isDirectory
                }
                Action { text: "刷新" }
            }

            Quark.QuarkFileManager {
                id: galleryFileManager
                Layout.fillWidth: true
                Layout.preferredHeight: 350
                showSearch: false
                showToolbar: false
                showStatusBar: false
                currentPath: "/"

                onContextMenuRequested: function(entry, mouse) {
                    fileContextMenu.entryData = entry
                    fileContextMenu.popup()
                }
            }
        }
    }
}
