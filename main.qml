import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 1.4
import "functions.js" as MainFunc
import "graphics.js" as Graphics

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    color: MainFunc.getMainParams().mainColor

    Connections
    {
        target:passerelle
        onTimelineDatasReceived:
        {
            MainFunc.setTableViewDatas(timelineDatas)
        }
    }

    TextMetrics {
        id: helloText
        font.family: MainFunc.getMainParams().title.font
        font.pixelSize: MainFunc.getMainParams().title.size
        text: MainFunc.getMainParams().title.text
    }

    Rectangle {
        id: mainRectTitle
        width: mainWindow.width - (MainFunc.getMainParams().mainPadding * 2)
        height: 50
        x: MainFunc.getMainParams().mainPadding
        y: MainFunc.getMainParams().mainPadding
        color: "#111"
        Text {
            text: helloText.text
            font: helloText.font
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    Rectangle {
        id: tableRectangle
        x: MainFunc.getMainParams().mainPadding
        y: mainRectTitle.height + (MainFunc.getMainParams().mainPadding * 2)
        width: mainRectTitle.width
        height: mainWindow.height - mainRectTitle.height - (MainFunc.getMainParams().mainPadding * 3)
        color: "transparent"

        ListModel {
            id: timelineModel
        }
        Component {
            id: timelineDelegate
            Rectangle {
                id: timelineDelegateRect
                width: tableRectangle.width
                height: 70
                color: "transparent"
                Behavior on height { PropertyAnimation { duration: 200 } }
                Rectangle {
                    id: timelineDelegateRect_title
                    width: parent.width
                    height: 70
                    color: "transparent"
                    Image {
                        id: imgEta
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 10
                        anchors.left: parent.left
                        source: imageEtablissement
                        height: parent.height - 20
                        width: parent.height - 20
                    }
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: imgEta.right
                        anchors.right: parent.right
                        anchors.leftMargin: 10;
                        anchors.rightMargin: 10;
                        wrapMode: Text.Wrap
                        text: etablissement;
                        font.pixelSize: 17
                        color: "#eee"
                    }
                }
                Rectangle {
                    id: timelineDelegateRect_desc
                    visible: timelineDelegateRect.activeFocus
                    width: parent.width
                    height: parent.height - timelineDelegateRect_title.height
                    anchors.top: timelineDelegateRect_title.bottom
                    color: "transparent"
                    Text {
                        anchors.fill: parent
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        wrapMode: Text.Wrap
                        text: description;
                        font.pixelSize: 15
                        color: "#fff"
                    }

                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Graphics.flushGraphics();
                        timelineList.currentIndex = index
                    }
                }
            }
        }

        ListView {
            id: timelineList
            anchors.fill: parent
            clip: true
            model: timelineModel
            delegate: timelineDelegate
            focus: true
            onCurrentItemChanged: Graphics.updateTimelineCell()
            Component.onCompleted: MainFunc.getTableViewDatas()
        }
    }
}
