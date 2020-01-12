import QtQuick 2.0

Item {
    property int guageSweepAngle: 280
    property int guageAngleStart: -50
    property int guageAngleEnd: guageAngleStart + guageSweepAngle

    /*
      Guage Outline
    */
    GuageOutline {
        angleStart: guageAngleStart - 1
        sweepAngle: guageSweepAngle + 2

        anchors.fill: parent
    }
}
