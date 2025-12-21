import 'package:flutter/material.dart';
import 'chart_plot_style.dart';

/// Grafik çizim tanımı
class ChartPlot {
  final String type;
  final dynamic fieldIndex;
  final Color color;
  final ChartPlotStyle? style;

  ChartPlot({
    required this.type,
    required this.fieldIndex,
    required this.color,
    this.style,
  });

  factory ChartPlot.fromJson(Map<String, dynamic> json) {
    return ChartPlot(
      type: json['type'] ?? 'line',
      fieldIndex: json['fieldIndex'],
      color: _parseColor(json['color'] ?? '#000000'),
      style: json['style'] != null
          ? ChartPlotStyle.fromJson(json['style'])
          : null,
    );
  }

  static Color _parseColor(String color) {
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.black;
    }
  }
}
