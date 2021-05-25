import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'chart_series_object.dart';
import 'productivity_chart.dart';

class PageChart extends StatelessWidget {
  List<List>? barValues;

  PageChart({this.barValues});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ProductivityChart(
            workTotalData: [
              ChartSeries(
                bottomLabel: 'Week 1',
                barLength: barValues == null ? 10: barValues![0][1],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).accentColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 2',
                barLength: barValues == null ? 10: barValues![1][1],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).accentColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 3',
                barLength: barValues == null ? 10: barValues![2][1],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).accentColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 4',
                barLength: barValues == null ? 10: barValues![3][1],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).accentColor
                ),
              ),
            ],


            workDoneData: [
              ChartSeries(
                bottomLabel: 'Week 1',
                barLength: barValues == null ? 10: barValues![0][2],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).focusColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 2',
                barLength: barValues == null ? 10: barValues![1][2],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).focusColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 3',
                barLength: barValues == null ? 10: barValues![2][2],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).focusColor
                ),
              ),

              ChartSeries(
                bottomLabel: 'Week 4',
                barLength: barValues == null ? 10: barValues![3][2],
                barColor: charts.ColorUtil.fromDartColor(
                    Theme.of(context).focusColor
                ),
              ),
            ]
        )
    );
  }
}
