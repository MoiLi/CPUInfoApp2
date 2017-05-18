import QtQuick 2.0

ListView {
    clip: true

    delegate: infoDelegate
    model: ListModel{}
    section.property: "name"
    section.criteria: ViewSection.FullString
    section.delegate: sectionDelegate

    Component {
        id: sectionDelegate
        Rectangle {
            width: ListView.view.width
            height:30
            color: Qt.darker("#a1a1a1")
            radius: 2
            Text {
                anchors.leftMargin: 4
                anchors.rightMargin: 4
                anchors.verticalCenter: parent.verticalCenter
                id: sectionTitle
                text: section
                font.pixelSize: 24
                font.bold: true
                color: "white"
                width: parent.width
            }
        }
    }

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

                Grid {
                    spacing: 8

                    columns: 6
                    Repeater {
                        model: value.split(" ")

                        Text {
                            id: content
                            text: modelData

                            color: "#a1a1a1"
                            font.italic: true
                            font.pixelSize: 16
                        }
                    }
                }
            }
        }
    }
}

