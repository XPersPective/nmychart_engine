import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Pie Plot Render Delegate
/// Renders pie chart with slices
class PiePlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! PiePlot) return;

    // Pie charts don't draw grid
    // Pie charts don't draw traditional axes

    final fieldKeyValue = plot.fieldKeyValue ?? plot.fieldKeyY;
    if (fieldKeyValue == null) return;

    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyValue);
    if (yFieldIndex == null) return;

    // Collect values
    final values = <num>[];
    for (final row in data) {
      if (row.length > yFieldIndex && row[yFieldIndex] is num) {
        values.add(row[yFieldIndex]);
      }
    }

    if (values.isEmpty) return;

    final total = values.reduce((a, b) => a + b);
    if (total <= 0) return;

    final center = Offset(context.size.width / 2, context.size.height / 2);
    final radius = math.min(context.size.width, context.size.height) / 2 - 20;

    final colors = _generateColors(values.length);
    var startAngle = -math.pi / 2;

    // Draw pie slices
    for (int i = 0; i < values.length; i++) {
      final value = values[i];
      final sliceAngle = (value / total) * 2 * math.pi;

      context.canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sliceAngle,
        true,
        Paint()
          ..color = colors[i]
          ..style = PaintingStyle.fill,
      );

      context.canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sliceAngle,
        true,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0,
      );

      // Draw percentage label
      final labelAngle = startAngle + sliceAngle / 2;
      final labelRadius = radius * 0.7;
      final labelX = center.dx + labelRadius * math.cos(labelAngle);
      final labelY = center.dy + labelRadius * math.sin(labelAngle);

      final percentage = ((value / total) * 100).toStringAsFixed(1);
      _drawText(
        context.canvas,
        percentage + '%',
        Offset(labelX, labelY),
        Colors.white,
      );

      startAngle += sliceAngle;
    }

    // Draw notations (labels on slices)
    drawNotations(context, null, data);
  }

  int? _findFieldIndex(List<ChartField>? fields, String key) {
    if (fields == null) return null;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].key == key) return i;
    }
    return null;
  }

  List<Color> _generateColors(int count) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
    ];
    return List.generate(count, (i) => colors[i % colors.length]);
  }

  void _drawText(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      position - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }
}
