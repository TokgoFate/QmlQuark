import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

CheckBox {
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
		radius: 6
		color: !control.enabled
			   ? Qt.darker(Quark.Palette.surfaceAlt, 1.02)
			   : control.checked || control.checkState === Qt.PartiallyChecked
				 ? (control.down ? Qt.darker(Quark.Palette.accent, 1.15) : Quark.Palette.accent)
				 : (control.hovered ? Quark.Palette.surfaceAlt : Quark.Palette.surface)
		border.width: control.visualFocus ? 2 : 1
		border.color: !control.enabled
					  ? Qt.darker(color, 1.08)
					  : control.checked || control.checkState === Qt.PartiallyChecked
						? Quark.Palette.accent
						: (control.visualFocus ? Quark.Palette.accent : Quark.Palette.border)

		Text {
			anchors.centerIn: parent
			text: control.checkState === Qt.PartiallyChecked ? "-" : "✓"
			visible: control.checked || control.checkState === Qt.PartiallyChecked
			color: control.enabled ? Quark.Palette.textOnAccent : Qt.lighter(Quark.Palette.disabled, 1.45)
			font.family: Quark.Typography.family
			font.pixelSize: Quark.Typography.sm
			font.bold: true
		}
	}

	contentItem: Text {
		leftPadding: control.indicator.width + control.spacing
		text: control.text
		font: control.font
		color: control.enabled ? Quark.Palette.text : Quark.Palette.disabled
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
	}
}
