import QtQuick 2.11
import QtQuick.Shapes 1.14

/*
  Guage Outline
*/
Item {
    id: component

    property int angleStart
    property int sweepAngle

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 2
            strokeColor: "white"
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: parent.width / 2; centerY: parent.height / 2
                radiusX: parent.width / 2; radiusY: parent.height / 2
                startAngle: component.angleStart - 180
                sweepAngle: component.sweepAngle
            }
        }
    }

    Item {
        width: parent.width

        rotation: component.angleStart
        transformOrigin: Item.Center

        anchors.centerIn: parent


        Rectangle {
            width: 15
            height: 2

            color: "white"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Item {
        width: parent.width

        rotation: component.angleStart + component.sweepAngle
        transformOrigin: Item.Center

        anchors.centerIn: parent


        Rectangle {
            width: 15
            height: 2

            color: "white"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
