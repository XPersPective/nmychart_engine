import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../controllers/chart_controller.dart';
import '../../utils/extensions.dart';

class NMychart extends StatefulWidget {
  final ChartData data;
  final ChartController? controller;

  const NMychart({super.key, required this.data, this.controller});

  @override
  State<NMychart> createState() => _NMychartState();
}

class _NMychartState extends State<NMychart> {
  late ChartController _controller;
  Offset? _lastFocalPoint;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ChartController(widget.data);
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(NMychart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      _controller.updateData(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          _controller.updateCanvasSize(size);

          return Listener(
            onPointerSignal: (pointerSignal) {
              if (pointerSignal is PointerScrollEvent) {
                // Mouse wheel ile zoom
                final scrollDelta = pointerSignal.scrollDelta.dy;
                final zoomFactor = scrollDelta > 0 ? 0.9 : 1.1;
                _controller.zoom(zoomFactor, pointerSignal.localPosition);
              }
            },
            child: GestureDetector(
              onScaleStart: (details) {
                _lastFocalPoint = details.localFocalPoint;
              },
              onScaleUpdate: (details) {
                if (details.scale != 1.0) {
                  _controller.zoom(details.scale, details.localFocalPoint);
                } else if (_lastFocalPoint != null) {
                  final delta =
                      details.localFocalPoint.dx - _lastFocalPoint!.dx;
                  _controller.pan(delta);
                }
                _lastFocalPoint = details.localFocalPoint;
              },
              onHorizontalDragUpdate: (details) {
                _controller.pan(details.delta.dx);
              },
              child: CustomPaint(
                size: size,
                painter: _NMychartPainter(controller: _controller),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NMychartPainter extends CustomPainter {
  final ChartController controller;

  _NMychartPainter({required this.controller});

  @override
  void paint(Canvas canvas, Size size) {
    // Canvas boyutu geçerli değilse çiz
    if (size.isEmpty) return;

    _drawGrid(canvas, size);
    _drawPlots(canvas, size);
    _drawAxes(canvas, size);
  }

  void _drawGrid(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 0.5;

    // Vertical lines
    for (int i = 0; i <= 10; i++) {
      final x = size.width * i / 10;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Horizontal lines
    for (int i = 0; i <= 10; i++) {
      final y = size.height * i / 10;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawPlots(Canvas canvas, Size size) {
    final visibleRange = this.controller.getVisibleRange();
    if (visibleRange.start >= visibleRange.end ||
        this.controller.data.data.isEmpty) {
      return;
    }

    // Sınırları kontrol et
    final start = visibleRange.start.clamp(0, this.controller.data.data.length);
    final end = visibleRange.end.clamp(start, this.controller.data.data.length);

    if (start >= end) {
      return;
    }

    final visibleData = this.controller.data.data.sublist(start, end);

    for (final plot in this.controller.data.plots) {
      _drawPlot(canvas, plot, visibleData, start);
    }
  }

  void _drawPlot(
    Canvas canvas,
    dynamic plot,
    List<List<dynamic>> data,
    int dataOffset,
  ) {
    final field = _getField(plot.fieldIndex);
    final timeField = controller.data.getTimeField();
    if (field == null || timeField == null) return;

    switch (plot.type) {
      case 'line':
        _drawLine(canvas, plot, field, timeField, data, dataOffset);
        break;
      case 'bar':
        _drawBars(canvas, plot, field, timeField, data, dataOffset);
        break;
    }
  }

  dynamic _getField(dynamic fieldIndex) {
    if (fieldIndex is int) {
      // Find field by position in array
      if (fieldIndex >= 0 && fieldIndex < controller.data.fields.length) {
        return controller.data.fields[fieldIndex];
      }
      return null;
    } else if (fieldIndex is String) {
      // Find field by key
      return controller.data.fields.firstWhereOrNull(
        (f) => f.key == fieldIndex,
      );
    }
    return null;
  }

  void _drawLine(
    Canvas canvas,
    dynamic plot,
    dynamic field,
    dynamic timeField,
    List<List<dynamic>> data,
    int dataOffset,
  ) {
    if (data.isEmpty || data.length < 2) return;
    if (field == null || timeField == null) return;

    final path = Path();
    bool first = true;
    int validPoints = 0;

    for (int i = 0; i < data.length; i++) {
      final point = data[i];
      if (point.length <=
          (timeField.index > field.index ? timeField.index : field.index)) {
        continue;
      }

      try {
        final time = (point[timeField.index] as num).toDouble();
        final value = (point[field.index] as num).toDouble();

        // NaN ve Infinity kontrolü
        if (time.isNaN || time.isInfinite || value.isNaN || value.isInfinite) {
          continue;
        }

        final screenPos = controller.worldToScreen(Offset(time, value));

        if (first) {
          path.moveTo(screenPos.dx, screenPos.dy);
          first = false;
        } else {
          path.lineTo(screenPos.dx, screenPos.dy);
        }
        validPoints++;
      } catch (e) {
        // Hatalı veri noktasını atla
        continue;
      }
    }

    if (validPoints < 2) return;

    final paint = Paint()
      ..color = plot.color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  void _drawBars(
    Canvas canvas,
    dynamic plot,
    dynamic field,
    dynamic timeField,
    List<List<dynamic>> data,
    int dataOffset,
  ) {
    if (data.isEmpty) return;
    if (field == null || timeField == null) return;

    // İlk iki noktadan bar'lar arasındaki piksel mesafesini hesapla
    double spaceBetweenBars = 0;
    if (data.length >= 2) {
      final firstTime = (data[0][timeField.index] as num).toDouble();
      final secondTime = (data[1][timeField.index] as num).toDouble();

      final firstPos = controller.worldToScreen(Offset(firstTime, 0));
      final secondPos = controller.worldToScreen(Offset(secondTime, 0));

      spaceBetweenBars = (secondPos.dx - firstPos.dx).abs();
    }

    if (spaceBetweenBars <= 0) return;

    // Bar genişliği: toplam alanın %70'i, boşluk: %30'u
    final barWidthPixels = (spaceBetweenBars * 0.70).clamp(1.0, 500.0);

    for (int i = 0; i < data.length; i++) {
      final point = data[i];
      if (point.length <=
          (timeField.index > field.index ? timeField.index : field.index)) {
        continue;
      }

      try {
        final time = (point[timeField.index] as num).toDouble();
        final value = (point[field.index] as num).toDouble();

        // NaN ve Infinity kontrolü
        if (time.isNaN || time.isInfinite || value.isNaN || value.isInfinite) {
          continue;
        }

        Color barColor = plot.color ?? Colors.grey;
        if (plot.style?.condition != null) {
          final condition = plot.style!.condition!;
          final isTrue = condition.evaluate(
            value,
            controller.data,
            i + dataOffset,
          );
          barColor = condition.result.evaluate(isTrue);
        }

        final zeroPos = controller.worldToScreen(Offset(time, 0));
        final valuePos = controller.worldToScreen(Offset(time, value));

        // Bar'ı merkez noktasından sola/sağa eşit çiz
        final rect = Rect.fromPoints(
          Offset(
            zeroPos.dx - barWidthPixels / 2,
            zeroPos.dy < valuePos.dy ? zeroPos.dy : valuePos.dy,
          ),
          Offset(
            zeroPos.dx + barWidthPixels / 2,
            zeroPos.dy > valuePos.dy ? zeroPos.dy : valuePos.dy,
          ),
        );

        final paint = Paint()
          ..color = barColor
          ..style = PaintingStyle.fill;

        canvas.drawRect(rect, paint);
      } catch (e) {
        // Hatalı bar'ı atla
        continue;
      }
    }
  }

  void _drawAxes(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 10);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Y-axis labels - SOL TARAF
    final viewport = this.controller.viewport;
    if (viewport.height > 0) {
      for (int i = 0; i <= 5; i++) {
        final value = viewport.top + (viewport.height * i / 5);
        final yPos = this.controller.worldToScreen(Offset(0, value)).dy;

        final text = TextSpan(text: value.toStringAsFixed(1), style: textStyle);
        textPainter.text = text;
        textPainter.layout();
        textPainter.paint(canvas, Offset(2, yPos - textPainter.height / 2));
      }
    }

    // Y-axis labels - SAĞ TARAF
    if (viewport.height > 0) {
      for (int i = 0; i <= 5; i++) {
        final value = viewport.top + (viewport.height * i / 5);
        final yPos = this.controller.worldToScreen(Offset(0, value)).dy;

        final text = TextSpan(text: value.toStringAsFixed(1), style: textStyle);
        textPainter.text = text;
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            size.width - textPainter.width - 2,
            yPos - textPainter.height / 2,
          ),
        );
      }
    }

    // X-axis labels (time)
    if (viewport.width > 0) {
      for (int i = 0; i <= 5; i++) {
        final time = viewport.left + (viewport.width * i / 5);
        final xPos = this.controller.worldToScreen(Offset(time, 0)).dx;

        final date = DateTime.fromMillisecondsSinceEpoch(time.toInt());
        final text = TextSpan(
          text: '${date.hour}:${date.minute.toString().padLeft(2, '0')}',
          style: textStyle,
        );
        textPainter.text = text;
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            xPos - textPainter.width / 2,
            size.height - textPainter.height,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_NMychartPainter oldDelegate) {
    return oldDelegate.controller != this.controller;
  }
}
