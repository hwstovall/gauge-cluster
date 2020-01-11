import QtQuick 2.11
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.14


Item {
    property real speed
    property real cruiseSpeed

    property string units

    property int maxDisplayableSpeed: units === 'km/h' ? 300 : 225

    // Tick Config
    property int bigTickInterval: units === 'km/h' ? 50 : 25
    property int numBigTicks: maxDisplayableSpeed / bigTickInterval + 1
    property int numSmallTicks: numBigTicks * 5 - 4
    property real smallTickInterval: maxDisplayableSpeed / numSmallTicks

    // Angles
    property int guageSweepAngle: 280
    property int guageAngleStart: -50
    property int guageAngleEnd: guageAngleStart + guageSweepAngle

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
    Item {
        anchors.fill: parent

        Shape {
            anchors.fill: parent

            ShapePath {
                strokeWidth: 10
                strokeColor: "#35363a"
                capStyle: ShapePath.FlatCap
                fillColor: "transparent"

                startX: 0; startY: 0

                PathAngleArc {
                    centerX: component.width / 2; centerY: component.height / 2
                    radiusX: component.width / 2 - 10; radiusY: component.height / 2 - 10
                    startAngle: guageAngleStart + 180
                    sweepAngle: guageSweepAngle
                }
            }

            ShapePath {
                strokeWidth: 2
                strokeColor: "white"
                capStyle: ShapePath.FlatCap
                fillColor: "transparent"

                startX: 0; startY: 0

                PathAngleArc {
                    centerX: component.width / 2; centerY: component.height / 2
                    radiusX: component.width / 2; radiusY: component.height / 2
                    startAngle: guageAngleStart + 180 - 1
                    sweepAngle: guageSweepAngle + 2
                }
            }
        }

        Item {
            width: parent.width

            rotation: guageAngleStart - 1
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

            rotation: guageAngleEnd + 1
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

    /*
      Guage Fill
    */
    Shape {
        width: component.width
        height: component.height

        anchors.centerIn: component

        ShapePath {
            strokeWidth: 10
            strokeColor: "white"
            capStyle: ShapePath.FlatCap
            fillColor: "transparent"

            startX: 0; startY: 0

            PathAngleArc {
                Behavior on sweepAngle { PropertyAnimation {} }

                centerX: component.width / 2; centerY: component.height / 2
                radiusX: component.width / 2 - 10; radiusY: component.height / 2 - 10
                startAngle: guageAngleStart - 180
                sweepAngle: speed > maxDisplayableSpeed ? guageSweepAngle : (guageSweepAngle / maxDisplayableSpeed) * speed
            }
        }
    }

    /*
      Big Ticks
    */
    Repeater {
        model: numBigTicks

        delegate: Item {
            width: component.width

            rotation: (guageSweepAngle / (numBigTicks - 1)) * index - 50
            transformOrigin: Item.Center

            anchors.centerIn: parent

            Rectangle {
                id: bigTick

                visible: index > 0 && index < (numBigTicks - 1)

                width: 18
                height: 4
                radius: 2

                color: "white"

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 0
                    verticalOffset: 0
                    radius: 5
                    samples: 10
                    color: "#35363a"
                }
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

            width: component.width / 2 - 6
            rotation: (280 / (numSmallTicks - 1)) * index - 50
            transformOrigin: Item.Right

            anchors.right: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter


            Rectangle {
                width: 5
                height: 3
                radius: 0.75

                color: speed > (index * smallTickInterval) ? 'black': 'white'
                opacity: 0.75

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color { PropertyAnimation {} }
            }
        }
    }

    /*
      Units
    */
    Item {
        width: parent.width + 15

        rotation: -52.5
        transformOrigin: Item.Center

        anchors.centerIn: parent

        Rectangle {
            width:  unitTextMetrics.tightBoundingRect.width
            height: unitTextMetrics.tightBoundingRect.height

            rotation: 95
            transformOrigin: Item.Right

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left

            color: "transparent"

            Text {
                id: unitText

                text: units

                color: "gray"
                font.bold: true
                font.capitalization: Font.AllLowercase

            }

            TextMetrics {
                id: unitTextMetrics
                font: unitText.font
                text: unitText.text
            }
        }
    }

    /*
      Cruise Indicator
    */
    Item {
        visible: cruiseSpeed > 0

        width: parent.width + 22.5

        rotation: cruiseSpeed > maxDisplayableSpeed ? guageAngleEnd : (guageSweepAngle / maxDisplayableSpeed) * cruiseSpeed - 50
        transformOrigin: Item.Center

        anchors.centerIn: parent

        Shape {
            width: 10
            height: 10

            layer.enabled: true
            layer.samples: 4

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left

            ShapePath {
                fillColor: 'white'

                startX: 0; startY: 0

                PathLine { x: 0; y: 0 }
                PathLine { x: 7.5; y: 5 }
                PathLine { x: 0; y: 10 }
            }
        }
    }

    Text {
        text: 'Speed: ' + speed

        color: 'white'

        anchors.centerIn: parent
    }
}