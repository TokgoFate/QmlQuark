# QML 通用控件编写指南

本文档用于沉淀 QmlQuark 通用控件的设计、实现、验证和维护规范。目标是避免控件在单个示例中看起来正常，但在真实业务、不同父容器、不同尺寸约束下出现隐形布局 bug。

## 1. 控件设计原则

### 1.1 通用控件必须有清晰边界

一个通用控件应该只依赖自己的公开属性、信号、方法和直接内容槽，不应该依赖外部页面的结构。

禁止做法：

```qml
height: parent.parent.height - toolbar.height
```

推荐做法：

```qml
ColumnLayout {
    anchors.fill: parent

    HeaderBar {
        Layout.fillWidth: true
    }

    ListView {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
```

原因：`parent.parent` 假设了控件被放在固定层级中，一旦外部包一层 `Item`、`Loader`、`StackView`、`Popup` 或其他容器，控件就会失效。

### 1.2 控件内部布局由控件自己负责

控件内部的工具栏、搜索框、列表、状态栏等结构应由控件内部布局管理。外部使用者只负责给控件一个区域，例如：

```qml
QuarkFileManager {
    Layout.fillWidth: true
    Layout.fillHeight: true
}
```

外部不应该需要知道控件内部有哪些子项、每个子项多高、该如何相减。

### 1.3 外部验证代码不能污染控件内容槽

如果控件有 `default property`，示例或调试页面中直接写入的子项会进入控件内容槽，可能改变布局行为。

禁止做法：

```qml
QuarkFileManager {
    Rectangle {
        anchors.fill: parent
        color: "yellow"
        opacity: 0.2
    }
}
```

推荐做法：

```qml
Item {
    QuarkFileManager {
        id: fileManager
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: fileManager
        visible: debugOverlayEnabled
        color: "yellow"
        opacity: 0.2
    }
}
```

验证辅助层应该包在控件外部，而不是作为控件内容。

## 2. 尺寸与布局规范

### 2.1 优先使用 Layout，而不是手算高度

在 `ColumnLayout` / `RowLayout` 内，优先使用：

```qml
Layout.fillWidth: true
Layout.fillHeight: true
Layout.preferredWidth: 320
Layout.minimumHeight: 200
Layout.maximumHeight: 480
```

避免：

```qml
height: parent.height - header.height - footer.height - 24
```

手算高度容易遗漏 spacing、padding、border、visible 状态、implicitHeight、字体变化和缩放环境。

### 2.2 不混用 anchors 和 Layout 管理同一个子项

如果一个子项由 `ColumnLayout` / `RowLayout` 管理，不要同时给它设置 `anchors.fill`。

错误示例：

```qml
ColumnLayout {
    Rectangle {
        anchors.fill: parent
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
```

推荐示例：

```qml
ColumnLayout {
    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}
```

`anchors` 适合普通 `Item` 内部的局部定位，`Layout.*` 适合被布局容器管理的直接子项。

### 2.3 每个通用控件都要声明隐式尺寸

如果控件可能被放进普通 `Column`、`Row`、`Flickable`、`Popup`、`Dialog` 或没有明确高度的容器，需要提供合理的 `implicitWidth` / `implicitHeight`。

推荐：

```qml
implicitWidth: Math.max(320, content.implicitWidth + leftPadding + rightPadding)
implicitHeight: content.implicitHeight + topPadding + bottomPadding
```

对于可伸缩控件，例如文件管理器、表格、树、编辑器，应至少给主要内容区一个最小隐式高度：

```qml
property int minListHeight: 200

Rectangle {
    id: listFrame
    Layout.fillHeight: true
    Layout.minimumHeight: control.minListHeight
    implicitHeight: control.minListHeight
}
```

### 2.4 可隐藏区域要同时处理 visible 和 Layout 尺寸

`visible: false` 不一定等于布局中完全不占空间。对于布局子项，建议同步设置高度约束：

```qml
RowLayout {
    visible: control.showToolbar
    Layout.fillWidth: true
    Layout.preferredHeight: visible ? implicitHeight : 0
    Layout.minimumHeight: visible ? implicitHeight : 0
    Layout.maximumHeight: visible ? implicitHeight : 0
}
```

这样工具栏隐藏时不会留下空白。

### 2.5 内容区域需要可裁剪时必须显式 clip

QML 的 `Item` 默认 `clip: false`。如果控件边框只包住一部分内容，但其他内容仍显示在外面，很可能是子项溢出但没有裁剪。

列表、圆角面板、图片区域、滚动区域建议使用外层视觉容器裁剪：

```qml
Rectangle {
    radius: 12
    border.width: 1
    border.color: Quark.Palette.border
    clip: true

    ListView {
        anchors.fill: parent
        anchors.margins: 8
        clip: true
    }
}
```

## 3. 内容槽与复合控件设计

### 3.1 default property 要谨慎设计

`default property` 很方便，但也容易让外部子项意外进入控件内部布局。通用控件应明确内容槽语义。

适合有默认内容槽的控件：

- `QuarkCard`：用户自然会往卡片里放内容。
- `QuarkDialog`：用户自然会往对话框正文放内容。

不一定适合开放默认内容槽的控件：

- `QuarkFileManager`
- `QuarkSelectBox`
- `QuarkDropdown`
- `QuarkProgressBar`

如果控件内部结构是固定的，尽量不要让外部任意插入内容。需要扩展点时，使用明确属性或具名槽。

### 3.2 复合控件不要泄露内部子项

不要让外部通过内部 id 或层级修改控件行为。公开配置应通过属性完成：

```qml
property bool showSearch: true
property bool showToolbar: true
property bool showStatusBar: true
property int itemHeight: 52
```

外部使用：

```qml
QuarkFileManager {
    showSearch: false
    itemHeight: 48
}
```

### 3.3 内部状态和外部模型要分清所有权

如果控件支持外部模型，也支持内部默认模型，应明确统一入口：

```qml
property FileSystemModel fsModel: null
readonly property FileSystemModel modelRef: fsModel || internalModel
```

内部所有读写都使用 `modelRef`，避免每处都判断 `fsModel` 是否为空。

## 4. 视觉设计规范

### 4.1 每个视觉区域都要有明确层级

复合控件通常包含多个区域：

- 标题区
- 工具栏
- 搜索区
- 主内容区
- 状态栏
- 弹窗/菜单

主内容区如果是列表、表格、文件区域，建议使用独立边框或背景，避免视觉上和外层卡片混在一起。

推荐：

```qml
Rectangle {
    id: listFrame
    radius: 12
    color: "transparent"
    border.width: 1
    border.color: Quark.Palette.border
}
```

### 4.2 不要只依赖留白表达边界

留白在复杂界面或深色主题下不一定足够。列表、输入区域、拖放区域、可滚动区域应有边框、背景色或阴影中的至少一种视觉提示。

### 4.3 圆角和裁剪要成对考虑

如果容器有圆角，而里面有滚动内容，需要：

```qml
clip: true
```

否则滚动项可能越过圆角，破坏视觉完整性。

### 4.4 颜色必须来自主题

通用控件不要散落硬编码颜色，除非是语义强烈的状态色。优先使用：

```qml
Quark.Palette.surface
Quark.Palette.surfaceAlt
Quark.Palette.border
Quark.Palette.text
Quark.Palette.textMuted
Quark.Palette.accent
```

危险操作、错误状态可以使用语义属性，若主题暂未提供，应考虑扩展主题，而不是在每个控件里写固定颜色。

### 4.5 文本必须处理溢出

路径、文件名、状态文本、按钮文本都可能变长。需要明确 `elide` 或 `wrapMode`。

推荐：

```qml
Text {
    Layout.fillWidth: true
    text: control.currentPath
    elide: Text.ElideMiddle
}
```

文件名通常用 `Text.ElideRight`，路径通常用 `Text.ElideMiddle`。

## 5. 交互与状态规范

### 5.1 控件状态要完整

常见状态包括：

- normal
- hover
- pressed
- disabled
- selected
- focused
- loading
- empty
- error

文件管理器这类控件至少需要：

- 加载中
- 空目录
- 搜索无结果
- 选中项
- 错误提示
- 禁用返回上级按钮

### 5.2 信号命名要表达用户意图

推荐信号：

```qml
signal entryClicked(var entry, int index)
signal entryDoubleClicked(var entry, int index)
signal pathChanged(string path)
signal refreshClicked
signal createFolderRequested(string folderName)
signal deleteRequested(var indices)
```

信号应该表达“发生了什么”或“请求做什么”，不要暴露内部实现细节。

### 5.3 控件内部可以处理默认行为，但要给外部机会介入

例如双击目录时可以默认进入目录，同时发出信号：

```qml
if (entry.isDirectory) {
    modelRef.navigateTo(itemIndex);
}
control.entryDoubleClicked(entry, itemIndex);
```

如果后续需要更强控制，可以增加属性：

```qml
property bool autoNavigateOnDoubleClick: true
```

### 5.4 键盘和焦点要纳入设计

通用控件最终应支持：

- Tab 焦点进入
- Enter 执行默认操作
- Esc 关闭弹窗或清除搜索
- Up/Down 移动选中
- Ctrl/Shift 多选

即使第一版不实现，也应避免设计上阻断键盘扩展。

## 6. 数据与模型规范

### 6.1 不要把模型方法当属性

QML 中 C++ 模型方法和属性非常容易混淆。

错误：

```qml
text: model.rowCount + " 项"
```

正确：

```qml
text: model.rowCount() + " 项"
```

错误写法会显示 `function() { [native code] }`，这是函数对象被转成字符串。

### 6.2 代理中统一整理 entry 对象

列表代理里可以把模型角色整理成统一对象，方便信号传递：

```qml
property var entry: ({
    name: model.name || "",
    path: model.path || "",
    isDirectory: model.isDirectory || false
})
```

但要注意：这个对象是代理内部的临时视图，不应该被外部长时间持有作为真实数据源。

### 6.3 搜索过滤要考虑模型更新

如果过滤列表来自模型快照，需要在以下情况重新过滤：

- 搜索关键字变化
- 当前路径变化
- 模型刷新完成
- 文件创建/删除后

否则搜索结果可能滞后。

## 7. 弹窗、菜单与覆盖层规范

### 7.1 弹窗不要影响主布局

对话框、错误提示、右键菜单应作为覆盖层，不应放进主 `ColumnLayout` 中参与高度分配。

### 7.2 覆盖层要明确 parent

弹窗如果需要相对控件定位，应明确 parent 或使用 Overlay，避免默认挂载位置不确定。

### 7.3 调试覆盖层只能存在于示例层

通用控件源码里不要保留调试用颜色块、透明遮罩、日志矩形。示例页可以有，但必须默认关闭，并且不进入控件内容槽。

## 8. 验证方法

### 8.1 每个通用控件至少要有一个调试示例

示例应覆盖：

- 默认状态
- 小尺寸
- 大尺寸
- 禁用部分功能
- 空数据
- 长文本
- 主题色变化
- 动态显示/隐藏子区域

### 8.2 复合控件要做容器兼容性验证

同一个控件至少放进以下容器中测试：

```qml
ColumnLayout
RowLayout
Item + anchors.fill
QuarkCard
Dialog/Popup
ScrollView 或 Flickable
Loader
StackView 页面
```

如果控件只在一种容器里正常，说明它还不是稳定通用控件。

### 8.3 布局验证清单

每次修改布局后检查：

- 外层边框是否包住全部内容
- 内容是否溢出边框
- 隐藏工具栏/搜索框/状态栏后是否有空白
- 小窗口是否裁剪合理
- 大窗口是否能填充空间
- 长路径、长文件名是否省略
- 滚动条是否出现在预期位置
- 列表项 hover/selected 是否不改变布局尺寸

### 8.4 视觉验证清单

每次修改视觉后检查：

- 边框是否清晰但不过重
- 圆角是否统一
- 列表项是否贴边
- 主内容区和外层卡片是否有层次
- 深色/浅色主题下对比是否足够
- 空状态和加载状态是否居中且不遮挡内容

### 8.5 行为验证清单

每次修改交互后检查：

- 点击是否选中
- Ctrl 多选是否稳定
- 双击目录是否进入
- 双击文件是否打开
- 返回上级按钮状态是否正确
- 刷新后计数是否更新
- 搜索后计数和空状态是否合理
- 错误提示是否可见且不会破坏布局

## 9. 常见隐形 bug

### 9.1 边框只包住标题，内容跑到外面

常见原因：

- 内容承载区没有 `implicitHeight`
- 父布局只按标题计算高度
- 子项默认 `clip: false`，所以溢出仍然显示

解决方向：

- 修复容器组件的内容承载契约
- 不在子控件里手算祖先高度
- 必要时给视觉容器 `clip: true`

### 9.2 Layout 属性不起作用

常见原因：直接父项不是 `ColumnLayout` / `RowLayout` / `GridLayout`。

错误：

```qml
Column {
    Item {
        Layout.fillHeight: true
    }
}
```

`Column` 不会处理 `Layout.fillHeight`。

### 9.3 visible false 后仍占空间

常见原因：布局项仍有 `implicitHeight` 或 `Layout.preferredHeight`。

解决：同步设置 Layout 高度约束为 0。

### 9.4 滚动内容越过圆角

常见原因：外层圆角容器没有 `clip: true`。

### 9.5 示例页面影响控件布局

常见原因：调试层或测试内容被写进控件默认内容槽。

解决：测试辅助内容放到控件外部。

## 10. 推荐控件骨架

### 10.1 简单控件

```qml
Control {
    id: control

    property color accentColor: Quark.Palette.accent

    implicitWidth: Math.max(120, contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(36, contentItem.implicitHeight + topPadding + bottomPadding)
    padding: 8

    contentItem: Text {
        text: control.text
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 8
        color: control.enabled ? Quark.Palette.surfaceAlt : Quark.Palette.surface
        border.width: 1
        border.color: Quark.Palette.border
    }
}
```

### 10.2 复合控件

```qml
Quark.QuarkCard {
    id: control

    property bool showHeader: true
    property int minContentHeight: 200

    title: qsTr("复合控件")

    ColumnLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 8

        RowLayout {
            visible: control.showHeader
            Layout.fillWidth: true
            Layout.preferredHeight: visible ? implicitHeight : 0
            Layout.minimumHeight: visible ? implicitHeight : 0
            Layout.maximumHeight: visible ? implicitHeight : 0
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: control.minContentHeight
            implicitHeight: control.minContentHeight
            radius: 12
            border.width: 1
            border.color: Quark.Palette.border
            clip: true
        }
    }
}
```

## 11. 发布前检查清单

每个通用控件提交前至少确认：

- 没有 `parent.parent` 之类祖先耦合
- 没有依赖示例页面的 id 或结构
- 没有调试 Rectangle/console 噪声遗留
- 有合理 `implicitWidth` / `implicitHeight`
- 可在 Layout 和 anchors 两类宿主中使用
- 内部主要区域有清晰边界
- 文本溢出已处理
- loading/empty/error/disabled 状态可用
- 颜色来自主题
- 信号和属性命名表达稳定语义

## 12. 本项目当前经验结论

这次文件管理器问题的本质不是列表高度错误，而是通用控件的内容承载区没有正确向父布局报告隐式尺寸，导致卡片边框只包住标题，内容因为 `clip: false` 显示到了边框外。

真正的修复方向是：

1. 修复基础容器 `QuarkCard` 的内容槽设计。
2. 让复合控件内部使用 `ColumnLayout` 管理结构。
3. 给主内容区域增加视觉边界。
4. 把验证辅助层移出控件内容槽。

这类问题通常不会在写第一版时立刻报错，但会在组合控件、嵌套布局、示例验证时暴露。以后遇到类似现象，应优先检查控件契约和布局层级，而不是先补高度公式。
