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

    property bool selected
    property bool selectFunction

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
            strokeWidth: (selected && !selectFunction) ? 5 : 2
            strokeColor: (selected && !selectFunction) ? "orange" : "white"
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
            height: (selected && !selectFunction) ? 5 : 2

            color:  (selected && !selectFunction) ? "orange" : "white"

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
            height: (selected && !selectFunction) ? 5 : 2

            color:  (selected && !selectFunction) ? "orange" : "white"

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Shape {
        id: selectTabs

        property int sweepAngle: 15
        property real endOffset: 0.5
        property int innerOffset: 2

        anchors.fill: parent

        visible: selected

        ShapePath {
            strokeWidth: 10
            strokeColor: "orange"
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                centerX: parent.width / 2; centerY: parent.height / 2
                radiusX: (parent.width / 2) + selectTabs.innerOffset; radiusY: (parent.height / 2) + selectTabs.innerOffset
                startAngle: {
                    if(selectFunction) {
                        -(selectTabs.sweepAngle / 2);
                    } else {
                        component.angleStart - 180 + component.sweepAngle - 15 + selectTabs.endOffset;
                    }
                }
                sweepAngle: selectTabs.sweepAngle

                Behavior on startAngle { PropertyAnimation {} }
            }

            PathAngleArc {
                centerX: parent.width / 2; centerY: parent.height / 2
                radiusX: (parent.width / 2) + selectTabs.innerOffset; radiusY: (parent.height / 2) + selectTabs.innerOffset
                startAngle: {
                    if (selectFunction) {
                        -180 - (selectTabs.sweepAngle / 2);
                    } else {
                        component.angleStart - 180 - selectTabs.endOffset;
                    }
                }
                sweepAngle: selectTabs.sweepAngle

                Behavior on startAngle { PropertyAnimation {} }
            }
        }
    }
}
