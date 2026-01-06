import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chart_painter.dart';

/// Painter for Area Plot charts
/// Renders filled areas under lines
class AreaChartPainter extends ChartPainter {
  final List<double> dataPoints;

  AreaChartPainter({
    required AreaPlot plot,
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

    // Draw filled area
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

    // Close path to create area
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintStroke);
  }
}
