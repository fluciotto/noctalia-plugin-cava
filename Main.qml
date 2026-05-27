import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Services.UI

Item {
    id: root

    // Plugin API (injected by PluginService)
    property var pluginApi: null

    readonly property variant settings: pluginApi?.pluginSettings ?? pluginApi?.manifest?.metadata?.defaultSettings

    function writeCavaConfiguration() {
        // const settings = pluginApi?.pluginSettings ?? pluginApi?.manifest?.metadata?.defaultSettings;
        const conf = `[general]
live-config = 1
framerate = ${settings?.cavaFramerate}
autosens = ${settings?.cavaAutosens ? 1 : 0}
sensitivity = ${settings?.cavaSensitivity}
bars = ${settings?.cavaBars}
lower_cutoff_freq = ${settings?.cavaLowerCutoffFreq}
higher_cutoff_freq = ${settings?.cavaHigherCutoffFreq}

[output]
channels = ${settings?.cavaChannels}
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 8
; waveform = 1

[smoothing]
noise_reduction = ${settings?.cavaNoiseReduction}`;
        cavaConfigurationFile.setText(conf);
    }

    Component.onCompleted: {
        Logger.i("Cava", "Plugin started.");
    }

    Item {
        id: service
        property var writeCavaConfigurationFunc: writeCavaConfiguration
        property string line: ""
        property var bars: []

        Component.onCompleted: {
            Logger.i("Cava", "Generating cava configuration...");
            writeCavaConfiguration();
            Logger.i("Cava", "Cava process starting...");
            cavaProcess.running = true;
        }

        FileView {
            id: cavaConfigurationFile
            path: "/tmp/noctalia_cava.conf"
        }

        property Process cavaProcess: Process {
            running: false
            command: ["cava", "-p", cavaConfigurationFile.path]
            stdout: SplitParser {
                id: stdoutCollector
                splitMarker: '\n'
            }
            stderr: StdioCollector {
                id: stderrCollector
                onDataChanged: {
                    Logger.e("Cava", `Error: ${stderrCollector.data}`);
                }
            }
            onStarted: {
                Logger.i("Cava", `Cava process started (pid ${service.cavaProcess.processId})`);
                stdoutCollector.read.connect(data => {
                    const bars = " ▁▂▃▄▅▆▇█";
                    service.line = data.split(";").map(e => Array(settings?.barWidth).fill(bars[parseInt(e)]).join("")).join("");
                    // service.bars = data.split(";").map(e => parseInt(e) / 8);
                });
            }
            onExited: {
                Logger.i("Cava", `Cava process exited (pid ${service.cavaProcess.processId})`);
            }
        }
    }

    property alias cavaService: service
}
