import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Area Plot Render Delegate
/// Renders filled area under a line
class AreaPlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! AreaPlot) return;

    drawGrid(context);
    drawAxes(context);

    final fieldKeyX = plot.fieldKeyX;
    final fieldKeyY = plot.fieldKeyY;

    if (fieldKeyX == null || fieldKeyY == null) return;

    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyY);
    if (yFieldIndex == null) return;

    final baseColor = _parseColor(plot.color ?? '#1890FF');
    final maxY = _getMaxValue(data, yFieldIndex);
    final minY = _getMinValue(data, yFieldIndex);
    final range = maxY - minY;

    final path = Path();
    bool first = true;

    // Create path for area
    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      if (row.length <= yFieldIndex) continue;

      final yValue = row[yFieldIndex];
      if (yValue is! num) continue;

      final normalizedY = range == 0 ? 0.5 : (yValue - minY) / range;
      final x = (context.size.width / data.length) * (i + 0.5);
      final y = context.size.height - (normalizedY * context.size.height);

      if (first) {
        path.moveTo(x, y);
        first = false;
      } else {
        path.lineTo(x, y);
      }
    }

    // Close path for area fill
    path.lineTo(context.size.width, context.size.height);
    path.lineTo(0, context.size.height);
    path.close();

    // Draw filled area
    context.canvas.drawPath(
      path,
      Paint()
        ..color = baseColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill,
    );

    // Draw border line
    final borderPath = Path();
    first = true;
    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      if (row.length <= yFieldIndex) continue;

      final yValue = row[yFieldIndex];
      if (yValue is! num) continue;

      final normalizedY = range == 0 ? 0.5 : (yValue - minY) / range;
      final x = (context.size.width / data.length) * (i + 0.5);
      final y = context.size.height - (normalizedY * context.size.height);

      if (first) {
        borderPath.moveTo(x, y);
        first = false;
      } else {
        borderPath.lineTo(x, y);
      }
    }

    context.canvas.drawPath(
      borderPath,
      Paint()
        ..color = baseColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );

    drawGuides(context, null);
    drawNotations(context, null, data);
  }

  int? _findFieldIndex(List<ChartField>? fields, String key) {
    if (fields == null) return null;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].key == key) return i;
    }
    return null;
  }

  num _getMaxValue(List<List<dynamic>> data, int columnIndex) {
    num max = 0;
    for (final row in data) {
      if (row.length > columnIndex && row[columnIndex] is num) {
        max = max < row[columnIndex] ? row[columnIndex] : max;
      }
    }
    return max;
  }

  num _getMinValue(List<List<dynamic>> data, int columnIndex) {
    num min = double.infinity;
    for (final row in data) {
      if (row.length > columnIndex && row[columnIndex] is num) {
        min = min > row[columnIndex] ? row[columnIndex] : min;
      }
    }
    return min == double.infinity ? 0 : min;
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }
}
