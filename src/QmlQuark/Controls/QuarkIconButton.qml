import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Button {
	id: control

	property alias iconSource: icon.source
	property int iconSize: 18
	property real iconRotation: 0
	property bool outlined: true
	property color accentColor: Quark.Palette.accent
	property color foregroundColor: control.enabled ? Quark.Palette.text : Quark.Palette.textMuted

	implicitWidth: 40
	implicitHeight: 40
	padding: 10

	background: Rectangle {
		radius: 12
		color: !control.enabled
			   ? Qt.darker(Quark.Palette.surface, 1.05)
			   : control.outlined
				 ? (control.down
					? Qt.darker(Quark.Palette.surfaceAlt, 1.15)
					: control.hovered
					  ? Quark.Palette.surfaceAlt
					  : Quark.Palette.surface)
				 : (control.down
					? Qt.darker(control.accentColor, 1.18)
					: control.hovered
					  ? Qt.lighter(control.accentColor, 1.08)
					  : control.accentColor)
		border.width: 1
		border.color: control.outlined
					  ? (control.hovered ? control.accentColor : Quark.Palette.border)
					  : Qt.darker(color, 1.12)
	}

	contentItem: Item {
		Image {
			id: icon

			anchors.centerIn: parent
			rotation: control.iconRotation
			width: control.iconSize
			height: control.iconSize
			fillMode: Image.PreserveAspectFit
			sourceSize.width: width
			sourceSize.height: height
			opacity: control.enabled ? 1.0 : 0.45
		}
	}
}
