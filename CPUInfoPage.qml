import QtQuick 2.0

ListView {

    delegate: infoDelegate
    model: ListModel{}
    Component {
        id: infoDelegate

        Item {
            id: wrapper
            width: parent.width
            height: contactInfo.height + 8
            clip: true
            anchors.leftMargin: 10
            Column {
                id: contactInfo
                anchors.verticalCenter: parent.verticalCenter
                spacing: 6
                Text {
                    text: name
                    font.pixelSize: 14
                    font.bold: true
                    color: "white"
                }
                Grid {
                    spacing: 8

                    columns: 6
                    Repeater {
                        model: value.split(" ")

                        Text {
                            text: modelData
                            color: "#a1a1a1"
                            font.italic: true
                            font.pixelSize: 12
                        }
                    }
                }
            }
        }
    }
}

