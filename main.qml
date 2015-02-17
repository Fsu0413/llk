import QtQuick 2.4
import QtQuick.Controls 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: {
                    initConvertions();
                    generateMap();
                    displayMap();
                }
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    Label {
        id: lblLlkTable
        objectName: "lblLlkTable"
        text: "`1234567890-=\n~!@#$%^&*()_+\nqwertyuiop[]\\\nQWERTYUIOP{}|\nasdfghjkl;\'\nASDFGHJKL:\"\nzxcvbnm,.\/\nZXCVBNM<>?\n)"
        anchors.centerIn: parent
        font.family: "GL-MahjongTile"
        font.pointSize: 50

        MouseArea {
            id:lblLlkTableMa
            objectName: "lblLlkTableMa"
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton

            property int savedx;
            property int savedy;

            FontMetrics {
                id: fontMetrics
                font: lblLlkTable.font
            }

            onClicked: {
                var x = Math.floor(mouse.x / fontMetrics.advanceWidth("p"));
                var y = Math.floor(mouse.y / fontMetrics.height);

                console.log("", x, y);

                if (savedx == -1) {
                    savedx = x;
                    savedy = y;
                } else {
                    var x1 = savedx;
                    var y1 = savedy;
                    savedx = -1;
                    savedy = -1;

                    if (!((x1 === x) && (y1 === y)) && canLink(x1, y1, x, y)) {
                        map[y1][x1] = -1;
                        map[y][x] = -1;
                        displayMap();
                    }
                }
            }
        }
    }

    property var map;
    property var stringConvertions;

    function initConvertions() {
        stringConvertions = new Array;
        stringConvertions[-1] = 'p';
        stringConvertions[0] = '1';
        stringConvertions[1] = '2';
        stringConvertions[2] = '3';
        stringConvertions[3] = '4';
        stringConvertions[4] = '5';
        stringConvertions[5] = '6';
        stringConvertions[6] = '7';
        stringConvertions[7] = 'q';
        stringConvertions[8] = 'w';
        stringConvertions[9] = 'e';
        stringConvertions[10] = 'r';
        stringConvertions[11] = 't';
        stringConvertions[12] = 'y';
        stringConvertions[13] = 'u';
        stringConvertions[14] = 'i';
        stringConvertions[15] = 'o';
        stringConvertions[16] = 'a';
        stringConvertions[17] = 's';
        stringConvertions[18] = 'd';
        stringConvertions[19] = 'f';
        stringConvertions[20] = 'g';
        stringConvertions[21] = 'h';
        stringConvertions[22] = 'j';
        stringConvertions[23] = 'k';
        stringConvertions[24] = 'l';
        stringConvertions[25] = 'z';
        stringConvertions[26] = 'x';
        stringConvertions[27] = 'c';
        stringConvertions[28] = 'v';
        stringConvertions[29] = 'b';
        stringConvertions[30] = 'n';
        stringConvertions[31] = 'm';
        stringConvertions[32] = ',';
        stringConvertions[33] = '.';
    }


    function generateMap() {
        var cardRemain = new Array;
        for (var i = 0; i < 34; ++i) {
            cardRemain[i] = 4;
        }

        map = new Array;
        for (i = 0; i < 8; ++i) {
            map[i] = new Array;
            for (var j = 0; j < 17; ++j) {
                var id = Math.floor(Math.random() * 34);
                var testN = 0;
                while (cardRemain[id] <= 0) {
                    ++testN;
                    if (testN <= 100) {
                        id = Math.floor(Math.random() * 34);
                    } else {
                        for (var k = 0; k < 34; ++k) {
                            if (cardRemain[k] > 0)
                                id = k;
                        }
                    }
                }
                map[i][j] = id;
            }
        }

        lblLlkTableMa.savedx = -1;
        lblLlkTableMa.savedy = -1;
    }

    function displayMap() {
        var display = new Array;
        for (var i = 0; i < 8; ++i) {
            var currentline = "";
            for (var j = 0; j < 17; ++j) {
                var currentchar = stringConvertions[map[i][j]];
                currentline = currentline + currentchar;
            }
            display[i] = currentline;
        }

        var displayStr = display[0]
        for (i = 1; i < 8; ++i) {
            displayStr = displayStr + '\n' + display[i];
        }

        lblLlkTable.text = displayStr;
    }

    function canLink(x1, y1, x2, y2) {
        if (map[y1][x1] !== map[y2][x2])
            return false;

        var x1min, x1max, y1min, y1max, x2min, x2max, y2min, y2max;
        for (var x = x1 - 1; x >= -1; --x) {
            if (x == -1)
                break;

            if (map[y1][x] !== -1) {
                ++x;
                break;
            }
        }

        x1min = x;

        for (x = x1 + 1; x <= 17; ++x) {
            if (x == 17)
                break;

            if (map[y1][x] !== -1) {
                --x;
                break;
            }
        }

        x1max = x;

        for (x = x2 - 1; x >= -1; --x) {
            if (x == -1)
                break;

            if (map[y2][x] !== -1) {
                ++x;
                break;
            }
        }

        x2min = x;

        for (x = x2 + 1; x <= 17; ++x) {
            if (x == 17)
                break;

            if (map[y2][x] !== -1) {
                --x;
                break;
            }
        }

        x2max = x;

        var xmin = Math.max(x1min, x2min);
        var xmax = Math.min(x1max, x2max);

        var flag = false;
        for (x = xmin; x <= xmax; ++x) {
            if (x == -1 || x == 17) {
                flag = true;
                break;
            }

            var flag2 = true;
            for (var y = Math.min(y1, y2); y <= Math.max(y1, y2); ++y) {
                if (map[y][x] !== -1) {
                    if (!((x === x1 && y === y1) || (x === x2 && y === y2))) {
                        flag2 = false;
                        break;
                    }
                }
            }

            if (flag2) {
                flag = true;
                break;
            }
        }

        if (flag)
            return true;

        for (y = y1 - 1; y >= -1; --y) {
            if (y == -1)
                break;

            if (map[y][x1] !== -1) {
                ++y;
                break;
            }
        }

        y1min = y;

        for (y = y1 + 1; y <= 8; ++y) {
            if (y == 8)
                break;
            if (map[y][x1] !== -1) {
                --y;
                break;
            }
        }

        y1max = y;

        for (y = y2 - 1; y >= -1; --y) {
            if (y == -1)
                break;

            if (map[y][x2] !== -1) {
                ++y;
                break;
            }
        }

        y2min = y;

        for (y = y2 + 1; y <= 8; ++y) {
            if (y == 8)
                break;
            if (map[y][x2] !== -1) {
                --y;
                break;
            }
        }

        y2max = y;

        var ymin = Math.max(y1min, y2min);
        var ymax = Math.min(y1max, y2max);

        flag = false;

        for (y = ymin; y <= ymax; ++y) {
            if (y == -1 || y == 8) {
                flag = true;
                break;
            }

            flag2 = true;
            for (x = Math.min(x1, x2); x <= Math.max(x1, x2); ++x) {
                if (map[y][x] !== -1) {
                    if (!((x === x1 && y === y1) || (x === x2 && y === y2))) {
                        flag2 = false;
                        break;
                    }
                }
            }

            if (flag2) {
                flag = true;
                break;
            }
        }

        if (flag)
            return true;

        return false;
    }




}
