import QtQuick 2.11
import QtQuick.Shapes 1.14

import '.'

Item {
    id: component

    property int angleStart: 270 - (45 / 2)
    property int sweepAngle: 45

    property int range
    property string units

    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 2
            strokeColor: "white"
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2; radiusY: component.height / 2
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
            id: highStop

            width: 15
            height: 2

            color: "white"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: '1'

            color: Style.lighterGray

            font.bold: true
            font.pointSize: 18

            rotation: -1 * parent.rotation
            transformOrigin: Item.Center

            anchors.verticalCenter: highStop.verticalCenter
            anchors.horizontalCenter: highStop.horizontalCenter
            anchors.horizontalCenterOffset: -5
            anchors.verticalCenterOffset: 15
        }
    }

    Item {
        width: parent.width

        rotation: component.angleStart + component.sweepAngle
        transformOrigin: Item.Center

        anchors.centerIn: parent


        Rectangle {
            id: lowStop

            width: 15
            height: 2

            color: "white"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }


        Text {
            text: '0'

            color: Style.lighterGray

            font.bold: true
            font.pointSize: 18

            rotation: -1 * parent.rotation
            transformOrigin: Item.Center

            anchors.verticalCenter: lowStop.verticalCenter
            anchors.horizontalCenter: lowStop.horizontalCenter
            anchors.horizontalCenterOffset: -5
            anchors.verticalCenterOffset: -15
        }
    }

    Text {
        text: range + ' ' + units

        color: 'white'

        font.bold: true
        font.pointSize: 18

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
