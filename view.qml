import QtQuick 2.0
import QtQuick.Window 2.2

Window {
    id: window

    title: "Gauge Cluster"

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

        property bool selectGauge: false
        property string selectedGauge: 'center'
        property bool selectGaugeFunction: false

        id: debugHarness
        focus: true

        // This control logic is rough. It will be cleaned up.
        Keys.onPressed: {
            if (event.key === Qt.Key_Up) {
                if (selectGauge) {
                    selectGaugeFunction = true;
                } else {
                    speed += 10;
                }
            }
            else if (event.key === Qt.Key_Down) {
                if (selectGauge) {

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
            else if (selectGauge && event.key === Qt.Key_G) {
                var options = ['left', 'center', 'right'];

                if (options.indexOf(selectedGauge) === options.length - 1) {
                    selectedGauge = options[0];
                } else {
                    selectedGauge = options[options.indexOf(selectedGauge) + 1];
                }

                selectGaugeFunction = false
            }
            else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                if (selectGauge) {
                    selectGaugeFunction = false;
                }

                selectGauge = !selectGauge;
            }
        }
    }

    Item {
        id: cluster

        property int gaugePadding: 50

        anchors.fill: parent

        /*
          Center Gauge
        */
        CenterGauge {
            id: centerGauge

            selected: debugHarness.selectGauge && debugHarness.selectedGauge === 'center'
            selectFunction: debugHarness.selectGaugeFunction

            speed: debugHarness.speed
            units: debugHarness.units

            width: 450
            height: 450

            anchors.centerIn: parent
        }

        /*
          Left Gauge
        */
        LeftGauge {
            selected: debugHarness.selectGauge && debugHarness.selectedGauge === 'left'
            selectFunction: debugHarness.selectGaugeFunction

            speed: debugHarness.speed
            cruiseSpeed: debugHarness.cruiseSpeed

            units: debugHarness.units

            odometer: debugHarness.odometer

            width: 400
            height: 400

            anchors.right: centerGauge.left
            anchors.rightMargin: cluster.gaugePadding
            anchors.bottom: centerGauge.bottom
        }

        /*
          Right Gauge
        */
        RightGauge {
            selected: debugHarness.selectGauge && debugHarness.selectedGauge === 'right'
            selectFunction: debugHarness.selectGaugeFunction

            width: 400
            height: 400

            anchors.left: centerGauge.right
            anchors.leftMargin: cluster.gaugePadding
            anchors.bottom: centerGauge.bottom
        }


        /*
          Charge Gauge
        */
        ChargeGauge {
            range: 280 * debugHarness.charge
            units: debugHarness.units
            charge: debugHarness.charge

            anchors.fill: centerGauge
        }
    }
}
