import 'package:flutter/material.dart';
import 'package:project_testing/productivity_utils/chart_series_object.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HorizontalChart extends StatelessWidget {
  final List<ChartSeries> workTotalData;

  const HorizontalChart({
    Key? key,
    required this.workTotalData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
          id: 'Total Data',
          data: workTotalData,
          domainFn: (ChartSeries series, _) => series.bottomLabel,
          measureFn: (ChartSeries series, _) => series.barLength,
          colorFn: (ChartSeries series, _) => series.barColor
      ),

    ];

    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      child: Card(
        color: Theme.of(context).primaryColor,
        shadowColor: Colors.black54,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Total Data',
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Expanded(
                // ACTUAL BARCHART
                child: charts.BarChart(
                  series,
                  animate: true,
                  vertical: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
