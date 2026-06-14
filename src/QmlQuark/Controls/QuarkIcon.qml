import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    id: root

    property alias iconSource: root.source
    property color iconColor: "transparent"  // transparent = 不染色

    width: 24
    height: 24
    fillMode: Image.PreserveAspectFit

    // 自动着色
    layer.enabled: iconColor !== "transparent"
    // layer.effect: ColorOverlay {
    //     color: root.iconColor
    // }
}
