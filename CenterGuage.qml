import QtQuick 2.11
import QtGraphicalEffects 1.12
import QtQuick.Shapes 1.14

import "."

Item {
    property int speed
    property string units

    property int guageSweepAngle: 280
    property int guageAngleStart: -50
    property int guageAngleEnd: guageAngleStart + guageSweepAngle

    /*
      Guage Outline
    */
    GuageOutline {
        angleStart: guageAngleStart - 1
        sweepAngle: guageSweepAngle + 2

        showStops: true

        anchors.fill: parent
    }

    Item {
        anchors.fill: parent

        Repeater {
            model: 10

            delegate: Item{
                width: 2 * (parent.width / 5) + (10 * index)
                height: 2 * (parent.height / 5) + (10 * index)

                anchors.centerIn: parent

                Rectangle {
                    radius: width / 2

                    anchors.fill: parent

                    color: 'transparent'
                    border.color: Style.gray
                    border.width: 2
                    opacity: index / 10

                    layer.enabled: true
                    layer.samples: 4
                }

                Item {
                    height: parent.height

                    anchors.centerIn: parent

                    Rectangle {
                        width: 2
                        height: 2

                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter

                        color: 'white'
                    }
                }
            }
        }
    }

    Rectangle {
        width: 2 * (parent.width / 5)
        height: 2 * (parent.height / 5)

        radius: width / 2

        anchors.centerIn: parent

        color: Style.guageBackground
        border.color: 'white'
        border.width: 2

        layer.enabled: true
        layer.effect: DropShadow {
            transparentBorder: true
            horizontalOffset: 0
            verticalOffset: 0
            radius: 30
            samples: 10
            color: "black"
        }

        Text {
            id: speedText

            text: speed

            color: 'white'
            font.bold: true
            font.pixelSize: 70

            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: -30
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: units == 'km' ? 'km/h' : 'mph'

            color: 'white'

            font.bold: true
            font.pixelSize: 18

            anchors.top: speedText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
