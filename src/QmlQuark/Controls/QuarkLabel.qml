import QtQuick 2.15
import QtQuick.Controls 2.15
import ".." as Quark

Label {
		id: control

		property bool muted: false
		property bool accent: false

		color: !control.enabled
					 ? Quark.Palette.textMuted
					 : control.accent
						 ? Quark.Palette.accent
						 : control.muted
							 ? Quark.Palette.textMuted
							 : Quark.Palette.text
		font.family: Quark.Typography.family
		font.pixelSize: Quark.Typography.md
		elide: Text.ElideRight
}
