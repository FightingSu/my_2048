import QtQuick 2.10

Rectangle {
    id: root
    antialiasing: true

    property var text: label.text;

    onTextChanged: {
        label.text = text
    }

    Text {
        id: label;
        text: qsTr("roundButton");

    }

    Rectangle {
        id: background;

        color: "#bbada0";
        radius: 8;
    }
}

