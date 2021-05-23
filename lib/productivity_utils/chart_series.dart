import 'package:charts_flutter/flutter.dart' as charts;

class ChartSeries {
  final String bottomLabel;
  final int barLength;
  final charts.Color barColor;
  
  ChartSeries({
   required this.bottomLabel,
   required this.barLength,
   required this.barColor, 
});

}