import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

BusyIndicator {
	id: control

	property color accentColor: Quark.Palette.accent
	property color trackColor: Quark.Palette.surfaceAlt

	implicitWidth: 28
	implicitHeight: 28

	contentItem: Item {
		implicitWidth: 28
		implicitHeight: 28
		opacity: control.running ? 1.0 : 0.45

		Repeater {
			model: 8

			Rectangle {
				required property int index

				readonly property real angle: (index / 8) * Math.PI * 2 - (Math.PI / 2)
				readonly property real orbitRadius: (parent.width - width) * 0.32

				x: parent.width / 2 + Math.cos(angle) * orbitRadius - width / 2
				y: parent.height / 2 + Math.sin(angle) * orbitRadius - height / 2
				width: 5
				height: 5
				radius: width / 2
				color: index < 3 ? control.accentColor : control.trackColor
				opacity: 0.35 + ((8 - index) / 8) * 0.65
			}
		}

		RotationAnimator on rotation {
			from: 0
			to: 360
			duration: 900
			loops: Animation.Infinite
			running: control.running
		}
	}
}
