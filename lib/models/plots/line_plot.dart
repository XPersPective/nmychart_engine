import 'package:flutter/material.dart';
import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

/// Line plot - renders continuous lines connecting data points
class LinePlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;

  LinePlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.line;

  @override
  void render(Canvas canvas, Size size) {
    // This method will be called by the painter to render the plot
    // Actual rendering logic should be in the painter, but this validates
    // the plot configuration and handles conditions
    if (conditions != null && conditions!.isNotEmpty) {
      // Apply conditions before rendering (filtering, styling, etc)
      _applyConditions(canvas);
    }
  }

  /// Apply plot conditions (affects rendering style, colors, etc)
  void _applyConditions(Canvas canvas) {
    // TODO: Implement condition logic
    // e.g., change color based on condition, apply filters, etc
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
