import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Widgets

ColumnLayout {
    id: root

    // Plugin API (injected by the settings dialog system)
    property var pluginApi: null

    property var cavaService: pluginApi?.mainInstance?.cavaService || null

    // Local state for editing
    property int editBarWidth: pluginApi?.pluginSettings?.barWidth ?? pluginApi?.manifest?.metadata?.defaultSettings?.barWidth
    property string editCavaChannels: pluginApi?.pluginSettings?.cavaChannels ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaChannels
    property int editCavaAutosens: pluginApi?.pluginSettings?.cavaAutosens ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaAutosens
    property int editCavaSensitivity: pluginApi?.pluginSettings?.cavaSensitivity ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaSensitivity
    property int editCavaFramerate: pluginApi?.pluginSettings?.cavaFramerate ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaFramerate
    property int editCavaBars: pluginApi?.pluginSettings?.cavaBars ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaBars
    property int editCavaLowerCutoffFreq: pluginApi?.pluginSettings?.cavaLowerCutoffFreq ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaLowerCutoffFreq
    property int editCavaHigherCutoffFreq: pluginApi?.pluginSettings?.cavaHigherCutoffFreq ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaHigherCutoffFreq
    property int editCavaNoiseReduction: pluginApi?.pluginSettings?.cavaNoiseReduction ?? pluginApi?.manifest?.metadata?.defaultSettings?.cavaNoiseReduction

    spacing: Style.marginM

    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.barwidth")
            description: pluginApi?.tr("settings.barwidth_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 1
                to: 10
                stepSize: 1
                value: root.editBarWidth
                onValueChanged: root.editBarWidth = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editBarWidth
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.channels")
            description: pluginApi?.tr("settings.channels_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NComboBox {
                Layout.fillWidth: true
                model: [
                    {
                        key: "mono",
                        name: "Mono"
                    },
                    {
                        key: "stereo",
                        name: "Stereo"
                    }
                ]
                currentKey: root.editCavaChannels
                onSelected: root.editCavaChannels = key
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.autosens")
            description: pluginApi?.tr("settings.autosens_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 0
                to: 100
                stepSize: 1
                value: root.editCavaAutosens
                onValueChanged: root.editCavaAutosens = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaAutosens
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.sensitivity")
            description: pluginApi?.tr("settings.sensitivity_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 10
                to: 500
                stepSize: 10
                value: root.editCavaSensitivity
                onValueChanged: root.editCavaSensitivity = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaSensitivity
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.framerate")
            description: pluginApi?.tr("settings.framerate_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 5
                to: 120
                stepSize: 5
                value: root.editCavaFramerate
                onValueChanged: root.editCavaFramerate = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaFramerate
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.bars")
            description: pluginApi?.tr("settings.bars_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 4
                to: 128
                value: root.editCavaBars
                onValueChanged: root.editCavaBars = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaBars
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.lowerCutoffFrequency")
            description: pluginApi?.tr("settings.lowerCutoffFrequency_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 20
                to: 20000
                value: root.editCavaLowerCutoffFreq
                onValueChanged: root.editCavaLowerCutoffFreq = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaLowerCutoffFreq
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.higherCutoffFrequency")
            description: pluginApi?.tr("settings.higherCutoffFrequency_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 20
                to: 20000
                // step: 30
                value: root.editCavaHigherCutoffFreq
                onValueChanged: root.editCavaHigherCutoffFreq = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaHigherCutoffFreq
            }
        }
    }
    ColumnLayout {
        Layout.fillWidth: true
        spacing: Style.marginS
        NLabel {
            label: pluginApi?.tr("settings.noiseReduction")
            description: pluginApi?.tr("settings.noiseReduction_desc")
        }
        RowLayout {
            spacing: Style.marginM
            NSlider {
                Layout.fillWidth: true
                from: 0
                to: 100
                value: root.editCavaNoiseReduction
                onValueChanged: root.editCavaNoiseReduction = value
            }
            NLabel {
                Layout.fillWidth: false
                label: root.editCavaNoiseReduction
            }
        }
    }

    // Required: Save function called by the dialog
    function saveSettings() {
        pluginApi.pluginSettings.barWidth = root.editBarWidth;
        pluginApi.pluginSettings.cavaChannels = root.editCavaChannels;
        pluginApi.pluginSettings.cavaAutosens = root.editCavaAutosens;
        pluginApi.pluginSettings.cavaSensitivity = root.editCavaSensitivity;
        pluginApi.pluginSettings.cavaFramerate = root.editCavaFramerate;
        pluginApi.pluginSettings.cavaBars = root.editCavaBars;
        pluginApi.pluginSettings.cavaLowerCutoffFreq = root.editCavaLowerCutoffFreq;
        pluginApi.pluginSettings.cavaHigherCutoffFreq = root.editCavaHigherCutoffFreq;
        pluginApi.pluginSettings.cavaNoiseReduction = root.editCavaNoiseReduction;
        pluginApi.saveSettings();
        cavaService.writeCavaConfigurationFunc();
    }
}
