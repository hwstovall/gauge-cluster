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
      Left Guage
    */
    Item {
        anchors.centerIn: parent

        Speedometer {
            anchors.centerIn: parent
        }
    }
}
