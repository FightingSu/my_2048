import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.2
import "methods.js" as Funclib

Item {
    id: root;
    //title: "Grid Test";
    focus: true;
    width: 480;
    height: 480;
    // 成员
    property int size: 4;
    property var blockArr: new Array(size * size);
    property int blockSpacing: 20;
    property int score: 0;

//    Rectangle {
//        id: background;
//        anchors.fill: parent;
//        anchors.centerIn: parent;
//        color: "grey";
//    }

    Keys.onPressed: {
        switch (event.key) {
        case Qt.Key_Up:
            console.log("up");
            break;
        case Qt.Key_Down:
            console.log("down");
            break;
        case Qt.Key_Left:
            console.log("left");
            break;
        case Qt.Key_Right:
            console.log("right");
            break;
        default:
        }
        Funclib.move(event.key);
    }

    MouseArea {
        anchors.fill: parent
        property int minimumLength: root.width < root.height ? root.width / (size + 1) : root.height / (size + 1)
        property int startX
        property int startY
        onPressed: {
            startX = mouse.x
            startY = mouse.y
        }

        onReleased: {
            var length = Math.sqrt(Math.pow(mouse.x - startX, 2) + Math.pow(mouse.y - startY, 2))
            if (length < minimumLength)
                return
            var diffX = mouse.x - startX
            var diffY = mouse.y - startY
            // not sure what the exact angle is but it feels good
            if (Math.abs(Math.abs(diffX) - Math.abs(diffY)) < minimumLength / 2)
                return
            if (Math.abs(diffX) > Math.abs(diffY))
                if (diffX > 0)
                    Funclib.move(Qt.Key_Right)
                else
                    Funclib.move(Qt.Key_Left)
            else
                if (diffY > 0)
                    Funclib.move(Qt.Key_Down)
                else
                    Funclib.move(Qt.Key_Up)

        }

    }

    Rectangle {
        id: gridBak;
        color: "#bbada0";
        width: root.width;
        height: root.width;
        radius: width * 0.05;
        anchors.centerIn: parent;
        //anchors.fill: myGrid;
        Grid {
            id: gridBak_child;
            spacing: blockSpacing
            columns: size;
            rows: size;
            width: root.width * 0.9;
            height: root.width * 0.9;
            anchors.centerIn: gridBak;
            focus: true;
            Repeater {
                model: size * size;
                Rectangle {
                    //border.color: "black"
                    color: "#80F0F0F0";
                    radius: width * 0.1;
                    scale: 0.95;
                    width: (myGrid.width - myGrid.spacing * (size - 1)) / size;
                    height: (myGrid.width - myGrid.spacing * (size - 1)) / size;
                }
            }
        }
    }

    Grid {
        id: myGrid;
        spacing: blockSpacing
        columns: size;
        rows: size;
        width: root.width * 0.9;
        height: root.width * 0.9;
        anchors.centerIn: gridBak;
        focus: true;
    }

    Component.onCompleted: {
        setupFunclib(Funclib);
        Funclib.createBlock(myGrid);
        var randomPos_1 = Funclib.randomPos();
        var randomPos_2 = Funclib.randomPos();
        blockArr[randomPos_1].number =
                Math.random() < 0.9 ? 2: 4;
        blockArr[randomPos_2].number =
                Math.random() < 0.9 ? 2: 4;
        Funclib.createNewBlockAnimation(blockArr[randomPos_1]);
        Funclib.createNewBlockAnimation(blockArr[randomPos_2]);
    }

    function setupFunclib(_Funclib) {
        _Funclib.blockArr = blockArr;
        _Funclib.size = size;
        _Funclib.root = root;
        _Funclib.myGrid = root.myGrid;
        _Funclib.score = score;
    }

    function restart() {
        score = 0;
        Funclib.cleanUp();
        setupFunclib(Funclib);
        Funclib.createBlock(myGrid);
        var randomPos_1 = Funclib.randomPos();
        var randomPos_2 = Funclib.randomPos();
        blockArr[randomPos_1].number =
                Math.random() < 0.9 ? 2: 4;
        blockArr[randomPos_2].number =
                Math.random() < 0.9 ? 2: 4;
        Funclib.createNewBlockAnimation(blockArr[randomPos_1]);
        Funclib.createNewBlockAnimation(blockArr[randomPos_2]);
    }

/*
    Button {
        id: createBtn;
        text: "Create item in Grid";
        anchors.left: parent.left;
        anchors.bottom: parent.bottom;
        onClicked: {
            createBlock(size, blockArr, myGrid);
        }
    }

    Button {
        id: cleanBtn;
        text: "Clean Up";
        anchors.left: createBtn.right;
        anchors.bottom: parent.bottom;
        onClicked: {
            cleanUp(blockArr)
        }
    }

    Button {
        id: colorChanger;
        text: "随机改变颜色"
        anchors.left: cleanBtn.right
        anchors.bottom: parent.bottom
        onClicked: {
            var Pos = randomPos(size, blockArr);
            blockArr[Pos].number += 2;
        }
    }
*/

}

