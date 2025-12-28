// ===========================================================================
// ENUMS - ALL TYPE DEFINITIONS
// ===========================================================================

// VALUE TYPES (for inputs and fields)
enum ValueType { integer, double, string, timestamp }

extension ValueTypeExt on ValueType {
  String get stringValue {
    switch (this) {
      case ValueType.integer:
        return 'integer';
      case ValueType.double:
        return 'double';
      case ValueType.string:
        return 'string';
      case ValueType.timestamp:
        return 'timestamp';
    }
  }

  static ValueType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'integer':
        return ValueType.integer;
      case 'double':
        return ValueType.double;
      case 'string':
        return ValueType.string;
      case 'timestamp':
        return ValueType.timestamp;
      default:
        return ValueType.string;
    }
  }
}

// TIME FORMATS (only for timestamp valueType)
enum TimeFormat {
  milliseconds,
  seconds,
  minutes,
  hours,
  days,
  weeks,
  months,
  years,
  iso8601,
}

extension TimeFormatExt on TimeFormat {
  String get stringValue {
    switch (this) {
      case TimeFormat.milliseconds:
        return 'milliseconds';
      case TimeFormat.seconds:
        return 'seconds';
      case TimeFormat.minutes:
        return 'minutes';
      case TimeFormat.hours:
        return 'hours';
      case TimeFormat.days:
        return 'days';
      case TimeFormat.weeks:
        return 'weeks';
      case TimeFormat.months:
        return 'months';
      case TimeFormat.years:
        return 'years';
      case TimeFormat.iso8601:
        return 'iso8601';
    }
  }

  static TimeFormat fromString(String value) {
    switch (value.toLowerCase()) {
      case 'milliseconds':
        return TimeFormat.milliseconds;
      case 'seconds':
        return TimeFormat.seconds;
      case 'minutes':
        return TimeFormat.minutes;
      case 'hours':
        return TimeFormat.hours;
      case 'days':
        return TimeFormat.days;
      case 'weeks':
        return TimeFormat.weeks;
      case 'months':
        return TimeFormat.months;
      case 'years':
        return TimeFormat.years;
      case 'iso8601':
        return TimeFormat.iso8601;
      default:
        return TimeFormat.milliseconds;
    }
  }

  /// Converts timestamp to formatted string
  String formatValue(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    switch (this) {
      case TimeFormat.milliseconds:
        return timestamp.toString();
      case TimeFormat.seconds:
        return (timestamp ~/ 1000).toString();
      case TimeFormat.minutes:
        return (timestamp ~/ 60000).toString();
      case TimeFormat.hours:
        return (timestamp ~/ 3600000).toString();
      case TimeFormat.days:
        return (timestamp ~/ 86400000).toString();
      case TimeFormat.weeks:
        return (timestamp ~/ 604800000).toString();
      case TimeFormat.months:
        return '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
      case TimeFormat.years:
        return dt.year.toString();
      case TimeFormat.iso8601:
        return dt.toIso8601String();
    }
  }
}

// PLOT TYPES
enum PlotType { line, bar, area, candlestick, pie, histogram, map }

extension PlotTypeExt on PlotType {
  String get stringValue {
    switch (this) {
      case PlotType.line:
        return 'line';
      case PlotType.bar:
        return 'bar';
      case PlotType.area:
        return 'area';
      case PlotType.candlestick:
        return 'candlestick';
      case PlotType.pie:
        return 'pie';
      case PlotType.histogram:
        return 'histogram';
      case PlotType.map:
        return 'map';
    }
  }

  static PlotType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'line':
        return PlotType.line;
      case 'bar':
        return PlotType.bar;
      case 'area':
        return PlotType.area;
      case 'candlestick':
        return PlotType.candlestick;
      case 'pie':
        return PlotType.pie;
      case 'histogram':
        return PlotType.histogram;
      case 'map':
        return PlotType.map;
      default:
        return PlotType.line;
    }
  }

  /// Returns applicable transformation types for this plot type
  List<String> getTransforms() {
    switch (this) {
      case PlotType.line:
        return ['line', 'area', 'bar'];
      case PlotType.bar:
        return ['bar', 'area', 'line'];
      case PlotType.area:
        return ['area', 'line', 'bar'];
      case PlotType.candlestick:
        return ['candlestick', 'line', 'bar'];
      case PlotType.pie:
        return ['pie', 'donut'];
      case PlotType.histogram:
        return ['histogram', 'bar', 'area'];
      case PlotType.map:
        return ['map', 'heatmap'];
    }
  }
}

// CONDITION OPERATORS
enum ConditionOperator {
  greaterThan('>'),
  lessThan('<'),
  greaterOrEqual('>='),
  lessOrEqual('<='),
  equal('=='),
  notEqual('!=');

  final String symbol;
  const ConditionOperator(this.symbol);

  static ConditionOperator fromString(String value) {
    switch (value) {
      case '>':
        return ConditionOperator.greaterThan;
      case '<':
        return ConditionOperator.lessThan;
      case '>=':
        return ConditionOperator.greaterOrEqual;
      case '<=':
        return ConditionOperator.lessOrEqual;
      case '==':
        return ConditionOperator.equal;
      case '!=':
        return ConditionOperator.notEqual;
      default:
        return ConditionOperator.equal;
    }
  }

  bool evaluate(dynamic value1, dynamic value2) {
    if (value1 is! num || value2 is! num) return false;
    switch (this) {
      case greaterThan:
        return value1 > value2;
      case lessThan:
        return value1 < value2;
      case greaterOrEqual:
        return value1 >= value2;
      case lessOrEqual:
        return value1 <= value2;
      case equal:
        return value1 == value2;
      case notEqual:
        return value1 != value2;
    }
  }
}

// NOTATION SHAPES
enum NotationShape {
  triangle,
  circle,
  diamond,
  square,
  star,
  arrow,
  cross,
  hexagon,
}

extension NotationShapeExt on NotationShape {
  String get stringValue {
    switch (this) {
      case NotationShape.triangle:
        return 'triangle';
      case NotationShape.circle:
        return 'circle';
      case NotationShape.diamond:
        return 'diamond';
      case NotationShape.square:
        return 'square';
      case NotationShape.star:
        return 'star';
      case NotationShape.arrow:
        return 'arrow';
      case NotationShape.cross:
        return 'cross';
      case NotationShape.hexagon:
        return 'hexagon';
    }
  }

  static NotationShape fromString(String value) {
    switch (value.toLowerCase()) {
      case 'triangle':
        return NotationShape.triangle;
      case 'circle':
        return NotationShape.circle;
      case 'diamond':
        return NotationShape.diamond;
      case 'square':
        return NotationShape.square;
      case 'star':
        return NotationShape.star;
      case 'arrow':
        return NotationShape.arrow;
      case 'cross':
        return NotationShape.cross;
      case 'hexagon':
        return NotationShape.hexagon;
      default:
        return NotationShape.circle;
    }
  }
}

// DIRECTIONS
enum Direction { up, down, left, right, upLeft, upRight, downLeft, downRight }

extension DirectionExt on Direction {
  String get stringValue {
    switch (this) {
      case Direction.up:
        return 'up';
      case Direction.down:
        return 'down';
      case Direction.left:
        return 'left';
      case Direction.right:
        return 'right';
      case Direction.upLeft:
        return 'upLeft';
      case Direction.upRight:
        return 'upRight';
      case Direction.downLeft:
        return 'downLeft';
      case Direction.downRight:
        return 'downRight';
    }
  }

  static Direction fromString(String value) {
    switch (value.toLowerCase()) {
      case 'up':
        return Direction.up;
      case 'down':
        return Direction.down;
      case 'left':
        return Direction.left;
      case 'right':
        return Direction.right;
      case 'upleft':
        return Direction.upLeft;
      case 'upright':
        return Direction.upRight;
      case 'downleft':
        return Direction.downLeft;
      case 'downright':
        return Direction.downRight;
      default:
        return Direction.up;
    }
  }
}

// GUIDE TYPES
enum GuideType { line, zone, ribbon, bands, circle, rectangle }

extension GuideTypeExt on GuideType {
  String get stringValue {
    switch (this) {
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

  static GuideType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'line':
        return GuideType.line;
      case 'zone':
        return GuideType.zone;
      case 'ribbon':
        return GuideType.ribbon;
      case 'bands':
        return GuideType.bands;
      case 'circle':
        return GuideType.circle;
      case 'rectangle':
        return GuideType.rectangle;
      default:
        return GuideType.line;
    }
  }
}

// AXIS TYPES
enum AxisType { x, y, xy }

extension AxisTypeExt on AxisType {
  String get stringValue {
    switch (this) {
      case AxisType.x:
        return 'x';
      case AxisType.y:
        return 'y';
      case AxisType.xy:
        return 'xy';
    }
  }

  static AxisType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'x':
        return AxisType.x;
      case 'y':
        return AxisType.y;
      case 'xy':
        return AxisType.xy;
      default:
        return AxisType.x;
    }
  }
}

// STROKE STYLES
enum StrokeStyle { solid, dashed, dotted, dashedDot }

extension StrokeStyleExt on StrokeStyle {
  String get stringValue {
    switch (this) {
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

  static StrokeStyle fromString(String value) {
    switch (value.toLowerCase()) {
      case 'solid':
        return StrokeStyle.solid;
      case 'dashed':
        return StrokeStyle.dashed;
      case 'dotted':
        return StrokeStyle.dotted;
      case 'dasheddot':
        return StrokeStyle.dashedDot;
      default:
        return StrokeStyle.solid;
    }
  }
}

// ===========================================================================
// MODEL CLASSES
// ===========================================================================

// INPUT MODEL
class Input {
  final String key;
  final ValueType valueType;
  final dynamic value;
  final num? min;
  final num? max;
  final String label;
  final bool showInLegend;

  Input({
    required this.key,
    required this.valueType,
    required this.value,
    this.min,
    this.max,
    required this.label,
    this.showInLegend = false,
  });

  factory Input.fromJson(Map<String, dynamic> json) {
    return Input(
      key: json['key'] as String,
      valueType: ValueTypeExt.fromString(json['valueType'] as String),
      value: json['value'],
      min: json['min'] as num?,
      max: json['max'] as num?,
      label: json['label'] as String? ?? '',
      showInLegend: json['showInLegend'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'valueType': valueType.stringValue,
      'value': value,
      'min': min,
      'max': max,
      'label': label,
      'showInLegend': showInLegend,
    };
  }
}

// FIELD MODEL
// Inherits: format field only if valueType is timestamp
class Field {
  final AxisType axis;
  final String key;
  final String name;
  final ValueType valueType;
  final TimeFormat? format; // ONLY if valueType == timestamp
  final bool showInLegend;

  Field({
    required this.axis,
    required this.key,
    required this.name,
    required this.valueType,
    this.format,
    this.showInLegend = false,
  }) : assert(
         valueType != ValueType.timestamp || format != null,
         'format is required when valueType is timestamp',
       );

  factory Field.fromJson(Map<String, dynamic> json) {
    final valueType = ValueTypeExt.fromString(json['valueType'] as String);

    // Only parse format if valueType is timestamp
    TimeFormat? format;
    if (valueType == ValueType.timestamp) {
      format = TimeFormatExt.fromString(
        json['format'] as String? ?? 'milliseconds',
      );
    }

    return Field(
      axis: AxisTypeExt.fromString(json['axis'] as String),
      key: json['key'] as String,
      name: json['name'] as String,
      valueType: valueType,
      format: format,
      showInLegend: json['showInLegend'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'axis': axis.stringValue,
      'key': key,
      'name': name,
      'valueType': valueType.stringValue,
      if (format != null) 'format': format!.stringValue,
      'showInLegend': showInLegend,
    };
  }

  /// Gets formatted value based on field type and format
  String formatValue(dynamic value) {
    if (valueType == ValueType.timestamp && format != null && value is int) {
      return format!.formatValue(value);
    }
    return value.toString();
  }
}

// PLOT CONDITION MODEL
class PlotCondition {
  final Map<String, dynamic> value1;
  final ConditionOperator operator;
  final Map<String, dynamic> value2;
  final Map<String, dynamic> result;

  PlotCondition({
    required this.value1,
    required this.operator,
    required this.value2,
    required this.result,
  });

  factory PlotCondition.fromJson(Map<String, dynamic> json) {
    return PlotCondition(
      value1: json['value1'] as Map<String, dynamic>,
      operator: ConditionOperator.fromString(json['operator'] as String),
      value2: json['value2'] as Map<String, dynamic>,
      result: json['result'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value1': value1,
      'operator': operator.symbol,
      'value2': value2,
      'result': result,
    };
  }

  /// Evaluates condition against data
  bool evaluate(dynamic val1, dynamic val2) {
    if (val1 is! num || val2 is! num) return false;
    return operator.evaluate(val1, val2);
  }
}

// PLOT MODEL
// Inherits: type-specific fields based on plotType
class Plot {
  final PlotType plotType;
  final String? fieldKey; // For line, bar, area, histogram
  final String? categoryFieldKey; // For pie (labels)
  final String? sizeFieldKey; // For bubble (size)
  final String? color; // Default color
  final String? upColor; // For candlestick
  final String? downColor; // For candlestick
  final String? fieldKeyOpen; // For candlestick
  final String? fieldKeyHigh; // For candlestick
  final String? fieldKeyLow; // For candlestick
  final String? fieldKeyClose; // For candlestick
  final List<PlotCondition>? conditions;

  Plot({
    required this.plotType,
    this.fieldKey,
    this.categoryFieldKey,
    this.sizeFieldKey,
    this.color,
    this.upColor,
    this.downColor,
    this.fieldKeyOpen,
    this.fieldKeyHigh,
    this.fieldKeyLow,
    this.fieldKeyClose,
    this.conditions,
  });

  factory Plot.fromJson(Map<String, dynamic> json) {
    final plotType = PlotTypeExt.fromString(json['plotType'] as String);
    return Plot(
      plotType: plotType,
      fieldKey: json['fieldKey'] as String?,
      categoryFieldKey: json['categoryFieldKey'] as String?,
      sizeFieldKey: json['sizeFieldKey'] as String?,
      color: json['color'] as String?,
      upColor: json['upColor'] as String?,
      downColor: json['downColor'] as String?,
      fieldKeyOpen: json['fieldKeyOpen'] as String?,
      fieldKeyHigh: json['fieldKeyHigh'] as String?,
      fieldKeyLow: json['fieldKeyLow'] as String?,
      fieldKeyClose: json['fieldKeyClose'] as String?,
      conditions: json['conditions'] != null
          ? (json['conditions'] as List)
                .map((c) => PlotCondition.fromJson(c as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plotType': plotType.stringValue,
      if (fieldKey != null) 'fieldKey': fieldKey,
      if (categoryFieldKey != null) 'categoryFieldKey': categoryFieldKey,
      if (sizeFieldKey != null) 'sizeFieldKey': sizeFieldKey,
      if (color != null) 'color': color,
      if (upColor != null) 'upColor': upColor,
      if (downColor != null) 'downColor': downColor,
      if (fieldKeyOpen != null) 'fieldKeyOpen': fieldKeyOpen,
      if (fieldKeyHigh != null) 'fieldKeyHigh': fieldKeyHigh,
      if (fieldKeyLow != null) 'fieldKeyLow': fieldKeyLow,
      if (fieldKeyClose != null) 'fieldKeyClose': fieldKeyClose,
      if (conditions != null)
        'conditions': conditions!.map((c) => c.toJson()).toList(),
    };
  }

  /// Gets allowed transformations for this plot type
  List<String> getTransformations() => plotType.getTransforms();
}

// NOTATION MODEL
class Notation {
  final NotationShape shape;
  final String label;
  final List<int> dataIndices;
  final String? color;
  final Direction direction;

  Notation({
    required this.shape,
    required this.label,
    required this.dataIndices,
    this.color,
    required this.direction,
  });

  factory Notation.fromJson(Map<String, dynamic> json) {
    return Notation(
      shape: NotationShapeExt.fromString(json['shape'] as String),
      label: json['label'] as String,
      dataIndices: List<int>.from(json['dataIndices'] as List),
      color: json['color'] as String?,
      direction: DirectionExt.fromString(json['direction'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shape': shape.stringValue,
      'label': label,
      'dataIndices': dataIndices,
      if (color != null) 'color': color,
      'direction': direction.stringValue,
    };
  }

  /// Check if notation should be shown at given data index
  bool shouldShowAt(int index) => dataIndices.contains(index);
}

// GUIDE MODEL
// Inherits: type-specific fields based on guideType
class Guide {
  final GuideType guideType;
  final AxisType axis;
  final num? value; // For line guide
  final num? start; // For zone guide
  final num? end; // For zone guide
  final String? label;
  final String? color;
  final StrokeStyle? strokeStyle;
  final num? centerX; // For circle guide
  final num? centerY; // For circle guide
  final num? radius; // For circle guide

  Guide({
    required this.guideType,
    required this.axis,
    this.value,
    this.start,
    this.end,
    this.label,
    this.color,
    this.strokeStyle,
    this.centerX,
    this.centerY,
    this.radius,
  });

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      guideType: GuideTypeExt.fromString(json['guideType'] as String),
      axis: AxisTypeExt.fromString(json['axis'] as String),
      value: json['value'] as num?,
      start: json['start'] as num?,
      end: json['end'] as num?,
      label: json['label'] as String?,
      color: json['color'] as String?,
      strokeStyle: json['strokeStyle'] != null
          ? StrokeStyleExt.fromString(json['strokeStyle'] as String)
          : null,
      centerX: json['centerX'] as num?,
      centerY: json['centerY'] as num?,
      radius: json['radius'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guideType': guideType.stringValue,
      'axis': axis.stringValue,
      if (value != null) 'value': value,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (label != null) 'label': label,
      if (color != null) 'color': color,
      if (strokeStyle != null) 'strokeStyle': strokeStyle!.stringValue,
      if (centerX != null) 'centerX': centerX,
      if (centerY != null) 'centerY': centerY,
      if (radius != null) 'radius': radius,
    };
  }
}

// INDICATOR (MAIN) MODEL
class Indicator {
  final Map<String, dynamic> metadata;
  final List<Input> inputs;
  final List<Field> fields;
  final List<List<dynamic>> data;
  final List<Plot> plots;
  final List<Notation>? notations;
  final List<Guide>? guides;

  Indicator({
    required this.metadata,
    required this.inputs,
    required this.fields,
    required this.data,
    required this.plots,
    this.notations,
    this.guides,
  });

  factory Indicator.fromJson(Map<String, dynamic> json) {
    return Indicator(
      metadata: json['metadata'] as Map<String, dynamic>,
      inputs:
          (json['inputs'] as List?)
              ?.map((i) => Input.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      fields: (json['fields'] as List)
          .map((f) => Field.fromJson(f as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List)
          .map((d) => List<dynamic>.from(d as List))
          .toList(),
      plots: (json['plots'] as List)
          .map((p) => Plot.fromJson(p as Map<String, dynamic>))
          .toList(),
      notations: json['notations'] != null
          ? (json['notations'] as List)
                .map((n) => Notation.fromJson(n as Map<String, dynamic>))
                .toList()
          : null,
      guides: json['guides'] != null
          ? (json['guides'] as List)
                .map((g) => Guide.fromJson(g as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata,
      'inputs': inputs.map((i) => i.toJson()).toList(),
      'fields': fields.map((f) => f.toJson()).toList(),
      'data': data,
      'plots': plots.map((p) => p.toJson()).toList(),
      if (notations != null)
        'notations': notations!.map((n) => n.toJson()).toList(),
      if (guides != null) 'guides': guides!.map((g) => g.toJson()).toList(),
    };
  }

  /// Get field by key
  Field? getFieldByKey(String key) {
    try {
      return fields.firstWhere((f) => f.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get field value from data row
  dynamic getFieldValue(int rowIndex, String fieldKey) {
    final field = getFieldByKey(fieldKey);
    if (field == null || rowIndex >= data.length) return null;

    final fieldIndex = fields.indexWhere((f) => f.key == fieldKey);
    if (fieldIndex == -1) return null;

    return data[rowIndex][fieldIndex];
  }

  /// Get input by key
  Input? getInputByKey(String key) {
    try {
      return inputs.firstWhere((i) => i.key == key);
    } catch (e) {
      return null;
    }
  }

  /// Get indicator metadata properties
  String get id => metadata['id'] ?? '';
  String get name => metadata['name'] ?? '';
  String get shortName => metadata['short_name'] ?? '';
  String get description => metadata['description'] ?? '';
  String get category => metadata['category'] ?? '';
  String get author => metadata['author'] ?? '';
  String get version => metadata['version'] ?? '1.0.0';
  int? get createdAt => metadata['createdAt'] as int?;
}

// ===========================================================================
// UTILITY CLASSES
// ===========================================================================

class PlotTypeTransformations {
  static const Map<String, List<String>> transformations = {
    'line': ['line', 'area', 'bar'],
    'bar': ['bar', 'area', 'line'],
    'area': ['area', 'line', 'bar'],
    'candlestick': ['candlestick', 'line', 'bar'],
    'pie': ['pie', 'donut'],
    'histogram': ['histogram', 'bar', 'area'],
    'map': ['map', 'heatmap'],
  };

  /// Check if transformation is valid for given plot type
  static bool isValidTransformation(String fromType, String toType) {
    final validTypes = transformations[fromType];
    return validTypes != null && validTypes.contains(toType);
  }

  /// Get allowed transformations for plot type
  static List<String> getAllowedTransformations(String plotType) {
    return transformations[plotType] ?? [];
  }
}
