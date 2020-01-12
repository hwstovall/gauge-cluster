import QtQuick 2.0
import QtQuick.Window 2.2

Window {
    id: window

    title: "Guage Cluster"

    width: 1400
    height: 600
    visible: true

    color: "black"

    /*
      Debugging Interactions
    */
    Item {
        property real speed: 0
        property real cruiseSpeed: 0
        property real charge: 1.0

        property string units: 'km'

        property int odometer: 12345

        id: debugHarness
        focus: true

        Keys.onPressed: {
            if (event.key === Qt.Key_Up) {
                speed += 10;
            }
            else if (event.key === Qt.Key_Down) {
                if (speed > 0) {
                    speed -= 10;
                }
            }
            else if (event.key === Qt.Key_Right) {
                if (charge < 1) {
                    charge += 0.05;
                }
            }
            else if (event.key === Qt.Key_Left) {
                if (charge > 0) {
                    charge -= 0.05;
                }
            }
            else if (event.key === Qt.Key_U) {
                units = units === 'mi' ? 'km' : 'mi';
            }
            else if (event.key === Qt.Key_C) {
                cruiseSpeed = cruiseSpeed == 0 && speed >= 25 ? speed : 0;
            }
        }
    }

    Item {
        id: cluster

        property int guagePadding: 50

        anchors.fill: parent

        /*
          Center Guage
        */
        CenterGuage {
            id: centerGuage

            speed: debugHarness.speed
            units: debugHarness.units

            width: 450
            height: 450

            anchors.centerIn: parent
        }

        /*
          Left Guage
        */
        LeftGuage {
            speed: debugHarness.speed
            cruiseSpeed: debugHarness.cruiseSpeed

            units: debugHarness.units

            odometer: debugHarness.odometer

            width: 400
            height: 400

            anchors.right: centerGuage.left
            anchors.rightMargin: cluster.guagePadding
            anchors.bottom: centerGuage.bottom
        }

        /*
          Right Guage
        */
        RightGuage {
            width: 400
            height: 400

            anchors.left: centerGuage.right
            anchors.leftMargin: cluster.guagePadding
            anchors.bottom: centerGuage.bottom
        }


        /*
          Charge Guage
        */
        ChargeGuage {
            range: 280 * debugHarness.charge
            units: debugHarness.units
            charge: debugHarness.charge

            anchors.fill: centerGuage
        }
    }
}
