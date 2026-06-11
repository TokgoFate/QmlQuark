cmake_minimum_required(VERSION 3.16)

project(QmlQuarkDemo VERSION 0.1 LANGUAGES CXX)

file(TO_CMAKE_PATH "${CMAKE_SOURCE_DIR}" QMLQUARK_SOURCE_DIR)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Quick QuickControls2)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Quick QuickControls2)

add_executable(QmlQuarkDemo
    src/main.cpp
    resources.qrc
)

target_link_libraries(QmlQuarkDemo PRIVATE
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::QuickControls2
)

target_compile_definitions(QmlQuarkDemo PRIVATE
    QMLQUARK_SOURCE_DIR="${QMLQUARK_SOURCE_DIR}"
)

if(QT_VERSION_MAJOR EQUAL 6)
    qt_finalize_executable(QmlQuarkDemo)
endif()
