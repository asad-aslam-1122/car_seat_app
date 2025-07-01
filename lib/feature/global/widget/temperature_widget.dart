import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../resources/resources.dart';

class TemperatureWidget extends StatefulWidget {
  final double temperatureValue;

  const TemperatureWidget({super.key, required this.temperatureValue});

  @override
  State<TemperatureWidget> createState() => _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  @override
  Widget build(BuildContext context) {
    return SfLinearGauge(
        minimum: 0,
        maximum: 100,
        showLabels: false,
        showTicks: false,
        axisTrackStyle: LinearAxisTrackStyle(
            color: R.appColors.transparent,
            borderWidth: 0,
            edgeStyle: LinearEdgeStyle.bothCurve),
        tickPosition: LinearElementPosition.outside,
        labelPosition: LinearLabelPosition.outside,
        orientation: LinearGaugeOrientation.vertical,
        markerPointers: <LinearMarkerPointer>[
          LinearShapePointer(
            value: 2,
            markerAlignment: LinearMarkerAlignment.start,
            shapeType: LinearShapePointerType.circle,
            color: getColor(),
            position: LinearElementPosition.cross,
            width: 25,
            height: 25,
          ),
        ],
        barPointers: <LinearBarPointer>[
          LinearBarPointer(
            value: widget.temperatureValue,
            enableAnimation: true,
            thickness: 6,
            edgeStyle: LinearEdgeStyle.endCurve,
            color: getColor(),
          )
        ]);
  }

  Color getColor() {
    if (widget.temperatureValue >= 0 && widget.temperatureValue <= 30) {
      return R.appColors.lightBlue;
    } else if (widget.temperatureValue > 30 && widget.temperatureValue <= 80) {
      return R.appColors.greenColor;
    } else {
      return R.appColors.red;
    }
  }
}
