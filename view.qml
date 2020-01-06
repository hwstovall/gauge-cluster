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
        property string units: 'kmh'

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
                units = units === 'mph' ? 'kmh' : 'mph';
            }
        }
    }

    /*
      Left Guage
    */
    Item {
        anchors.centerIn: parent

        Speedometer {
            speed: debugHarness.speed
            units: debugHarness.units

            anchors.centerIn: parent
        }
    }
}
