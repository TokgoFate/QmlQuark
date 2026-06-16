import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

SpinBox {
	id: control

	implicitWidth: 128
	implicitHeight: 44
	editable: true
	font.family: Quark.Typography.family
	font.pixelSize: Quark.Typography.md

	readonly property real buttonInset: 6
	readonly property real buttonWidth: 26
	readonly property real buttonHeight: Math.max(14, (height - (buttonInset * 2) - 4) / 2)

	contentItem: TextInput {
		z: 1
		text: control.textFromValue(control.value, control.locale)
		color: control.enabled ? Quark.Palette.text : Quark.Palette.textMuted
		font: control.font
		selectionColor: Quark.Palette.accentSoft
		selectedTextColor: Quark.Palette.textOnAccent
		horizontalAlignment: Qt.AlignLeft
		verticalAlignment: Text.AlignVCenter
		leftPadding: 12
		rightPadding: control.buttonInset + control.buttonWidth + 10
		readOnly: !control.editable
		validator: control.validator
		inputMethodHints: Qt.ImhFormattedNumbersOnly

		onEditingFinished: control.value = control.valueFromText(text, control.locale)
	}

	up.indicator: Rectangle {
		x: control.width - width - control.buttonInset
		y: control.buttonInset
		width: control.buttonWidth
		height: control.buttonHeight
		radius: 8
		color: control.up.pressed ? Qt.darker(Quark.Palette.surfaceAlt, 1.15) : Quark.Palette.surfaceAlt
		border.width: 1
		border.color: control.up.hovered ? Quark.Palette.accent : Quark.Palette.border

		Text {
			anchors.centerIn: parent
			text: "+"
			color: Quark.Palette.text
			font.family: Quark.Typography.family
			font.pixelSize: Quark.Typography.md
			font.bold: true
		}
	}

	down.indicator: Rectangle {
		x: control.width - width - control.buttonInset
		y: control.buttonInset + control.buttonHeight + 4
		width: control.buttonWidth
		height: control.buttonHeight
		radius: 8
		color: control.down.pressed ? Qt.darker(Quark.Palette.surfaceAlt, 1.15) : Quark.Palette.surfaceAlt
		border.width: 1
		border.color: control.down.hovered ? Quark.Palette.accent : Quark.Palette.border

		Text {
			anchors.centerIn: parent
			text: "−"
			color: Quark.Palette.text
			font.family: Quark.Typography.family
			font.pixelSize: Quark.Typography.md
			font.bold: true
		}
	}

	background: Rectangle {
		radius: 12
		color: Quark.Palette.surface
		border.width: control.activeFocus ? 2 : 1
		border.color: control.activeFocus ? Quark.Palette.accent : Quark.Palette.border
	}
}
