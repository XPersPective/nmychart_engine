import 'package:flutter/material.dart';
import '../../models/models.dart';

/// Base class for all chart painters
/// Each plot type has its own painter implementation
abstract class ChartPainter extends CustomPainter {
  final Plot plot;
  final Size canvasSize;
  final Paint paintStroke;
  final Paint paintFill;

  ChartPainter({required this.plot, required this.canvasSize})
    : paintStroke = Paint()
        ..color = _parseColor(plot.color)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
      paintFill = Paint()
        ..color = _parseColor(plot.color).withOpacity(0.3)
        ..style = PaintingStyle.fill;

  /// Parse color from hex string
  static Color _parseColor(String? hexColor) {
    if (hexColor == null) return Colors.blue;
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) =>
      plot != oldDelegate.plot || canvasSize != oldDelegate.canvasSize;

  @override
  bool shouldRebuildSemantics(ChartPainter oldDelegate) => false;

  /// Draw grid lines
  void drawGrid(Canvas canvas) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5;

    // Vertical grid lines
    for (int i = 0; i <= 5; i++) {
      final x = (canvasSize.width / 5) * i;
      canvas.drawLine(Offset(x, 0), Offset(x, canvasSize.height), gridPaint);
    }

    // Horizontal grid lines
    for (int i = 0; i <= 5; i++) {
      final y = (canvasSize.height / 5) * i;
      canvas.drawLine(Offset(0, y), Offset(canvasSize.width, y), gridPaint);
    }
  }

  /// Draw axes
  void drawAxes(Canvas canvas) {
    final axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    // X axis
    canvas.drawLine(
      Offset(0, canvasSize.height),
      Offset(canvasSize.width, canvasSize.height),
      axisPaint,
    );

    // Y axis
    canvas.drawLine(Offset(0, 0), Offset(0, canvasSize.height), axisPaint);
  }
}
