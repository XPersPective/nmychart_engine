import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'chart_painter.dart';

/// Painter for Candlestick charts
/// Renders OHLC (Open, High, Low, Close) data for financial charts
class CandlestickPainter extends ChartPainter {
  final List<CandleData> candles;

  CandlestickPainter({
    required CandlestickPlot plot,
    required Size canvasSize,
    required this.candles,
  }) : super(plot: plot, canvasSize: canvasSize);

  @override
  void paint(Canvas canvas, Size size) {
    // Call plot's render method to handle conditions and plot-specific logic
    plot.render(canvas, size);

    // Draw grid and axes
    drawGrid(canvas);
    drawAxes(canvas);

    if (candles.isEmpty) return;

    // Find min and max prices
    double minPrice = double.infinity;
    double maxPrice = -double.infinity;

    for (final candle in candles) {
      minPrice = minPrice < candle.low ? minPrice : candle.low;
      maxPrice = maxPrice > candle.high ? maxPrice : candle.high;
    }

    final range = maxPrice - minPrice;
    final candleWidth = size.width / (candles.length * 2);

    for (int i = 0; i < candles.length; i++) {
      final candle = candles[i];
      final x = candleWidth * 2 * i + candleWidth / 2;

      // Normalize prices
      final openY =
          size.height - ((candle.open - minPrice) / range) * size.height;
      final closeY =
          size.height - ((candle.close - minPrice) / range) * size.height;
      final highY =
          size.height - ((candle.high - minPrice) / range) * size.height;
      final lowY =
          size.height - ((candle.low - minPrice) / range) * size.height;

      // Determine color (up or down)
      final isUp = candle.close >= candle.open;
      final candlePaint = Paint()
        ..color = isUp ? Colors.green : Colors.red
        ..style = PaintingStyle.fill;
      final wickPaint = Paint()
        ..color = isUp ? Colors.green : Colors.red
        ..strokeWidth = 1.0;

      // Draw wick (high-low line)
      canvas.drawLine(Offset(x, highY), Offset(x, lowY), wickPaint);

      // Draw body (open-close rectangle)
      final bodyRect = Rect.fromLTWH(
        x - candleWidth / 3,
        isUp ? closeY : openY,
        candleWidth * 2 / 3,
        (openY - closeY).abs(),
      );
      canvas.drawRect(bodyRect, candlePaint);
      canvas.drawRect(bodyRect, paintStroke);
    }
  }
}

/// Data class for candlestick
class CandleData {
  final double open;
  final double high;
  final double low;
  final double close;

  CandleData({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });
}
