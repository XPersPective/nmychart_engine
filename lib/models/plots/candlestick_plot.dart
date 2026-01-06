import 'package:flutter/material.dart';
import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

/// Candlestick plot - renders OHLC data for financial charts
class CandlestickPlot extends Plot {
  final String? fieldKeyOpen;
  final String? fieldKeyHigh;
  final String? fieldKeyLow;
  final String? fieldKeyClose;
  final String? upColor;
  final String? downColor;

  CandlestickPlot({
    this.fieldKeyOpen,
    this.fieldKeyHigh,
    this.fieldKeyLow,
    this.fieldKeyClose,
    this.upColor,
    this.downColor,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.candlestick;

  @override
  void render(Canvas canvas, Size size) {
    if (conditions != null && conditions!.isNotEmpty) {
      _applyConditions(canvas);
    }
  }

  void _applyConditions(Canvas canvas) {
    // TODO: Implement condition logic for candlestick plot
  }

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKeyOpen != null) 'fieldKeyOpen': fieldKeyOpen,
    if (fieldKeyHigh != null) 'fieldKeyHigh': fieldKeyHigh,
    if (fieldKeyLow != null) 'fieldKeyLow': fieldKeyLow,
    if (fieldKeyClose != null) 'fieldKeyClose': fieldKeyClose,
    if (upColor != null) 'upColor': upColor,
    if (downColor != null) 'downColor': downColor,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
