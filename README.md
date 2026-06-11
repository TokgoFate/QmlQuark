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

## 构建与调试入口

新增了一个可运行的 Qt Quick 调试程序：

- CMake: `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/CMakeLists.txt`
- 入口: `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/src/main.cpp`
- 调试界面: `/home/runner/work/QmlQuark/QmlQuark/TokgoFate/QmlQuark/examples/DebugWindow.qml`

本地构建示例（需已安装 Qt5/Qt6 的 Quick 与 QuickControls2）：

```bash
cmake -S . -B build
cmake --build build
./build/QmlQuarkDemo
```

## Debug QML 直载

调试程序在不同构建模式下有两套加载策略：

- Debug 构建：优先从工作区磁盘文件直接加载 `examples/DebugWindow.qml`，并将 `src` 加入 QML import path
- 非 Debug 构建：继续使用 `resources.qrc` 中打包的 `qrc:/` 资源

这意味着在 Debug 下修改以下目录中的 QML 文件后，不需要重新构建即可让程序读取到最新内容：

- `examples/`
- `src/QmlQuark/`

调试窗口标题栏还提供了一个 `Reload QML` 按钮，会清理 QML 组件缓存并重新加载当前界面，方便手动验证界面改动。

注意事项：

- 这套机制只针对 QML 文件热更新
- 如果修改了 C++ 代码、CMake 配置、`resources.qrc` 或模块结构，仍然需要重新构建
