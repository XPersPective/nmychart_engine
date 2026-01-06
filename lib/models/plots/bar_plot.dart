import 'package:flutter/material.dart';
import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

/// Bar plot - renders vertical or horizontal bars
class BarPlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;

  BarPlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.bar;

  @override
  void render(Canvas canvas, Size size) {
    if (conditions != null && conditions!.isNotEmpty) {
      _applyConditions(canvas);
    }
  }

  void _applyConditions(Canvas canvas) {
    // TODO: Implement condition logic for bar plot
  }

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKeyX != null) 'fieldKeyX': fieldKeyX,
    if (fieldKeyY != null) 'fieldKeyY': fieldKeyY,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
