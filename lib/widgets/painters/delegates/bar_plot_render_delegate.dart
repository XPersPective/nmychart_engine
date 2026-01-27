import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Bar Plot Render Delegate
/// Renders vertical or horizontal bars
class BarPlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! BarPlot) return;

    // Draw grid (if applicable)
    drawGrid(context);
    drawAxes(context);

    final fieldKeyX = plot.fieldKeyX;
    final fieldKeyY = plot.fieldKeyY;

    if (fieldKeyX == null || fieldKeyY == null) return;

    // Find field indices
    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyY);
    if (yFieldIndex == null) return;

    // Parse colors
    final baseColor = _parseColor(plot.color ?? '#1890FF');

    // Calculate bar width
    final barWidth = context.size.width / (data.length * 2);
    final maxValue = _getMaxValue(data, yFieldIndex);

    // Draw bars
    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      if (row.length <= yFieldIndex) continue;

      final yValue = row[yFieldIndex];
      if (yValue is! num) continue;

      // Normalize height
      final normalizedHeight = maxValue == 0 ? 0 : (yValue / maxValue);

      final x = barWidth * 2 * i + barWidth / 2;
      final height = normalizedHeight * context.size.height;
      final barTop = context.size.height - height;

      // Check condition for color override
      final conditionColor = plot.conditions != null
          ? getConditionColor(yValue, _parseConditions(plot.conditions))
          : null;

      final barColor = conditionColor ?? baseColor;

      // Draw bar
      final rect = Rect.fromLTWH(x, barTop, barWidth, height);

      context.canvas.drawRect(
        rect,
        Paint()
          ..color = barColor
          ..style = PaintingStyle.fill,
      );

      // Draw border
      context.canvas.drawRect(
        rect,
        Paint()
          ..color = barColor.withValues(alpha: 0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }

    // Draw guides
    drawGuides(context, null); // From Chart level

    // Draw notations
    drawNotations(context, null, data);
  }

  /// Find field index by key
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

  /// Parse color from hex
  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }

  /// Parse conditions
  List<PlotConditionData>? _parseConditions(List<PlotCondition>? conditions) {
    if (conditions == null) return null;
    return conditions
        .map(
          (c) => PlotConditionData(
            name: c.name ?? 'condition',
            type: 'threshold',
            operator: c.operator.symbol,
            value: _extractNumericValue(c.value1),
            color: _extractColor(c.result),
          ),
        )
        .toList();
  }

  /// Extract numeric value from condition value map
  dynamic _extractNumericValue(Map<String, dynamic> valueMap) {
    if (valueMap.isEmpty) return null;
    // Try common keys for numeric values
    for (final key in ['value', 'val', 'number', 'amount', 'threshold']) {
      if (valueMap.containsKey(key) && valueMap[key] is num) {
        return valueMap[key];
      }
    }
    // Return first numeric value found
    for (final value in valueMap.values) {
      if (value is num) return value;
    }
    return null;
  }

  /// Extract color from condition result map
  String? _extractColor(Map<String, dynamic> resultMap) {
    if (resultMap.isEmpty) return null;
    // Try common keys for color
    for (final key in ['color', 'fill', 'stroke']) {
      if (resultMap.containsKey(key) && resultMap[key] is String) {
        return resultMap[key] as String;
      }
    }
    return null;
  }
}
