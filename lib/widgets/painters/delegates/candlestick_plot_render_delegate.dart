import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

/// Candlestick Plot Render Delegate
/// Renders OHLC (Open, High, Low, Close) candlestick chart
class CandlestickPlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty) return;
    if (plot is! CandlestickPlot) return;

    drawGrid(context);
    drawAxes(context);

    final fieldKeyOpen = plot.fieldKeyOpen;
    final fieldKeyHigh = plot.fieldKeyHigh;
    final fieldKeyLow = plot.fieldKeyLow;
    final fieldKeyClose = plot.fieldKeyClose;

    if (fieldKeyOpen == null ||
        fieldKeyHigh == null ||
        fieldKeyLow == null ||
        fieldKeyClose == null) {
      return;
    }

    final openIdx = _findFieldIndex(context.fields, fieldKeyOpen);
    final highIdx = _findFieldIndex(context.fields, fieldKeyHigh);
    final lowIdx = _findFieldIndex(context.fields, fieldKeyLow);
    final closeIdx = _findFieldIndex(context.fields, fieldKeyClose);

    if (openIdx == null ||
        highIdx == null ||
        lowIdx == null ||
        closeIdx == null) {
      return;
    }

    // Find min/max for normalization
    num minVal = double.infinity;
    num maxVal = -double.infinity;

    for (final row in data) {
      if (row.length > highIdx && row[highIdx] is num) {
        maxVal = maxVal > row[highIdx] ? maxVal : row[highIdx];
      }
      if (row.length > lowIdx && row[lowIdx] is num) {
        minVal = minVal < row[lowIdx] ? minVal : row[lowIdx];
      }
    }

    if (minVal == double.infinity) return;

    final range = maxVal - minVal;
    final candleWidth = context.size.width / (data.length * 2);

    // Draw candlesticks
    for (int i = 0; i < data.length; i++) {
      final row = data[i];

      if (row.length <= closeIdx ||
          row[openIdx] is! num ||
          row[highIdx] is! num ||
          row[lowIdx] is! num ||
          row[closeIdx] is! num) {
        continue;
      }

      final open = row[openIdx] as num;
      final high = row[highIdx] as num;
      final low = row[lowIdx] as num;
      final close = row[closeIdx] as num;

      // Normalize values
      final normalizedOpen = range == 0 ? 0.5 : (open - minVal) / range;
      final normalizedHigh = range == 0 ? 0.5 : (high - minVal) / range;
      final normalizedLow = range == 0 ? 0.5 : (low - minVal) / range;
      final normalizedClose = range == 0 ? 0.5 : (close - minVal) / range;

      final x = (context.size.width / data.length) * (i + 0.5);
      final yHigh =
          context.size.height - (normalizedHigh * context.size.height);
      final yLow = context.size.height - (normalizedLow * context.size.height);
      final yOpen =
          context.size.height - (normalizedOpen * context.size.height);
      final yClose =
          context.size.height - (normalizedClose * context.size.height);

      final isUp = close >= open;
      final bodyColor = isUp ? Colors.green : Colors.red;
      final bodyTop = isUp ? yClose : yOpen;
      final bodyBottom = isUp ? yOpen : yClose;

      // Draw wick (high-low line)
      context.canvas.drawLine(
        Offset(x, yHigh),
        Offset(x, yLow),
        Paint()
          ..color = bodyColor
          ..strokeWidth = 1.0,
      );

      // Draw body (open-close rectangle)
      final bodyHeight = (bodyBottom - bodyTop).abs();
      final bodyRect = Rect.fromLTWH(
        x - candleWidth,
        bodyTop,
        candleWidth * 2,
        bodyHeight == 0 ? 2 : bodyHeight,
      );

      context.canvas.drawRect(
        bodyRect,
        Paint()
          ..color = bodyColor
          ..style = PaintingStyle.fill,
      );

      context.canvas.drawRect(
        bodyRect,
        Paint()
          ..color = bodyColor.withValues(alpha: 0.8)
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
}
