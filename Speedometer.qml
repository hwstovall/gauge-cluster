import QtQuick 2.11
import QtQuick.Shapes 1.14


Item {
    property real speed
    property string units

    property int numBigTicks: units === 'kmh' ? 7 : 10
    property int bigTickInterval: units === 'kmh' ? 50 : 25
    property int numSmallTicks: numBigTicks * 5 - 4

    property int maxDisplayableSpeed: (numBigTicks - 1) * bigTickInterval

    id: component

    width: 400
    height: 400

    /*
      Background
    */
    Rectangle {
      id: background

      width: component.width
      height: component.width
      radius: width / 2

      color: "black"

      anchors.centerIn: component
    }

    /*
      Guage Outline
    */
    Shape {
        width: component.width
        height: component.height
        anchors.centerIn: component

        ShapePath {
            strokeWidth: 8
            strokeColor: "gray"
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2 - 8; radiusY: component.height / 2 - 8
                startAngle: 130
                sweepAngle: 280
            }
        }

        ShapePath {
            strokeWidth: 2
            strokeColor: "white"
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2; radiusY: component.height / 2
                startAngle: 130
                sweepAngle: 280
            }
        }
    }

    /*
      Big Ticks
    */
    Repeater {
        model: numBigTicks

        delegate: Item {
            width: component.width / 2 - 2
            rotation: (280 / (numBigTicks - 1)) * index - 50
            transformOrigin: Item.Right

            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Rectangle {
                id: bigTick

                visible: index > 0 && index < (numBigTicks - 1)

                width: 20
                height: 4
                radius: 2

                color: "white"

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                rotation: -parent.rotation

                text: index * bigTickInterval
                font.pixelSize: 20
                font.bold: true
                color: "white"

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: bigTick.right
                anchors.leftMargin: 5
            }
        }
    }

    /*
      Small Ticks
    */
    Repeater {
        model: numSmallTicks

        delegate: Item {
            visible: index % 5

            width: component.width / 2 - 4
            rotation: (280 / (numSmallTicks - 1)) * index - 50
            transformOrigin: Item.Right

            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Rectangle {
                width: 5
                height: 2
                radius: 0.75

                color: "white"
                opacity: 0.75

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    /*
      Units
    */
    Text {
        text: units

        color: 'white'
        font.bold: true
        font.capitalization: Font.AllUppercase

        anchors.horizontalCenter: component.horizontalCenter
        anchors.bottom: component.bottom
        anchors.bottomMargin: 30
    }

    /*
      Needle
    */
    Item {
        width: component.width
        rotation: speed > maxDisplayableSpeed ? 230 : (280 / maxDisplayableSpeed) * speed - 50

        anchors.centerIn: component

        Behavior on rotation { PropertyAnimation {} }

        Rectangle {
            id: needle

            width: 30
            height: 4

            color: "red"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
