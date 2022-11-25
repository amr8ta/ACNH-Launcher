import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    visible: true
    width: 400
    height: 350
    title: "Animal Crossing Launcher"
    
    // flags: Qt.FramelessWindowHint | Qt.Window

    property string currTime: "00:00:00"
    property QtObject backend
    property string pageTitle: nonie.hovered ? "Nonie": (sim.hovered ? "Sim" : "Select User")

    Rectangle {
        anchors.fill: parent
        color: "#fbf8ec"
        
        Rectangle {
            id: header
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            Text {
                anchors {
                    top: parent.top
                    topMargin: 34
                    horizontalCenter: parent.horizontalCenter
                }
                text: currTime
                font.pixelSize: 22
                font.family: "Arial Rounded MT Bold"
                color: "#e0d9cf"
            }

            Image {
                anchors {
                    top: parent.top
                    topMargin: 30
                    left: parent.left
                    leftMargin: 48
                }
                source: "./images/wifi.png"
                sourceSize.height: 36
            }

            Image {
                anchors {
                    top: parent.top
                    topMargin: 30
                    right: parent.right
                    rightMargin: 68
                }
                source: "./images/gps.png"
                sourceSize.height: 36
            }
        }

        Text {
            anchors {
                top: parent.top
                topMargin: 90
                horizontalCenter: parent.horizontalCenter
            }
            text: pageTitle
            font.pixelSize: 34
            font.family: "Arial Rounded MT Bold"
            color: "#766959"
        }


        Rectangle {
            anchors {
                right: parent.horizontalCenter
                rightMargin: 75
                top: parent.verticalCenter
                topMargin: 40
            }
            color: "transparent"
            Button {
                id: nonie
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                
                background: Rectangle {
                    implicitWidth: nonie.hovered ? 121 : 110
                    implicitHeight: nonie.hovered ? 121 : 110
                }

                Image {
                    id: nonieImage
                    anchors.fill: parent
                    source: "./images/nonie_icon.png"
                    sourceSize.height: nonie.hovered ? 121 : 110
                    sourceSize.width: nonie.hovered ? 121 : 110
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        // console.info("nonie clicked!")
                        backend.getUser("nonie")
                    }
                }
            }
        }
        
        Rectangle {
            anchors {
                left: parent.horizontalCenter
                leftMargin: 75
                top: parent.verticalCenter
                topMargin: 40
            }
            color: "transparent"
            Button {
                id: sim
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                
                background: Rectangle {
                    implicitWidth: sim.hovered ? 121 : 110
                    implicitHeight: sim.hovered ? 121 : 110
                }
                
                Image {
                        id: simImage
                        anchors.fill: parent
                        source: "./images/sim_icon.png"
                        sourceSize.height: sim.hovered ? 121 : 110
                        sourceSize.width: sim.hovered ? 121 : 110
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        // console.info("sim clicked!")
                        backend.getUser("sim")
                    }
                }
            
            }
        }
    }

    Connections {
        target: backend
        function onUpdated(msg) {
            currTime = msg;
        }
    }
}