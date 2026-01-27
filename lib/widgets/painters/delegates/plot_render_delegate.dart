import 'package:flutter/material.dart';
import '../../../models/models.dart';

/// Rendering context for plot drawing
/// Contains information about the chart environment
class RenderContext {
  final Canvas canvas;
  final Size size;
  final bool isMainChart; // Main chart → grid visible
  final bool isOverlay; // Overlay → no grid
  final bool isPanel; // Panel chart → grid visible
  final List<ChartField>? fields;
  final List<List<dynamic>>? data;

  RenderContext({
    required this.canvas,
    required this.size,
    this.isMainChart = true,
    this.isOverlay = false,
    this.isPanel = false,
    this.fields,
    this.data,
  });

  /// Should grid be drawn?
  bool get shouldDrawGrid => (isMainChart || isPanel) && !isOverlay;
}

/// Condition for dynamic plot styling
class PlotConditionData {
  final String name;
  final String? description;
  final String type; // threshold, range, custom
  final String? field;
  final String? operator; // >, <, ==, !=, etc
  final dynamic value;
  final String? color;

  PlotConditionData({
    required this.name,
    this.description,
    required this.type,
    this.field,
    this.operator,
    this.value,
    this.color,
  });

  factory PlotConditionData.fromJson(Map<String, dynamic> json) {
    return PlotConditionData(
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String? ?? 'custom',
      field: json['field'] as String?,
      operator: json['operator'] as String?,
      value: json['value'],
      color: json['color'] as String?,
    );
  }
}

/// Guide line for chart reference
class GuideData {
  final String guideType; // line, band
  final String axis; // x, y
  final double value;
  final String? label;
  final String color;
  final String strokeStyle; // solid, dashed, dotted

  GuideData({
    required this.guideType,
    required this.axis,
    required this.value,
    this.label,
    this.color = '#1890FF',
    this.strokeStyle = 'solid',
  });

  factory GuideData.fromJson(Map<String, dynamic> json) {
    return GuideData(
      guideType: json['guideType'] as String? ?? 'line',
      axis: json['axis'] as String,
      value: (json['value'] as num).toDouble(),
      label: json['label'] as String?,
      color: json['color'] as String? ?? '#1890FF',
      strokeStyle: json['strokeStyle'] as String? ?? 'solid',
    );
  }
}

/// Notation mark on chart
class NotationData {
  final String shape; // triangle, circle, square
  final String? label;
  final List<int> dataIndices;
  final String color;
  final String direction; // up, down

  NotationData({
    required this.shape,
    this.label,
    required this.dataIndices,
    this.color = '#1890FF',
    this.direction = 'up',
  });

  factory NotationData.fromJson(Map<String, dynamic> json) {
    return NotationData(
      shape: json['shape'] as String,
      label: json['label'] as String?,
      dataIndices: List<int>.from(json['dataIndices'] as List),
      color: json['color'] as String? ?? '#1890FF',
      direction: json['direction'] as String? ?? 'up',
    );
  }
}

/// Abstract base class for all plot render delegates
/// Handles rendering of specific plot type with support for:
/// - Grid (conditional)
/// - Guides (reference lines)
/// - Notations (markers)
/// - Conditions (styling overrides)
abstract class PlotRenderDelegate {
  /// Main paint method called by widget
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  );

  /// Draw grid lines (if applicable)
  void drawGrid(RenderContext context) {
    if (!context.shouldDrawGrid) return;

    final gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..strokeWidth = 0.5;

    // Vertical grid lines
    for (int i = 0; i <= 10; i++) {
      final x = context.size.width * i / 10;
      context.canvas.drawLine(
        Offset(x, 0),
        Offset(x, context.size.height),
        gridPaint,
      );
    }

    // Horizontal grid lines
    for (int i = 0; i <= 10; i++) {
      final y = context.size.height * i / 10;
      context.canvas.drawLine(
        Offset(0, y),
        Offset(context.size.width, y),
        gridPaint,
      );
    }
  }

  /// Draw axes
  void drawAxes(RenderContext context) {
    final axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    // X axis
    context.canvas.drawLine(
      Offset(0, context.size.height),
      Offset(context.size.width, context.size.height),
      axisPaint,
    );

    // Y axis
    context.canvas.drawLine(
      Offset(0, 0),
      Offset(0, context.size.height),
      axisPaint,
    );
  }

  /// Draw guide lines/bands
  void drawGuides(RenderContext context, List<GuideData>? guides) {
    if (guides == null || guides.isEmpty) return;

    for (final guide in guides) {
      _drawSingleGuide(context, guide);
    }
  }

  void _drawSingleGuide(RenderContext context, GuideData guide) {
    final color = _parseColor(guide.color);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    // Apply stroke style
    if (guide.strokeStyle == 'dashed') {
      // For simplicity, use different opacity for dashed effect
      paint.strokeWidth = 1.5;
    }

    if (guide.axis.toLowerCase() == 'y') {
      // Horizontal guide line (Y axis value)
      final y = context.size.height - (guide.value / 100 * context.size.height);
      context.canvas.drawLine(
        Offset(0, y),
        Offset(context.size.width, y),
        paint,
      );

      // Draw label if exists
      if (guide.label != null) {
        _drawText(context, guide.label!, Offset(5, y - 10), color);
      }
    } else if (guide.axis.toLowerCase() == 'x') {
      // Vertical guide line (X axis value)
      final x = guide.value / 100 * context.size.width;
      context.canvas.drawLine(
        Offset(x, 0),
        Offset(x, context.size.height),
        paint,
      );

      // Draw label if exists
      if (guide.label != null) {
        _drawText(
          context,
          guide.label!,
          Offset(x + 5, context.size.height - 15),
          color,
        );
      }
    }
  }

  /// Draw notations (markers)
  void drawNotations(
    RenderContext context,
    List<NotationData>? notations,
    List<List<dynamic>> data,
  ) {
    if (notations == null || notations.isEmpty) return;

    for (final notation in notations) {
      _drawSingleNotation(context, notation, data);
    }
  }

  void _drawSingleNotation(
    RenderContext context,
    NotationData notation,
    List<List<dynamic>> data,
  ) {
    for (final dataIndex in notation.dataIndices) {
      if (dataIndex < 0 || dataIndex >= data.length) continue;

      // Position based on data index
      final x = (context.size.width / data.length) * (dataIndex + 0.5);
      final y = notation.direction == 'up'
          ? context.size.height / 4
          : (context.size.height * 3) / 4;

      final color = _parseColor(notation.color);

      // Draw shape
      switch (notation.shape.toLowerCase()) {
        case 'triangle':
          _drawTriangle(context, Offset(x, y), color);
          break;
        case 'circle':
          _drawCircle(context, Offset(x, y), color);
          break;
        case 'square':
          _drawSquare(context, Offset(x, y), color);
          break;
      }

      // Draw label if exists
      if (notation.label != null) {
        _drawText(context, notation.label!, Offset(x + 10, y - 15), color);
      }
    }
  }

  /// Helper: Draw triangle shape
  void _drawTriangle(RenderContext context, Offset center, Color color) {
    final size = 8.0;
    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx + size, center.dy + size);
    path.lineTo(center.dx - size, center.dy + size);
    path.close();

    context.canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  /// Helper: Draw circle shape
  void _drawCircle(RenderContext context, Offset center, Color color) {
    context.canvas.drawCircle(
      center,
      5,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  /// Helper: Draw square shape
  void _drawSquare(RenderContext context, Offset center, Color color) {
    final size = 5.0;
    final rect = Rect.fromCenter(
      center: center,
      width: size * 2,
      height: size * 2,
    );
    context.canvas.drawRect(
      rect,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  /// Helper: Draw text on canvas
  void _drawText(
    RenderContext context,
    String text,
    Offset offset,
    Color color,
  ) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 12),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(context.canvas, offset);
  }

  /// Helper: Parse color from hex string
  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }

  /// Apply conditions to get styling overrides
  Color? getConditionColor(dynamic value, List<PlotConditionData>? conditions) {
    if (conditions == null || conditions.isEmpty) return null;

    for (final condition in conditions) {
      if (condition.type == 'threshold' && condition.operator != null) {
        final matches = _evaluateCondition(value, condition);
        if (matches && condition.color != null) {
          return _parseColor(condition.color!);
        }
      }
    }

    return null;
  }

  /// Evaluate a single condition
  bool _evaluateCondition(dynamic value, PlotConditionData condition) {
    if (value is! num) return false;

    switch (condition.operator) {
      case '>':
        return value > (condition.value ?? 0);
      case '<':
        return value < (condition.value ?? 0);
      case '==':
        return value == condition.value;
      case '!=':
        return value != condition.value;
      case '>=':
        return value >= (condition.value ?? 0);
      case '<=':
        return value <= (condition.value ?? 0);
      default:
        return false;
    }
  }
}
