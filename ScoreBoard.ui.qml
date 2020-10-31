import QtQuick 2.4

Item {
    id: root
    width: 400
    height: 40

    property int score: 0

    Rectangle {
        id: rootBak
        color: "#ebbb6f"
        anchors.fill: parent

        Row {
            id: rowLayout
            layoutDirection: Qt.LeftToRight
            anchors.fill: parent
            spacing: 20

            Text {
                id: text1
                color: "#675146"
                text: qsTr("Score: ")
                font.family: "Arial"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 40
            }

            Text {
                id: scoreText
                color: "#86746c"
                text: score;
                anchors.left: text1.right
                anchors.leftMargin: -126
                anchors.right: parent.right
                anchors.rightMargin: 400
                font.family: "Times New Roman"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 30
            }
        }
    }

    onScoreChanged: {
        scoreText.text = score
    }
}
