import QtQuick 2.0

Item {
    property bool selected
    property bool selectFunction

    property int gaugeSweepAngle: 280
    property int gaugeAngleStart: -50
    property int gaugeAngleEnd: gaugeAngleStart + gaugeSweepAngle

    id: component

    /*
      Gauge Outline
    */
    GaugeOutline {
        selected: component.selected
        selectFunction: component.selectFunction

        angleStart: gaugeAngleStart - 1
        sweepAngle: gaugeSweepAngle + 2

        anchors.fill: parent
    }
}
