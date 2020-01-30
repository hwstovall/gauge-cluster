import QtQuick 2.0

Item {
    property bool selected
    property bool selectFunction

    property int guageSweepAngle: 280
    property int guageAngleStart: -50
    property int guageAngleEnd: guageAngleStart + guageSweepAngle

    id: component

    /*
      Guage Outline
    */
    GuageOutline {
        selected: component.selected
        selectFunction: component.selectFunction

        angleStart: guageAngleStart - 1
        sweepAngle: guageSweepAngle + 2

        anchors.fill: parent
    }
}
