import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

ScrollBar {
	id: control

	property color trackColor: Qt.darker(Quark.Palette.surface, 1.12)
	property color trackBorderColor: Qt.darker(Quark.Palette.border, 1.05)
	property color handleColor: Quark.Palette.surfaceAlt
	property color handleHoverColor: Qt.lighter(handleColor, 1.08)
	property color handlePressedColor: Qt.darker(handleColor, 1.15)
	property color handleBorderColor: Quark.Palette.border
	property color handleAccentColor: Quark.Palette.accent

	implicitWidth: orientation === Qt.Vertical ? 14 : 160
	implicitHeight: orientation === Qt.Vertical ? 160 : 14
	padding: 2

	background: Rectangle {
		implicitWidth: control.orientation === Qt.Vertical ? 14 : 80
		implicitHeight: control.orientation === Qt.Vertical ? 80 : 14
		radius: 6
		color: control.trackColor
		border.width: 1
		border.color: control.trackBorderColor
	}

	contentItem: Rectangle {
		implicitWidth: control.orientation === Qt.Vertical ? 10 : 72
		implicitHeight: control.orientation === Qt.Vertical ? 72 : 10
		radius: 4
		color: control.pressed
			   ? control.handlePressedColor
			   : control.hovered
				 ? control.handleHoverColor
				 : control.handleColor
		border.width: 1
		border.color: control.handleBorderColor

		Rectangle {
			anchors.centerIn: parent
			width: control.orientation === Qt.Horizontal ? Math.max(18, parent.width * 0.45) : 2
			height: control.orientation === Qt.Horizontal ? 2 : Math.max(18, parent.height * 0.45)
			radius: 1
			color: control.handleAccentColor
			opacity: 0.9
		}
	}
}
