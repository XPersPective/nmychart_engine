import 'enums/enums.dart';

/// Chart Guide Model
/// Visual guides (lines, zones) on chart
class ChartGuide {
  final GuideType guideType;
  final String axis;
  final dynamic value;
  final dynamic start;
  final dynamic end;
  final String label;
  final String color;
  final StrokeStyle strokeStyle;

  ChartGuide({
    required this.guideType,
    required this.axis,
    this.value,
    this.start,
    this.end,
    required this.label,
    required this.color,
    this.strokeStyle = StrokeStyle.solid,
  });

  /// Create from JSON
  factory ChartGuide.fromJson(Map<String, dynamic> json) {
    return ChartGuide(
      guideType: _parseGuideType(json['guideType'] as String? ?? 'line'),
      axis: json['axis'] as String? ?? 'y',
      value: json['value'],
      start: json['start'],
      end: json['end'],
      label: json['label'] as String? ?? '',
      color: json['color'] as String? ?? '#000000',
      strokeStyle: _parseStrokeStyle(json['strokeStyle'] as String? ?? 'solid'),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'guideType': _guideTypeToString(guideType),
    'axis': axis,
    if (value != null) 'value': value,
    if (start != null) 'start': start,
    if (end != null) 'end': end,
    'label': label,
    'color': color,
    'strokeStyle': _strokeStyleToString(strokeStyle),
  };

  static GuideType _parseGuideType(String typeStr) {
    switch (typeStr.toLowerCase()) {
      case 'line':
        return GuideType.line;
      case 'zone':
        return GuideType.zone;
      default:
        return GuideType.line;
    }
  }

  static String _guideTypeToString(GuideType type) {
    switch (type) {
      case GuideType.line:
        return 'line';
      case GuideType.zone:
        return 'zone';
      case GuideType.ribbon:
        return 'ribbon';
      case GuideType.bands:
        return 'bands';
      case GuideType.circle:
        return 'circle';
      case GuideType.rectangle:
        return 'rectangle';
    }
  }

  static StrokeStyle _parseStrokeStyle(String styleStr) {
    switch (styleStr.toLowerCase()) {
      case 'solid':
        return StrokeStyle.solid;
      case 'dashed':
        return StrokeStyle.dashed;
      case 'dotted':
        return StrokeStyle.dotted;
      default:
        return StrokeStyle.solid;
    }
  }

  static String _strokeStyleToString(StrokeStyle style) {
    switch (style) {
      case StrokeStyle.solid:
        return 'solid';
      case StrokeStyle.dashed:
        return 'dashed';
      case StrokeStyle.dotted:
        return 'dotted';
      case StrokeStyle.dashedDot:
        return 'dashedDot';
    }
  }
}
