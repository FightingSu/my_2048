import QtQuick 2.4

Item {
    id: root
    width: 150
    height: 100

    property int score: 0

    Rectangle {
        id: rootBak
        width: parent.width;
        height: parent.height;
        color: "#bbada0"
        radius: 8
        anchors.fill: parent

        Text {
            id: text1
            color: "#d6cdc3"
            text: qsTr("Score")
            font.pointSize: 13
            anchors.horizontalCenterOffset: 0
            anchors.top: parent.top
            anchors.topMargin: 14
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 8
            font.family: "Arial"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: scoreText
            y: 7
            color: "#f9f6f2"
            text: score;
            font.bold: true
            font.pointSize: 18
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Verdana"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

    onScoreChanged: {
        scoreText.text = score
    }
}
