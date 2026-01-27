import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../controllers/chart_controller.dart';
import '../painters/delegates/plot_render_delegate_factory.dart';
import '../painters/delegates/plot_render_delegate.dart';

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
          // updateCanvasSize should be called in post-frame callback, not during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _controller.updateCanvasSize(size);
            }
          });

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
    final visibleRange = controller.getVisibleRange();
    if (visibleRange.start >= visibleRange.end ||
        controller.data.data.isEmpty) {
      return;
    }

    // Sınırları kontrol et
    final start = visibleRange.start.clamp(0, controller.data.data.length);
    final end = visibleRange.end.clamp(start, controller.data.data.length);

    if (start >= end) {
      return;
    }

    final visibleData = controller.data.data.sublist(start, end);

    for (final plot in controller.data.plots) {
      // Use delegate pattern for rendering
      final delegate = PlotRenderDelegateFactory.createDelegate(plot);

      // Prepare render context
      final isMainChart = plot.plotType.isMainChart;
      final isPanel = plot.plotType.isPanel;
      final isOverlay = plot.plotType.isOverlay;

      final context = RenderContext(
        canvas: canvas,
        size: size,
        isMainChart: isMainChart,
        isOverlay: isOverlay,
        isPanel: isPanel,
        fields: controller.data.fields,
        data: visibleData,
      );

      // Get field reference for type-safe rendering
      final timeField = controller.data.getTimeField();
      if (timeField == null) continue;

      delegate.paint(context, plot, visibleData, timeField, null);
    }
  }

  void _drawAxes(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: Colors.white, fontSize: 10);
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Y-axis labels - SOL TARAF
    final viewport = controller.viewport;
    if (viewport.height > 0) {
      for (int i = 0; i <= 5; i++) {
        final value = viewport.top + (viewport.height * i / 5);
        final yPos = controller.worldToScreen(Offset(0, value)).dy;

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
        final yPos = controller.worldToScreen(Offset(0, value)).dy;

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
        final xPos = controller.worldToScreen(Offset(time, 0)).dx;

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
    return oldDelegate.controller != controller;
  }
}
