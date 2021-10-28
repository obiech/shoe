import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:to_do_list_pro_project/resources/resources.dart';
import 'package:to_do_list_pro_project/theme/color_theme.dart';

class WheelLineChart extends StatefulWidget {
  const WheelLineChart({Key? key}) : super(key: key);

  @override
  _WheelLineChartState createState() => _WheelLineChartState();
}

class _WheelLineChartState extends State<WheelLineChart> {
  List<_ChartData> data = [
    _ChartData('Mar', 20),
    _ChartData('Apr', 67),
    _ChartData('May', 34),
    _ChartData('June', 72),
    _ChartData('July', 40)
  ];

  String category = '2021';

  List<String> categories = ['2021', '2022', '2023', '2024', '2025'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 149,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Happiness',
                      style: TextStyle(
                          color: Color(0xFF7D63EB),
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                  flex: 5,
                ),
                SizedBox(width:120 ,),
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    icon: SvgPicture.asset(MainIcons.dropdown),
                    iconEnabledColor: Color(0xFF7D63EB),
                    isExpanded: true,
                    focusColor: Color(0xFF7D63EB),
                    value: category,
                    underline: Container(
                    ),
                    onChanged: (value) {
                      setState(() {
                        category = value.toString();
                      });
                    },
                    items: categories.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width:14 ,)
              ]),
            ),
            Expanded(child: _happinessChart(), flex: 7),
          ],
        ),
      ),
    );
  }

  Widget _happinessChart() {
    return SfCartesianChart(
      
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0,),
        
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.compact(),
        axisLine: AxisLine(color: Colors.white),
        majorGridLines: MajorGridLines(dashArray: [1,2,3]),
        minorGridLines: MinorGridLines(dashArray: [1,2,3], ),
        // minorTickLines: MinorTickLines(color: Colors.white)
        // majorTickLines: MajorTickLines(width: 0,color: Colors.white)
      ),
      trackballBehavior: TrackballBehavior(
          activationMode: ActivationMode.singleTap,
          enable: true,
          lineColor: Colors.black),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          color: Colors.white,
          canShowMarker: true,
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            _ChartData xAxis = data;
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(
                width: 55,
                height: 32,
                child: Center(
                  child: RichText(
                      text: TextSpan(
                          text: '${xAxis.sales.toInt().toString()}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                          children: [
                        TextSpan(
                            text: '%',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 8))
                      ])),
                ),
              ),
            );
          }),
      series: <SplineSeries<_ChartData, String>>[
        SplineSeries<_ChartData, String>(
          dataSource: data,
          width: 4,
          // markerSettings: MarkerSettings(
          //   isVisible: true,
          //   color: Colors.white,
          // ),
          splineType: SplineType.clamped,
          color: Color(0xff7D63EB),
          xValueMapper: (_ChartData sales, _) => sales.year,
          yValueMapper: (_ChartData sales, _) => sales.sales,
          name: 'Happiness',
        )
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.year, this.sales);

  final String year;
  final double sales;
}
