import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

RadioButton {
	id: control

	implicitHeight: 28
	spacing: 10
	font.family: Quark.Typography.family
	font.pixelSize: Quark.Typography.md

	indicator: Rectangle {
		implicitWidth: 20
		implicitHeight: 20
		x: control.leftPadding
		y: control.topPadding + (control.availableHeight - height) / 2
		radius: width / 2
		color: control.hovered ? Quark.Palette.surfaceAlt : Quark.Palette.surface
		border.width: control.visualFocus ? 2 : 1
		border.color: control.checked
					  ? Quark.Palette.accent
					  : (control.visualFocus ? Quark.Palette.accent : Quark.Palette.border)

		Rectangle {
			anchors.centerIn: parent
			width: 10
			height: 10
			radius: width / 2
			visible: control.checked
			color: control.enabled ? Quark.Palette.accent : Quark.Palette.textMuted
		}
	}

	contentItem: Text {
		leftPadding: control.indicator.width + control.spacing
		text: control.text
		font: control.font
		color: control.enabled ? Quark.Palette.text : Quark.Palette.textMuted
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
	}
}
