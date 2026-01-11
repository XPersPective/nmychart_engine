import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chart_painter.dart';

/// Painter for Bar Plot charts
/// Renders vertical or horizontal bars
class BarChartPainter extends ChartPainter {
  final List<double> dataPoints;

  BarChartPainter({
    required BarPlot plot,
    required Size canvasSize,
    required this.dataPoints,
  }) : super(plot: plot, canvasSize: canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid and axes
    drawGrid(canvas);
    drawAxes(canvas);

    if (dataPoints.isEmpty) return;

    // Normalize data points
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);

    final barWidth = size.width / (dataPoints.length * 2);

    for (int i = 0; i < dataPoints.length; i++) {
      final x = barWidth * 2 * i + barWidth / 2;
      final normalizedHeight = (dataPoints[i] / maxValue) * size.height;
      final rect = Rect.fromLTWH(
        x,
        size.height - normalizedHeight,
        barWidth,
        normalizedHeight,
      );

      canvas.drawRect(rect, paintFill);
      canvas.drawRect(rect, paintStroke);
    }
  }
}
