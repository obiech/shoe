import 'package:flutter/material.dart';
import 'package:multi_charts/multi_charts.dart';
import 'package:to_do_list_pro_project/screens/main_screen/widgets/painter.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';


class WheelRadarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
                    painter: ShapePainter(8, 100, 0),
                    child:  RadarChart(
          values: [5.2, 8, 4.7, 4.2, 6.4, 7.3, 5.6, 6],
          labels: [
            "5.2\nBrightness of life",
            "8\nMaterial",
            "4.7\nHealth",
            "4.2\nCareer",
            "6.4\nFamily, friends",
            "7.3\nRelationship",
            "5.6\nFinance",
            "6\nSelf-development",
          ],
          maxWidth: 300.0,
          maxHeight: 300.0,
          labelColor: ColorPalette.black1,
          fillColor: Colors.deepPurple[800]!,
          maxValue: 10,
          strokeColor: Colors.white,
          animate:  false,
          
          
          chartRadiusFactor: 0.7,
          // strokeColor: Colors.black
        ));
  }
}
