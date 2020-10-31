import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    id: window
    visible: true
    width: 450
    height: 800
    title: qsTr("My 2048")

    Rectangle{
        id: windowRect;
        height: parent.height;
        width: parent.width;
        anchors.fill: parent;
        color: "#faf8ef"

        RowLayout {
            id: scoreBoardRect
            x: 40
            y: 100
            width: windowRect.width * 0.9;
            height: label_2048.height;
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                id: label_2048
                text: qsTr("2048");
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 54
                font.family: "Microsoft YaHei UI"
                font.bold: true
                style: Text.Normal
                height: scoreBoardRect.height;
                color: "#99816a"
            }

            ScoreBoard{
                id: scoreBoard;
                height: label_2048.height;
                anchors.top: parent.top
                anchors.topMargin: parent.height * 0.1
                anchors.bottom: parent.bottom;
                anchors.bottomMargin: parent.height * 0.1;
                anchors.right: parent.right
                anchors.rightMargin: 0
                score: 0
                width: scoreBoardRect.height * 1.5;
            }
        }

        RowLayout {
            id: btnGroup
            width: restart_btn.width + setting_btn.width + spacing
            height: scoreBoardRect.height * 0.5
            spacing: 20
            anchors.topMargin: scoreBoardRect.height * 0.3
            anchors.top: scoreBoardRect.bottom;
            anchors.left: scoreBoardRect.left
            anchors.leftMargin: 0

            Button {
                id: restart_btn
                text: " Restart "
                scale: 1
                Layout.fillHeight: true
                anchors.left: parent.left
                anchors.top: parent.top

                onClicked: {
                    gridField.restart();
                }

                background: Rectangle {
                    color: "#bbada0";
                    radius: 8;
                }

                contentItem: Label {
                    height: 20
                    color: "white";
                    text: restart_btn.text;
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Microsoft YaHei UI"
                    font.bold: true;
                }

            }

            Button {
                id: setting_btn;
                text: " Settings "
                Layout.fillHeight: true
                anchors.right: parent.right
                anchors.top: parent.top

                onClicked: {

                }

                background: Rectangle {
                    color: "#bbada0";
                    radius: 8;
                }

                contentItem: Label {
                    id: setting_label
                    color: "white";
                    text: setting_btn.text;
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: "Microsoft YaHei UI"
                    font.bold: true
                }
            }
        }

    }


    GridField {
        id: gridField;
        y: 465
        size: 4;
        scale: 0.95
        width: windowRect.width
        height: windowRect.width
        anchors.bottomMargin: 50
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left

        onScoreChanged: {
            scoreBoard.score = score
        }
    }
}
/*
    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        focus: true
        initialItem: "Example.qml"

        anchors.fill: parent
    }*/
