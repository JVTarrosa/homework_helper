import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart_series.dart';
import 'horizontal_chart.dart';


class TotalChart extends StatelessWidget {
  List<List>? barValues;

  TotalChart({this.barValues});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: HorizontalChart(
          workTotalData: [
            ChartSeries(
              bottomLabel: 'Total Work',
              barLength: barValues == null ? 10: barValues![4][1],
              barColor: charts.ColorUtil.fromDartColor(
                  Theme.of(context).accentColor
              ),
            ),

            ChartSeries(
              bottomLabel: 'Total Completed',
              barLength: barValues == null ? 10: barValues![4][2],
              barColor: charts.ColorUtil.fromDartColor(
                  Theme.of(context).focusColor
              ),
            ),

          ],
        )
    );
  }
}

