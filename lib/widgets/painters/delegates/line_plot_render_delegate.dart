import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Line Plot Render Delegate
/// Renders continuous lines connecting data points
class LinePlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! LinePlot) return;

    // Draw grid (if applicable for this chart type)
    drawGrid(context);
    drawAxes(context);

    // Extract field keys
    final fieldKeyX = plot.fieldKeyX;
    final fieldKeyY = plot.fieldKeyY;

    if (fieldKeyX == null || fieldKeyY == null) return;

    // Find field indices from field keys
    final xFieldIndex = _findFieldIndex(context.fields, fieldKeyX);
    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyY);

    if (xFieldIndex == null || yFieldIndex == null) return;

    // Parse plot color
    final baseColor = _parseColor(plot.color ?? '#1890FF');

    // Create path for line
    final path = Path();
    bool first = true;
    final pointRadius = 3.0;

    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      if (row.length <= yFieldIndex) continue;

      final yValue = row[yFieldIndex];
      if (yValue is! num) continue;

      // Normalize Y value to canvas height
      final maxY = _getMaxValue(data, yFieldIndex);
      final minY = _getMinValue(data, yFieldIndex);
      final range = maxY - minY;

      final normalizedY = range == 0 ? 0.5 : (yValue - minY) / range; // 0 to 1

      final x = (context.size.width / data.length) * (i + 0.5);
      final y = context.size.height - (normalizedY * context.size.height);

      // Check for condition-based color override
      final conditionColor = plot.conditions != null
          ? getConditionColor(yValue, _parseConditions(plot.conditions))
          : null;

      final lineColor = conditionColor ?? baseColor;

      if (first) {
        path.moveTo(x, y);
        first = false;
      } else {
        path.lineTo(x, y);
      }

      // Draw point at each data node
      context.canvas.drawCircle(
        Offset(x, y),
        pointRadius,
        Paint()
          ..color = lineColor
          ..style = PaintingStyle.fill,
      );
    }

    // Draw the line
    context.canvas.drawPath(
      path,
      Paint()
        ..color = baseColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );

    // Draw guides
    if (context.fields != null) {
      // Parse guides from plot's parent chart
      drawGuides(context, null); // Guides come from Chart, not Plot
    }

    // Draw notations
    if (context.fields != null) {
      drawNotations(context, null, data); // Notations from Chart
    }
  }

  /// Find field index by key name
  int? _findFieldIndex(List<ChartField>? fields, String key) {
    if (fields == null) return null;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].key == key) {
        return i;
      }
    }
    return null;
  }

  /// Get max value from column
  num _getMaxValue(List<List<dynamic>> data, int columnIndex) {
    num max = 0;
    for (final row in data) {
      if (row.length > columnIndex && row[columnIndex] is num) {
        max = max < row[columnIndex] ? row[columnIndex] : max;
      }
    }
    return max;
  }

  /// Get min value from column
  num _getMinValue(List<List<dynamic>> data, int columnIndex) {
    num min = double.infinity;
    for (final row in data) {
      if (row.length > columnIndex && row[columnIndex] is num) {
        min = min > row[columnIndex] ? row[columnIndex] : min;
      }
    }
    return min == double.infinity ? 0 : min;
  }

  /// Parse color from hex string
  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }

  /// Parse conditions from plot
  List<PlotConditionData>? _parseConditions(List<PlotCondition>? conditions) {
    if (conditions == null) return null;
    return conditions
        .map(
          (c) => PlotConditionData(name: c.name ?? 'condition', type: 'custom'),
        )
        .toList();
  }
}
