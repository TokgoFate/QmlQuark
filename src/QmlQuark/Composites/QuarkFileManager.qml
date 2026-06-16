import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QmlQuark.FileSystem 1.0
import ".." as Quark

Quark.QuarkCard {
    id: control

    // ========== 可配置属性 ==========

    // 当前路径（设置后会同步到模型）
    property string currentPath: "/"

    // 文件系统模型：可外部传入，也可内部自动创建
    property FileSystemModel fsModel: null

    // 是否显示文件大小
    property bool showFileSize: true

    // 是否显示修改时间
    property bool showModifiedTime: true

    // 是否显示搜索框
    property bool showSearch: true

    // 是否显示工具栏
    property bool showToolbar: true

    // 是否显示底部状态栏
    property bool showStatusBar: true

    // 列表高度范围
    property int minListHeight: 200
    // <= 0 表示不限制最大高度
    property int maxListHeight: -1

    // 委托项高度
    property int itemHeight: 52

    // ========== 信号 ==========

    // 文件/目录被点击
    signal entryClicked(var entry, int index)

    // 文件/目录被双击（进入目录或打开文件）
    signal entryDoubleClicked(var entry, int index)

    // 导航到某个路径
    signal pathChanged(string path)

    // 返回上级
    signal navigateUpClicked

    // 刷新请求
    signal refreshClicked

    // 新建文件夹请求
    signal createFolderRequested(string folderName)

    // 删除请求
    signal deleteRequested(var indices)

    // 右键菜单请求
    signal contextMenuRequested(var entry, var mouse)

    // ========== 内部属性 ==========

    // 内部模型引用（统一使用这个，避免判断 null）
    readonly property FileSystemModel _model: fsModel || internalModel

    // 搜索关键字
    property string searchKeyword: ""

    // 过滤后的条目
    property var filteredEntries: []

    // 选中项
    property var selectedIndices: []

    // 内部自动创建的模型（当外部未传入时使用）
    FileSystemModel {
        id: internalModel
        currentPath: control.currentPath
    }

    // 监听路径变化
    onCurrentPathChanged: {
        if (_model && _model.currentPath !== currentPath) {
            _model.currentPath = currentPath;
        }
    }

    // 监听模型路径变化
    Connections {
        target: _model
        function onCurrentPathChanged() {
            if (control.currentPath !== _model.currentPath) {
                control.currentPath = _model.currentPath;
                control.pathChanged(_model.currentPath);
            }
        }
        function onErrorOccurred(message) {
            errorDialog.text = message;
            errorDialog.open();
        }
    }

    // 标题
    title: qsTr("文件管理器")

    ColumnLayout {
        id: contentLayout
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 8

        // ========== 工具栏 ==========
        RowLayout {
            id: toolbar
            Layout.fillWidth: true
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.minimumHeight: visible ? implicitHeight : 0
            Layout.maximumHeight: visible ? implicitHeight : 0
            spacing: 12
            visible: control.showToolbar

            Quark.QuarkButton {
                text: qsTr("返回上级")
                enabled: _model ? _model.canNavigateUp : false
                accentColor: Quark.Palette.surfaceAlt
                foregroundColor: Quark.Palette.text
                onClicked: {
                    if (_model)
                        _model.navigateUp();
                    control.navigateUpClicked();
                }
            }

            Quark.QuarkButton {
                text: "🔄"
                accentColor: Quark.Palette.surfaceAlt
                foregroundColor: Quark.Palette.text
                onClicked: {
                    if (_model)
                        _model.refresh();
                    control.refreshClicked();
                }
            }

            Quark.QuarkButton {
                text: "📁+"
                accentColor: Quark.Palette.surfaceAlt
                foregroundColor: Quark.Palette.text
                onClicked: newFolderDialog.open()
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

            Text {
                text: control.formatTotalCountText()
                color: Quark.Palette.textMuted
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.sm
            }
        }

        // ========== 搜索框 ==========
        Quark.QuarkTextField {
            id: search
            Layout.fillWidth: true
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.minimumHeight: visible ? implicitHeight : 0
            Layout.maximumHeight: visible ? implicitHeight : 0
            visible: control.showSearch
            placeholderText: qsTr("搜索文件...")

            onTextChanged: {
                control.searchKeyword = text;
                control.filterEntries();
            }
        }

        // ========== 文件列表 ==========
        Rectangle {
            id: listFrame
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: control.minListHeight
            Layout.maximumHeight: control.maxListHeight > 0 ? control.maxListHeight : Number.POSITIVE_INFINITY
            implicitHeight: control.minListHeight
            radius: 12
            color: "transparent"
            border.width: 1
            border.color: Quark.Palette.border
            clip: true

            ListView {
                id: fileList
                anchors.fill: parent
                anchors.margins: 8
                clip: true
                spacing: 6
                model: control.searchKeyword ? control.filteredEntries : _model

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                }

                // 空状态
                Text {
                    visible: fileList.count === 0 && !(_model && _model.loading)
                    anchors.centerIn: parent
                    text: {
                        if (!control.searchKeyword)
                            return qsTr("目录为空");
                        return qsTr("无匹配结果");
                    }
                    color: Quark.Palette.textMuted
                    font.family: Quark.Typography.family
                    font.pixelSize: Quark.Typography.md
                }

                // 加载中
                BusyIndicator {
                    visible: _model ? _model.loading : false
                    anchors.centerIn: parent
                    running: true
                }

                delegate: Rectangle {
                    id: delegateItem
                    property int itemIndex: model.index !== undefined ? model.index : index
                    property var entry: {
                        return {
                            name: model.name || "",
                            path: model.path || "",
                            isDirectory: model.isDirectory || false,
                            size: model.size || "",
                            modified: model.modified || "",
                            iconType: model.iconType || "file"
                        };
                    }
                    property bool isSelected: control.selectedIndices.indexOf(itemIndex) !== -1

                    width: ListView.view.width
                    height: control.itemHeight
                    radius: 10
                    color: {
                        if (isSelected)
                            return Quark.Palette.accent + "20";
                        if (mouseArea.containsMouse)
                            return Quark.Palette.surfaceAlt;
                        return "transparent";
                    }
                    border.width: isSelected ? 2 : 1
                    border.color: isSelected ? Quark.Palette.accent : Quark.Palette.border

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 10

                        // 图标
                        Text {
                            text: {
                                switch (entry.iconType) {
                                case "folder":
                                    return "📁";
                                case "image":
                                    return "🖼️";
                                case "video":
                                    return "🎬";
                                case "audio":
                                    return "🎵";
                                case "text":
                                    return "📄";
                                case "doc":
                                    return "📝";
                                case "pdf":
                                    return "📕";
                                case "code":
                                    return "💻";
                                case "archive":
                                    return "📦";
                                default:
                                    return "📄";
                                }
                            }
                            font.pixelSize: Quark.Typography.lg
                            verticalAlignment: Text.AlignVCenter
                        }

                        // 文件名
                        Text {
                            Layout.fillWidth: true
                            text: entry.name
                            color: Quark.Palette.text
                            font.family: Quark.Typography.family
                            font.pixelSize: Quark.Typography.md
                            verticalAlignment: Text.AlignVCenter
                            elide: Text.ElideRight
                        }

                        // 文件大小
                        Text {
                            visible: control.showFileSize && !entry.isDirectory && entry.size !== ""
                            text: entry.size
                            color: Quark.Palette.textMuted
                            font.family: Quark.Typography.family
                            font.pixelSize: Quark.Typography.sm
                        }

                        // 修改时间
                        Text {
                            visible: control.showModifiedTime && entry.modified !== ""
                            text: entry.modified
                            color: Quark.Palette.textMuted
                            font.family: Quark.Typography.family
                            font.pixelSize: Quark.Typography.sm
                        }
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        onClicked: function (mouse) {
                            if (mouse.button === Qt.RightButton) {
                                control.contextMenuRequested(entry, mouse);
                                return;
                            }

                            // Ctrl+点击多选
                            if (mouse.modifiers & Qt.ControlModifier) {
                                control.toggleSelection(itemIndex);
                            } else {
                                control.selectedIndices = [itemIndex];
                            }

                            control.entryClicked(entry, itemIndex);
                        }

                        onDoubleClicked: {
                            if (entry.isDirectory) {
                                if (_model)
                                    _model.navigateTo(itemIndex);
                            } else {
                                Qt.openUrlExternally(entry.path);
                            }
                            control.entryDoubleClicked(entry, itemIndex);
                        }
                    }
                }
            }
        }

        // ========== 底部状态栏 ==========
        RowLayout {
            id: statusbar
            Layout.fillWidth: true
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.minimumHeight: visible ? implicitHeight : 0
            Layout.maximumHeight: visible ? implicitHeight : 0
            spacing: 8
            visible: control.showStatusBar

            Text {
                text: {
                    var count = control.selectedIndices.length;
                    if (count > 0)
                        return qsTr("已选择 ") + count + qsTr(" 项");
                    return qsTr("共 ") + control.totalCount() + qsTr(" 项");
                }
                color: Quark.Palette.textMuted
                font.family: Quark.Typography.family
                font.pixelSize: Quark.Typography.sm
            }

            Item {
                Layout.fillWidth: true
            }

            Quark.QuarkButton {
                visible: control.selectedIndices.length > 0
                text: "🗑️ " + qsTr("删除")
                accentColor: "#ff4444"
                foregroundColor: "white"
                onClicked: {
                    control.deleteRequested(control.selectedIndices);
                    control.selectedIndices = [];
                }
            }
        }
    }

    // ========== 对话框 ==========

    // 新建文件夹对话框
    Quark.QuarkDialog {
        id: newFolderDialog
        title: qsTr("新建文件夹")
        // standardButtons: Dialog.Ok | Dialog.Cancel
        modal: true

        TextField {
            id: folderNameField
            width: parent.width
            placeholderText: qsTr("文件夹名称")
        }

        onAccepted: {
            var name = folderNameField.text;
            if (name.trim() !== "") {
                control.createFolderRequested(name);
                if (_model)
                    _model.createFolder(name);
            }
            folderNameField.text = "";
        }
    }

    // 错误对话框
    Quark.QuarkDialog {
        id: errorDialog
        title: qsTr("错误")
        // standardButtons: Dialog.Ok
        modal: true
        property alias text: errorText.text

        Text {
            id: errorText
            width: parent.width
            wrapMode: Text.Wrap
        }
    }

    // ========== 方法 ==========

    function totalCount() {
        if (!_model)
            return 0;
        return _model.rowCount();
    }

    function formatTotalCountText() {
        return totalCount() + qsTr(" 项");
    }

    // 过滤条目
    function filterEntries() {
        if (!control.searchKeyword || !_model) {
            control.filteredEntries = [];
            return;
        }

        var keyword = control.searchKeyword.toLowerCase();
        var result = [];
        var count = _model.rowCount();

        for (var i = 0; i < count; i++) {
            var idx = _model.index(i, 0);
            var name = _model.data(idx, _model.NameRole) || "";
            if (name.toLowerCase().indexOf(keyword) !== -1) {
                result.push({
                    index: i,
                    name: name,
                    path: _model.data(idx, _model.PathRole),
                    isDirectory: _model.data(idx, _model.IsDirectoryRole),
                    size: _model.data(idx, _model.SizeRole),
                    modified: _model.data(idx, _model.ModifiedRole),
                    iconType: _model.data(idx, _model.IconTypeRole)
                });
            }
        }
        control.filteredEntries = result;
    }

    // 切换选中
    function toggleSelection(index) {
        var indices = control.selectedIndices.slice();
        var pos = indices.indexOf(index);
        if (pos === -1) {
            indices.push(index);
        } else {
            indices.splice(pos, 1);
        }
        control.selectedIndices = indices;
    }

    // 清除选中
    function clearSelection() {
        control.selectedIndices = [];
    }

    // 刷新
    function refresh() {
        if (_model)
            _model.refresh();
    }

    // 导航到路径
    function navigateToPath(path) {
        control.currentPath = path;
    }
}
