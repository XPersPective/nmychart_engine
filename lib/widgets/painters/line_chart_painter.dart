import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chart_painter.dart';

/// Painter for Line Plot charts
/// Renders continuous lines connecting data points
class LineChartPainter extends ChartPainter {
  final List<double> dataPoints;

  LineChartPainter({
    required LinePlot plot,
    required Size canvasSize,
    required this.dataPoints,
  }) : super(plot: plot, canvasSize: canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Call plot's render method to handle conditions and plot-specific logic
    plot.render(canvas, size);

    // Draw grid and axes
    drawGrid(canvas);
    drawAxes(canvas);

    if (dataPoints.isEmpty) return;

    // Normalize data points
    final maxValue = dataPoints.reduce((a, b) => a > b ? a : b);
    final minValue = dataPoints.reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;

    // Draw line path
    final path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      final x = (size.width / (dataPoints.length - 1)) * i;
      final normalizedY = (dataPoints[i] - minValue) / range;
      final y = size.height - (normalizedY * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paintStroke);
  }
}
