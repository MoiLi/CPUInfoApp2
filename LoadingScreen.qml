import QtQuick 2.0

import QtQuick.Controls 1.4


Rectangle {
    color: "black"
    anchors.fill: parent

    function hide() {
        visible = false;
    }

    Text{
        id: loader
        anchors.centerIn: parent

        font.family: "Helvetica"
        font.pointSize: 24
        color: "blue"
        text:qsTr("Loding")
    }

    BusyIndicator {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: loader.top
        anchors.bottomMargin: 6
        running: parent.visible === true;
    }

}
