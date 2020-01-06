import QtQuick 2.11
import QtQuick.Shapes 1.14


Item {
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
        model: 7

        delegate: Item {
            width: component.width / 2 - 2
            rotation: (280 / 6) * index - 50
            transformOrigin: Item.Right

            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Rectangle {
                id: bigTick

                visible: index > 0 && index < 6

                width: 20
                height: 4
                radius: 2

                color: "white"

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                rotation: -parent.rotation

                text: index * 50
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
        model: 31

        delegate: Item {
            visible: index % 5

            width: component.width / 2 - 4
            rotation: (280 / 30) * index - 50
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
      Needle
    */
//    Rectangle {
//        id: needle

//        width: component.width / 2
//        height: 2
//        rotation: 45
//        transformOrigin: Item.Right

//        color: "white"

//        anchors.right: component.horizontalCenter
//        anchors.bottom: component.verticalCenter
//        anchors.bottomMargin: -height / 2
//    }
}
