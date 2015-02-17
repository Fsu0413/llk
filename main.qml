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
        objectName: "lblLlkTable"
        text: "`1234567890-=\n~!@#$%^&*()_+\nqwertyuiop[]\\\nQWERTYUIOP{}|\nasdfghjkl;\'\nASDFGHJKL:\"\nzxcvbnm,.\/\nZXCVBNM<>?\n)"
        anchors.centerIn: parent
        font.family: "GL-MahjongTile"
        font.pointSize: 50
    }

    property var map;
    property var stringConvertions;

    function initConvertions() {
        stringConvertions = new Array;
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

        var l = null;

        for (i = 0; i < data.length; ++i) {
            if (data[i].objectName === "lblLlkTable") {
                l = data[i];
                break;
            }
        }
        if (l != null)
            l.text = displayStr;
    }


}
