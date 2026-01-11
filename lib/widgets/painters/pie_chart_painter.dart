import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chart_painter.dart';

/// Painter for Pie Chart plots
/// Renders pie/donut charts with category segments
class PieChartPainter extends ChartPainter {
  final List<double> values;
  final List<String> labels;

  PieChartPainter({
    required PiePlot plot,
    required Size canvasSize,
    required this.values,
    required this.labels,
  }) : super(plot: plot, canvasSize: canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final total = values.reduce((a, b) => a + b);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width < size.height ? size.width / 2 : size.height / 2;

    double startAngle = -3.14159 / 2; // Start from top

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * 2 * 3.14159;

      // Draw slice
      final slicePaint = Paint()
        ..color = _getColor(i)
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        slicePaint,
      );

      // Draw border
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paintStroke,
      );

      startAngle += sweepAngle;
    }
  }

  Color _getColor(int index) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}
