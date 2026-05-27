import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Commons
import qs.Services.UI
import qs.Widgets
// import qs.Widgets.AudioSpectrum

Item {
    id: root

    // Plugin API (injected by PluginService)
    property var pluginApi: null

    // Required properties for bar widgets
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    // UI properties
    readonly property string screenName: screen?.name ?? ""
    readonly property string barPosition: Settings.getBarPositionForScreen(screenName)
    readonly property bool isBarVertical: barPosition === "left" || barPosition === "right"
    readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screenName)
    readonly property real barFontSize: Style.getBarFontSizeForScreen(screenName)

    // Cava service
    property var cavaService: pluginApi?.mainInstance?.cavaService || null

    readonly property real contentWidth: isBarVertical ? capsuleHeight : layout.implicitWidth + Style.marginM * 2
    readonly property real contentHeight: isBarVertical ? layout.implicitHeight + Style.marginM * 2 : capsuleHeight

    implicitWidth: contentWidth
    implicitHeight: contentHeight

    // Visual capsule - centered within the full click area
    Rectangle {
        id: visualCapsule
        x: Style.pixelAlignCenter(parent.width, width)
        y: Style.pixelAlignCenter(parent.height, height)
        width: root.contentWidth
        height: root.contentHeight
        color: Style.capsuleColor
        radius: Style.radiusL
        border.color: Style.capsuleBorderColor
        border.width: Style.capsuleBorderWidth
        Item {
            id: layout
            anchors.centerIn: parent
            implicitWidth: isBarVertical ? rowLayout.implicitHeight : rowLayout.implicitWidth
            implicitHeight: isBarVertical ? rowLayout.implicitWidth : rowLayout.implicitHeight
            RowLayout {
                id: rowLayout
                anchors.centerIn: parent
                spacing: Style.marginS
                NText {
                    id: text
                    text: cavaService.line
                    color: Color.mPrimary
                    pointSize: barFontSize
                    font.family: "Monospace"
                    rotation: barPosition === "left" ? -90 : barPosition === "right" ? 90 : 0
                }
                // NLinearSpectrum {
                //     values: cavaService.bars
                //     vertical: isBarVertical
                //     mirrored: false
                //     visible: true
                //     width: 600
                //     height: 20
                // }
            }
        }
    }

    NPopupContextMenu {
        id: contextMenu

        model: [
            {
                "label": pluginApi?.tr("menu.settings"),
                "action": "settings",
                "icon": "settings"
            }
        ]

        onTriggered: action => {
            // Always close the menu first
            contextMenu.close();
            PanelService.closeContextMenu(screen);

            // Handle actions
            if (action === "refresh") {
                // Perform refresh
            } else if (action === "settings") {
                BarService.openPluginSettings(screen, pluginApi.manifest);
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onEntered: {
            TooltipService.show(root, "Cava audio visualizer", BarService.getTooltipDirection());
        }

        onExited: {
            TooltipService.hide();
        }

        onClicked: mouse => {
            /* if (mouse.button === Qt.LeftButton) {
                pluginApi?.openPanel(root.screen, root);
            } else */if (mouse.button === Qt.RightButton) {
                PanelService.showContextMenu(contextMenu, root, screen);
            }
        }
    }
}
