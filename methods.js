// 统计数组不为 undefined
var blockArr;
var size;
var root;
var myGrid;

// 储存方块正确位置
// 因为绘图要另开线程，位置不确定
var posArr;

function initRightPos() {
    posArr = new Array(size * size);

    for (var i = 0; i < size; ++i) {
        for (var j = 0; j < size; ++j) {
            posArr[transPos(i, j)] = new Array(2);
            posArr[transPos(i, j)][0] = blockArr[transPos(i, j)].x;
            posArr[transPos(i, j)][1] = blockArr[transPos(i, j)].y;
        }
    }
}

function printGrid() {
    console.log("__new log__");
    for (var i = 0; i < size; ++i) {

        console.log(blockArr[transPos(0, i)].number,
                    blockArr[transPos(1, i)].number,
                    blockArr[transPos(2, i)].number,
                    blockArr[transPos(3, i)].number);
        console.log("(" + blockArr[transPos(0, i)].x + ", " + blockArr[transPos(0, i)].y + ")",
                    "(" + blockArr[transPos(1, i)].x + ", " + blockArr[transPos(1, i)].y + ")",
                    "(" + blockArr[transPos(2, i)].x + ", " + blockArr[transPos(2, i)].y + ")",
                    "(" + blockArr[transPos(3, i)].x + ", " + blockArr[transPos(3, i)].y + ")");
    }
}

// 方法
// 根据传入的位置创建方块
function createBlock (_addTarget) {
    var component = Qt.createComponent("NumberBlock.qml");
    for (var i = 0; i < size * size; i += 1) {
        if (component.status === Component.Ready) {
            blockArr[i] = component.createObject(_addTarget);
            blockArr[i].width = (_addTarget.width - _addTarget.spacing * (size - 1)) / size;
            blockArr[i].height = (_addTarget.width - _addTarget.spacing * (size - 1)) / size;
            blockArr[i].number = 0;
        }
    }
}

// 清理界面
function cleanUp() {
    for (var x = 0; x < blockArr.length; x += 1) {
        if (blockArr[x] !== undefined) {
            blockArr[x].destroy();
            blockArr[x] = undefined;
        }
    }
}

// 按照传入的尺寸和数组随机产生方块
function randomPos () {
    // 避免死循环
    var counter = 0;
    for (var i = 0; i < size * size; i += 1) {
        if (blockArr[i].number !== 0) {
            counter += 1;
        }
    }

    if (counter !== size * size) {
        // 随机一个位置
        var Pos = Math.floor(Math.random() * 100 % size * size);
        while (blockArr[Pos].number !== 0) {
            Pos = Math.floor(Math.random() * 100 % size * size);
        }
        return Pos;
    } else {
        return undefined;
    }
}

function merge(block1, block2) {
    if (blockArr[block1].number !== 0 && blockArr[block2].number !== 0
            && blockArr[block1].number === blockArr[block2].number) {
        var num = blockArr[block1].number;
        blockArr[block1].number = 0;
        doSwap(block1, block2);
        blockArr[block2].number = 0;
        blockArr[block1].number = num * 2;
        // 合并计分
        root.score = root.score + num * 2;
        return true;
    } else {
        return false;
    }
}

function doSwap(block1, block2) {

    blockArr[block1].y = posArr[block2][1];
    blockArr[block2].y = posArr[block1][1];

    blockArr[block1].x = posArr[block2][0];
    blockArr[block2].x = posArr[block1][0];

    var num = blockArr[block1];
    blockArr[block1] = blockArr[block2];
    blockArr[block2] = num;
}

// 检查可否合并
function checkMergeable(_abc) {

    return ;
}

// 变换坐标为数组下标
function transPos(_xPos, _yPos) {
    return _xPos + _yPos * size;
}

function createNewBlockAnimation(_target) {
    var component = Qt.createQmlObject(
    "import QtQuick 2.10;\
    PropertyAnimation {
       property: \"scale\";
       easing.type: Easing.OutElastic;
    }", _target);
    component.target = _target;
    component.duration = 800;
    component.from = 0.3;
    component.to = 1;
    component.start();
    component.destroy(800);
}

function createScaleAnimation(_target) {
    var component = Qt.createQmlObject(
        "import QtQuick 2.10;\
            PropertyAnimation {
            property: \"scale\";
            easing.type: Easing.OutElastic;
        }", _target);
    component.target = _target;
    component.duration = 400;
    component.from = 0.5;
    component.to = 1;
    component.start();
    component.destroy(400);
}

function Timer(_target) {
    var timer = Qt.createQmlObject(
        "import QtQuick 2.10;\
            Timer { }
        ", _target);
    return timer;
}

// 1 上
// 2 下
// 3 左
// 4 右
function move(_direction) {
    initRightPos();
    //console.log("move!");
    var xPos = 0;
    var yPos = 0;
    var lastPos = 0;
    var lastXPos = 0;
    var lastYPos = 0;

    var tmpY = 0;
    var tmpS;

    var didMerge = false;
    var didMove = false;

    switch (_direction) {

        /* 从滑动相反的方向读取
         * 当遇到空的时候，一直读取到有的块并移动（交换）
         * 当遇到数的时候，读到下一个数字，相等就合并，不相等就移动
         *
         */
    case Qt.Key_Up:
        for (xPos = 0; xPos < size; ++xPos) {
            yPos = 0;

            lastPos = transPos(xPos, yPos);
            lastXPos = xPos;
            lastYPos = yPos;
            while (yPos < size) {
                //console.log("from (" + xPos + ", " + yPos + ")");
                // 空的块
                if (blockArr[lastPos].number === 0) {
                    while (++yPos < size && blockArr[transPos(xPos, yPos)].number === 0);

                    if (yPos < size) {
                        didMove = true;
                        doSwap(transPos(xPos, yPos),lastPos);
                    }
                }
                // 不是空的
                else {
                    while (++yPos < size && blockArr[transPos(xPos, yPos)].number === 0);

                    if (yPos < size) {
                        if (blockArr[lastPos].number === blockArr[transPos(xPos, yPos)].number){

                            merge(lastPos, transPos(xPos, yPos));
                            createScaleAnimation(blockArr[lastPos]);
                            didMerge = true;
                            ++lastYPos;
                            lastPos = transPos(lastXPos, lastYPos);
                        }
                        else {
                            ++lastYPos;
                            lastPos = transPos(lastXPos, lastYPos);

                            if (lastPos !== transPos(xPos, yPos)) {
                                didMove = true;
                                doSwap(transPos(xPos, yPos),lastPos);
                            }
                        }
                    }
                }
            }
        }
        break;

    case Qt.Key_Down:
        for (xPos = 0; xPos < size; ++xPos) {
            yPos = size - 1;

            lastPos = transPos(xPos, yPos);
            lastXPos = xPos;
            lastYPos = yPos;
            while (yPos > -1) {
                // 空的块
                if (blockArr[lastPos].number === 0) {
                    while (--yPos > -1 && blockArr[transPos(xPos, yPos)].number === 0);

                    if (yPos > -1) {
                        didMove = true;
                        doSwap(transPos(xPos, yPos),lastPos);
                    }
                }
                // 不是空的
                else {
                    while (--yPos > -1 && blockArr[transPos(xPos, yPos)].number === 0);

                    if (yPos > -1 ) {
                        if (blockArr[lastPos].number === blockArr[transPos(xPos, yPos)].number){

                            merge(lastPos, transPos(xPos, yPos));
                            createScaleAnimation(blockArr[lastPos]);
                            didMerge = true;
                            --lastYPos;
                            lastPos = transPos(lastXPos, lastYPos);
                        }
                        else {
                            --lastYPos;
                            lastPos = transPos(lastXPos, lastYPos);

                            if (lastPos !== transPos(xPos, yPos)) {
                                didMove = true;
                                doSwap(transPos(xPos, yPos),lastPos);
                            }

                        }
                    }
                }
            }
        }
        break;

    case Qt.Key_Left:
        for (yPos = 0; yPos < size; ++yPos) {
            xPos = 0;

            lastPos = transPos(xPos, yPos);
            lastXPos = xPos;
            lastYPos = yPos;
            while (xPos < size) {
                // 空的块
                if (blockArr[lastPos].number === 0) {
                    while (++xPos < size && blockArr[transPos(xPos, yPos)].number === 0);

                    if (xPos < size) {
                        didMove = true;
                        doSwap(transPos(xPos, yPos),lastPos);
                    }
                }
                // 不是空的
                else {
                    while (++xPos < size && blockArr[transPos(xPos, yPos)].number === 0);

                    if (xPos < size) {
                        if (blockArr[lastPos].number === blockArr[transPos(xPos, yPos)].number){

                            merge(lastPos, transPos(xPos, yPos));
                            createScaleAnimation(blockArr[lastPos]);
                            didMerge = true;
                            ++lastXPos;
                            lastPos = transPos(lastXPos, lastYPos);
                        }
                        else {
                            ++lastXPos;
                            lastPos = transPos(lastXPos, lastYPos);

                            if (lastPos !== transPos(xPos, yPos)) {
                                didMove = true;
                                doSwap(transPos(xPos, yPos),lastPos);
                            }
                        }
                    }
                }
            }
        }
        break;

    case Qt.Key_Right:
        for (yPos = 0; yPos < size; ++yPos) {
            xPos = size - 1;

            lastPos = transPos(xPos, yPos);
            lastXPos = xPos;
            lastYPos = yPos;
            while (xPos > -1) {
                // 空的块
                if (blockArr[lastPos].number === 0) {
                    while (--xPos > -1 && blockArr[transPos(xPos, yPos)].number === 0);

                    if (xPos > -1) {
                        didMove = true;
                        doSwap(transPos(xPos, yPos),lastPos);
                    }
                }
                // 不是空的
                else {
                    while (--xPos > -1 && blockArr[transPos(xPos, yPos)].number === 0);

                    if (xPos > -1 ) {
                        if (blockArr[lastPos].number === blockArr[transPos(xPos, yPos)].number){

                            merge(lastPos, transPos(xPos, yPos));
                            createScaleAnimation(blockArr[lastPos]);
                            didMerge = true;
                            --lastXPos;
                            lastPos = transPos(lastXPos, lastYPos);
                        }
                        else {
                            --lastXPos;
                            lastPos = transPos(lastXPos, lastYPos);

                            if (lastPos !== transPos(xPos, yPos)) {
                                didMove = true;
                                doSwap(transPos(xPos, yPos),lastPos);
                            }
                        }
                    }
                }
            }
        }
        break;
    }


    var randomPosNum = randomPos();
    if (randomPosNum !== undefined && (didMerge || didMove)) {
        var timer = new Timer(blockArr[randomPosNum]);
        timer.repeat = false;
        timer.interval = 200;
        timer.triggered.connect(function() {
            blockArr[randomPosNum].number =
                    Math.random() < 0.9 ? 2: 4;
            createNewBlockAnimation(blockArr[randomPosNum]);
        });
        timer.start();
        //printGrid();
    } else {

    }
}

function createMoveAnimation(_target, _distination, _direction) {

    var animateComponent;
    var duration = 100;
    if (_direction === Qt.Key_Up || _direction === Qt.Key_Down)
    {
        animateComponent = Qt.createQmlObject(
            "import QtQuick 2.10;\
             PropertyAnimation {
                property: \"y\";
                //easing.type: Easing.InOutElastic;
             }", _target);

        var targetY = _target.y;
        animateComponent.from = _target.y;
        animateComponent.to = _distination.y;

        animateComponent.Component.destruction.connect(
            function() {
                console.log("SWAP");
                doSwap(_target, _distination);
                _target.y = targetY;
                _target.visible = true;
            }
        );
    } else {
        animateComponent = Qt.createQmlObject(
            "import QtQuick 2.10;\
             PropertyAnimation {
                id: moveAnimation;
                property: \"x\";
                //easing.type: Easing.InOutElastic;
             }", _target);

        var targetX = _target.x;
        animateComponent.from = _target.x;
        animateComponent.to = _distination.x;

        animateComponent.Component.destruction.connect(
            function() {
                console.log("SWAP");
                doSwap(_target, _distination);
                _target.x = targetX;
                _target.visible = true;
            }
        );
    }

    animateComponent.target = _target;
    animateComponent.duration = duration;
    animateComponent.start();
    //moveComponent.destroy(200);
    animateComponent.destroy(100);
}


// 合并函数
// 将 block2 合并至 block1 且 清空 block2
//function merge(block1, block2) {
//    if (block1.number !== 0 && block2.number !== 0 && block1.number === block2.number) {
//        block1.number += block2.number;
//        block2.number = 0;
//        return true;
//    } else {
//        return false;
//    }
//}
/*
function createMoveAnimation(_target, _distination, _direction) {

    var animateComponent;
    if (_direction === Qt.Key_Up || _direction === Qt.Key_Down)
    {
        animateComponent = Qt.createQmlObject(
            "import QtQuick 2.10;\
             PropertyAnimation {
                property: \"y\";
                easing.type: Easing.InOutElastic;
             }", _target);

        animateComponent.target = _target;

        animateComponent.from = _target.y;
        animateComponent.duration = 500;
        animateComponent.to = _distination.y;
    } else {
        animateComponent = Qt.createQmlObject(
            "import QtQuick 2.10;\
             PropertyAnimation {
                id: moveAnimation;
                property: \"x\";
                easing.type: Easing.InOutElastic;
             }", _target);

        animateComponent.target = _target;
        animateComponent.from = _target.x;
        animateComponent.duration = 500;
        animateComponent.to = _distination.x;
    }
    animateComponent.start();
    animateComponent.destroy(500);
}
*/
