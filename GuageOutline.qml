import QtQuick 2.11
import QtQuick.Shapes 1.14

import '.'

/*
  Guage Outline
*/
Item {
    id: component

    property int angleStart
    property int sweepAngle

    property bool showStops: false

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 10
            strokeColor: Style.guageFill
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2 - 10; radiusY: component.height / 2 - 10
                startAngle: component.angleStart + 180
                sweepAngle: component.sweepAngle
            }
        }

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
        visible: showStops

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
        visible: showStops

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
