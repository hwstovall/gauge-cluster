import QtQuick 2.11
import QtQuick.Shapes 1.14

import '.'

Item {
    id: component

    property int angleStart: 90 - (45 / 2)
    property int sweepAngle: 45

    property real charge
    property int range
    property string units

    /*
      Guage Fill
    */
    Shape {
        id: fill

        property int padding: 1
        property real lowChargeCutoff: 0.2
        property real lowChargeGap: 0.5

        property real sweepAngle: component.sweepAngle - (2 * padding) - lowChargeGap
        property real startAngleLow: component.angleStart + component.sweepAngle - padding
        property real startAngleHigh: startAngleLow - (sweepAngle * lowChargeCutoff) - lowChargeGap

        property real sweepAngleLow: {
            if (charge > fill.lowChargeCutoff)
                -1 * fill.sweepAngle * fill.lowChargeCutoff;
            else
                -1 * fill.sweepAngle * charge;
        }
        property real sweepAngleHigh: {
            if (charge > fill.lowChargeCutoff)
                -1 * ((fill.sweepAngle * (1 - fill.lowChargeCutoff)) - fill.lowChargeGap) * ((charge - fill.lowChargeCutoff) / (1 - fill.lowChargeCutoff));
            else
                0;
        }

        layer.enabled: true
        layer.samples: 4

        anchors.fill: parent

        ShapePath {
            strokeWidth: 4
            strokeColor: charge > fill.lowChargeCutoff ? 'white' : Style.lowFuelColor
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: (component.width / 2) - 5; radiusY: (component.height / 2) - 5
                startAngle: fill.startAngleLow
                sweepAngle: fill.sweepAngleLow

                PropertyAnimation on sweepAngle {}
            }
        }


        ShapePath {
            strokeWidth: 4
            strokeColor: 'white'
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: (component.width / 2) - 5; radiusY: (component.height / 2) - 5
                startAngle: fill.startAngleHigh
                sweepAngle: fill.sweepAngleHigh

                PropertyAnimation on sweepAngle {}
            }
        }
    }

    /*
      Guage Outline
    */
    Shape {
        anchors.fill: parent

        ShapePath {
            strokeWidth: 2
            strokeColor: Style.lighterGray
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2; radiusY: component.height / 2
                startAngle: component.angleStart
                sweepAngle: component.sweepAngle
            }
        }
    }

    /*
      High Stop
    */
    Item {
        width: parent.width

        rotation: component.angleStart + 180
        transformOrigin: Item.Center

        anchors.centerIn: parent


        Rectangle {
            id: highStop

            width: 15
            height: 2

            color: Style.lighterGray

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

    /*
      Low Stop
    */
    Item {
        width: parent.width

        rotation: component.angleStart + component.sweepAngle + 180
        transformOrigin: Item.Center

        anchors.centerIn: parent


        Rectangle {
            id: lowStop

            width: 15
            height: 2

            color: Style.lighterGray

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

    /*
      Range
    */
    Text {
        text: range + ' ' + units

        color: charge > fill.lowChargeCutoff ? 'white' : Style.lowFuelColor

        font.bold: true
        font.pointSize: 18

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
