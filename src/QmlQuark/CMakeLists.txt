# src/CMakeLists.txt

# 自动收集所有 .h .cpp 文件
file(GLOB_RECURSE SRC_HEADERS "*.h")
file(GLOB_RECURSE SRC_SOURCES "*.cpp")
file(GLOB_RECURSE SRC_QRC "*.qrc")

add_library(QmlQuarkLib OBJECT
    ${SRC_HEADERS}
    ${SRC_SOURCES}
    ${SRC_QRC}
)

list(APPEND QML_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(QML_IMPORT_PATH ${QML_PATH}
    CACHE STRING "QML import paths for Qt Creator"
    FORCE
)

message("SRC_QRC = " ${SRC_QRC})
message("QML_IMPORT_PATH = " ${QML_IMPORT_PATH})

# 设置头文件包含路径
target_include_directories(QmlQuarkLib PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

# 链接 Qt 库
target_link_libraries(QmlQuarkLib PUBLIC
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::QuickControls2
)