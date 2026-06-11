import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../src/QmlQuark" as Quark

ApplicationWindow {
    visible: true
    width: 960
    height: 720
    color: Quark.Palette.window
    title: "QmlQuark Gallery"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20

        Quark.QuarkCard {
            Layout.fillWidth: true
            title: "基础控件"

            RowLayout {
                width: parent.width
                spacing: 16

                Quark.QuarkTextField {
                    placeholderText: "请输入内容"
                }

                Quark.QuarkSelectBox {
                    model: ["工业主题", "深色主题", "浅色主题"]
                }
            }

            Quark.QuarkProgressBar {
                width: parent.width
                value: 0.68
            }
        }

        Quark.QuarkFileManager {
            Layout.fillWidth: true
            entries: [
                { "name": "Documents", "isDirectory": true },
                { "name": "device-config.json", "isDirectory": false },
                { "name": "log-2026-06-11.txt", "isDirectory": false }
            ]
        }
    }
}
