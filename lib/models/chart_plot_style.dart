import 'chart_condition.dart';

/// Çizim stili
class ChartPlotStyle {
  final ChartCondition? condition;

  ChartPlotStyle({this.condition});

  factory ChartPlotStyle.fromJson(Map<String, dynamic> json) {
    return ChartPlotStyle(
      condition: json['condition'] != null
          ? ChartCondition.fromJson(json['condition'])
          : null,
    );
  }
}
