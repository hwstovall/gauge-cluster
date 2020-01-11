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

        property string units: 'km/h'

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
            else if (event.key === Qt.Key_U) {
                units = units === 'mph' ? 'km/h' : 'mph';
            }
            else if (event.key === Qt.Key_C) {
                cruiseSpeed = cruiseSpeed == 0 && speed >= 25 ? speed : 0;
            }
        }
    }

    /*
      Left Guage
    */
    Item {
        anchors.centerIn: parent

        LeftGuage {
            speed: debugHarness.speed
            cruiseSpeed: debugHarness.cruiseSpeed

            units: debugHarness.units

            anchors.centerIn: parent
        }
    }
}
