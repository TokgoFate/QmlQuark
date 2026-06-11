# QmlQuark

QmlQuark 是一个基于 QML 的轻量组件库骨架，面向现代、工业、圆润风格的桌面/嵌入式界面。

当前仓库提供了：

- 清晰的目录结构，基础控件与组合控件分离
- 可独立复用的 QML 组件文件
- 可集中替换的主题色彩与字体令牌
- 一组代表性的基础控件与组合控件示例

## 目录结构

```text
src/QmlQuark/
├── qmldir
├── Theme/
│   ├── Palette.qml
│   └── Typography.qml
├── Controls/
│   ├── QuarkButton.qml
│   ├── QuarkDropdown.qml
│   ├── QuarkProgressBar.qml
│   ├── QuarkSelectBox.qml
│   └── QuarkTextField.qml
└── Composites/
    ├── QuarkAlertDialog.qml
    ├── QuarkCard.qml
    ├── QuarkDialog.qml
    ├── QuarkFileManager.qml
    └── QuarkPromptDialog.qml
```

## 使用方式

在实际项目中可直接拷贝 `src/QmlQuark` 目录，或将其作为一个本地 QML 模块导入。

```qml
import "../src/QmlQuark" as Quark

Quark.QuarkCard {
    title: "设备状态"

    Quark.QuarkProgressBar {
        value: 0.68
    }
}
```

## 主题定制

公共颜色与字体分别定义在：

- `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/src/QmlQuark/Theme/Palette.qml`
- `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/src/QmlQuark/Theme/Typography.qml`

实际使用时可直接修改这两个文件中的令牌值，以快速切换整体主题风格。

## 示例

示例页面位于：

- `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/examples/Gallery.qml`
