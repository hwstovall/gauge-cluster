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

        property bool selectGuage: false
        property string selectedGuage: 'center'
        property bool selectGuageFunction: false

        id: debugHarness
        focus: true

        // This control logic is rough. It will be cleaned up.
        Keys.onPressed: {
            if (event.key === Qt.Key_Up) {
                if (selectGuage) {
                    selectGuageFunction = true;
                } else {
                    speed += 10;
                }
            }
            else if (event.key === Qt.Key_Down) {
                if (selectGuage) {

                }
                else if (speed > 0) {
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
            else if (selectGuage && event.key === Qt.Key_G) {
                var options = ['left', 'center', 'right'];

                if (options.indexOf(selectedGuage) === options.length - 1) {
                    selectedGuage = options[0];
                } else {
                    selectedGuage = options[options.indexOf(selectedGuage) + 1];
                }

                selectGuageFunction = false
            }
            else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                if (selectGuage) {
                    selectGuageFunction = false;
                }

                selectGuage = !selectGuage;
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

            selected: debugHarness.selectGuage && debugHarness.selectedGuage === 'center'
            selectFunction: debugHarness.selectGuageFunction

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
            selected: debugHarness.selectGuage && debugHarness.selectedGuage === 'left'
            selectFunction: debugHarness.selectGuageFunction

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
            selected: debugHarness.selectGuage && debugHarness.selectedGuage === 'right'
            selectFunction: debugHarness.selectGuageFunction

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
