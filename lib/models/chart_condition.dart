import 'package:flutter/material.dart';
import 'chart_data.dart';

/// Koşullu stil
class ChartCondition {
  final dynamic value1;
  final String type;
  final dynamic value2;
  final ChartConditionResult result;

  ChartCondition({
    required this.value1,
    required this.type,
    required this.value2,
    required this.result,
  });

  factory ChartCondition.fromJson(Map<String, dynamic> json) {
    return ChartCondition(
      value1: json['value1'],
      type: json['type'] ?? 'greater_than',
      value2: json['value2'],
      result: ChartConditionResult.fromJson(json['result']),
    );
  }

  bool evaluate(double value, ChartData chartData, int dataIndex) {
    final v1 = _resolveValue(value1, value, chartData, dataIndex);
    final v2 = _resolveValue(value2, value, chartData, dataIndex);

    switch (type) {
      case 'greater_than':
        return v1 > v2;
      case 'less_than':
        return v1 < v2;
      case 'equal':
        return (v1 - v2).abs() < 0.0001;
      default:
        return false;
    }
  }

  double _resolveValue(
    dynamic value,
    double currentValue,
    ChartData chartData,
    int dataIndex,
  ) {
    if (value is Map && value['type'] == 'fieldIndex') {
      final index = value['index'] as int;
      if (dataIndex < chartData.data.length &&
          index < chartData.data[dataIndex].length) {
        return (chartData.data[dataIndex][index] as num).toDouble();
      }
    } else if (value is Map && value['type'] == 'value') {
      return (value['value'] as num).toDouble();
    } else if (value is num) {
      return value.toDouble();
    }
    return currentValue;
  }
}

/// Koşul sonucu
class ChartConditionResult {
  final Color trueColor;
  final Color falseColor;
  final Color defaultColor;

  ChartConditionResult({
    required this.trueColor,
    required this.falseColor,
    required this.defaultColor,
  });

  factory ChartConditionResult.fromJson(Map<String, dynamic> json) {
    // Import ChartPlot._parseColor yöntemi
    return ChartConditionResult(
      trueColor: _parseColor(json['true']['color'] ?? '#000000'),
      falseColor: _parseColor(json['false']['color'] ?? '#000000'),
      defaultColor: _parseColor(json['default']['color'] ?? '#000000'),
    );
  }

  static Color _parseColor(String color) {
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return Colors.black;
    }
  }

  Color evaluate(bool condition) => condition ? trueColor : falseColor;
}
