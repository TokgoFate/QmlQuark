import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import ".." as Quark

Quark.QuarkCard {
    id: control

    property string currentPath: "/"
    property var entries: []

    signal navigateUp()
    signal entryActivated(var entry)

    title: qsTr("文件管理器")

    RowLayout {
        width: parent.width
        spacing: 12

        Quark.QuarkButton {
            text: qsTr("返回上级")
            accentColor: Quark.Palette.surfaceAlt
            foregroundColor: Quark.Palette.text
            onClicked: control.navigateUp()
        }

        Text {
            Layout.fillWidth: true
            text: control.currentPath
            color: Quark.Palette.textMuted
            font.family: Quark.Typography.family
            font.pixelSize: Quark.Typography.sm
            elide: Text.ElideMiddle
            verticalAlignment: Text.AlignVCenter
        }
    }

    ListView {
        width: parent.width
        height: 280
        clip: true
        spacing: 8
        model: control.entries

        delegate: Rectangle {
            property var entry: modelData
            property string entryName: typeof entry === "string" ? entry : (entry.name || "")
            property bool isDirectory: typeof entry === "object" && !!entry.isDirectory

            width: ListView.view.width
            height: 52
            radius: 14
            color: mouseArea.containsMouse ? Quark.Palette.surfaceAlt : Quark.Palette.window
            border.width: 1
            border.color: Quark.Palette.border

            Row {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 10

                Text {
                    text: isDirectory ? "📁" : "📄"
                    color: Quark.Palette.text
                    font.pixelSize: Quark.Typography.lg
                    verticalAlignment: Text.AlignVCenter
                }

                Text {
                    width: parent.width - 24
                    text: entryName
                    color: Quark.Palette.text
                    font.family: Quark.Typography.family
                    font.pixelSize: Quark.Typography.md
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.entryActivated(entry)
            }
        }
    }
}
