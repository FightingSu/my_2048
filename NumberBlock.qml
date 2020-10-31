import QtQuick 2.10

Item {
    id: root
    width: 200
    height: 200
    property int number: 2
    property string backgoundColor:"transprant"
    property int radius: width * 0.1;
    property int fontSize: root.width / 2;

    Rectangle {
        id: bak

        radius: root.radius
        //border.color: "black"
        color: backgoundColor
        anchors.centerIn: root
        anchors.fill: root
    }

    Text {
        id: num
        font.pixelSize: fontSize
        font.bold: true
        text: number
        color: "transparent";
        anchors.centerIn: root
    }

    Behavior on x{
        NumberAnimation {
            duration: 50;
        }
    }

    Behavior on y{
        NumberAnimation {
            duration: 50;
        }
    }

    function numberLength() {
        var tmpNumber = number;
        var lengthCounter = 0;
        while (tmpNumber / 10 > 1) {
            tmpNumber = tmpNumber / 10;
            ++lengthCounter;
        }
        return lengthCounter;
    }

    onNumberChanged: {
        switch (number) {
        case 0:
            backgoundColor = "transparent";
            num.color = "transparent";
            break;
        case 2:
            backgoundColor = "#eee4da";
            num.color = "black";
            break;
        case 4:
            backgoundColor = "#ede0c8";
            num.color = "black";
            break;
        case 8:
            backgoundColor = "#f2b179";
            num.color = "black";
            break;
        case 16:
            backgoundColor = "#f59563";
            num.color = "black";
            break;
        case 32:
            backgoundColor = "#f67c5f";
            num.color = "black";
            break;
        case 64:
            backgoundColor = "#f65e3b";
            num.color = "black";
            break;
        case 128:
            backgoundColor = "#edcf72";
            num.color = "black";
            break;
        case 256:
            backgoundColor = "#edcc61";
            num.color = "black";
            break;
        case 512:
            backgoundColor = "#edc850";
            num.color = "black";
            break;
        case 1024:
            backgoundColor = "#edc53f";
            num.color = "black";
            break;
        case 2048:
            backgoundColor = "#edc22e";
            num.color = "black";
            break;
        default:
            backgoundColor = "#3c3a32";
            num.color = "black";
            break;
        }

        if (number > 999) {
            num.font.pixelSize = bak.width / numberLength();
        } else {
            num.font.pixelSize = bak.width / 2;
        }

/*
        backgoundColor =
            number <=    1 ? "#80F0F0F0" :
            number <=    2 ? "#eee4da" :
            number <=    4 ? "#ede0c8" :
            number <=    8 ? "#f2b179" :
            number <=   16 ? "#f59563" :
            number <=   32 ? "#f67c5f" :
            number <=   64 ? "#f65e3b" :
            number <=  128 ? "#edcf72" :
            number <=  256 ? "#edcc61" :
            number <=  512 ? "#edc850" :
            number <= 1024 ? "#edc53f" :
            number <= 2048 ? "#edc22e" :
                           "#3c3a32";
        num.color =
            number <= 1 ? "transparent" :
                                 "black";
*/
    }
}
