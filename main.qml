import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import org.device.info 1.0;

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello CPU")
    color: "black"

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        leftPadding: 16
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        visible: !loading.visible
    }

    LoadingScreen {
        id: loading
    }

    CPUInfo {
        id : cpuInfo
        source: "/proc/cpuinfo"

        onDataChanged: {
            // iterate the numnber of the processors.
            for (var i=0; i < data.length; i++) {
                // For each processor, create a buttom tab.
                var tab = Qt.createQmlObject("import QtQuick 2.7;import QtQuick.Controls 2.0; TabButton{}", tabBar, "tab"+i );
                tab.text ="Processor " + i

                // Also created a page to show that processors detail
                var page = Qt.createQmlObject("import QtQuick 2.7;import QtQuick.Controls 2.0; CPUInfoPage{}", swipeView, "page"+i );

                // The page is a list view, update its model
                for (var k in data[i]) {
                    page.model.append({"name":k, "value": data[i][k]});
                }

            }
            // hide the loading screen.
            timer.start()
        }
    }

    Timer {
        id: timer
        interval: 1500; running: false;
        onTriggered: {
            loading.hide()
        }
    }

    Component.onCompleted: {
        // request to fetch the cpu info.
        cpuInfo.startLoadCPUInfo();
    }
}
