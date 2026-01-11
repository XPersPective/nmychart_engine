import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Histogram Plot Render Delegate
/// Renders histogram with bins and frequencies
class HistogramPlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! HistogramPlot) return;

    drawGrid(context);
    drawAxes(context);

    final fieldKeyY = plot.fieldKeyY;
    if (fieldKeyY == null) return;

    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyY);
    if (yFieldIndex == null) return;

    final baseColor = _parseColor(plot.color ?? '#13C2C2');
    final binCount = plot.binCount ?? 10;

    // Collect values
    final values = <num>[];
    for (final row in data) {
      if (row.length > yFieldIndex && row[yFieldIndex] is num) {
        values.add(row[yFieldIndex]);
      }
    }

    if (values.isEmpty) return;

    // Calculate histogram bins
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    final binWidth = (maxVal - minVal) / binCount;

    final histogram = <int>[for (int i = 0; i < binCount; i++) 0];
    for (final val in values) {
      final binIndex = ((val - minVal) / binWidth).toInt();
      if (binIndex < binCount && binIndex >= 0) {
        histogram[binIndex]++;
      }
    }

    final maxFreq = histogram.reduce((a, b) => a > b ? a : b);
    final barWidth = context.size.width / binCount;

    // Draw histogram bars
    for (int i = 0; i < binCount; i++) {
      final freq = histogram[i];
      final normalizedHeight = freq / maxFreq;
      final barHeight = normalizedHeight * context.size.height * 0.8;

      final left = i * barWidth;
      final top = context.size.height - barHeight;
      final right = (i + 1) * barWidth;
      final bottom = context.size.height;

      final rect = Rect.fromLTRB(left, top, right, bottom);

      context.canvas.drawRect(
        rect,
        Paint()
          ..color = baseColor
          ..style = PaintingStyle.fill,
      );

      context.canvas.drawRect(
        rect,
        Paint()
          ..color = baseColor.withOpacity(0.8)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0,
      );
    }

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

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.teal;
    }
  }
}
