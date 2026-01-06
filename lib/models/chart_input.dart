import 'enums/enums.dart';

/// Chart Input Model
/// Parameters/inputs for chart configuration
class ChartInput {
  final String key;
  final ValueType valueType;
  final dynamic value;
  final dynamic min;
  final dynamic max;
  final String label;
  final bool showInLegend;

  ChartInput({
    required this.key,
    required this.valueType,
    required this.value,
    this.min,
    this.max,
    required this.label,
    this.showInLegend = true,
  });

  /// Create from JSON
  factory ChartInput.fromJson(Map<String, dynamic> json) {
    return ChartInput(
      key: json['key'] as String? ?? '',
      valueType: _parseValueType(json['valueType'] as String? ?? 'string'),
      value: json['value'],
      min: json['min'],
      max: json['max'],
      label: json['label'] as String? ?? '',
      showInLegend: json['showInLegend'] as bool? ?? true,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'key': key,
    'valueType': _valueTypeToString(valueType),
    'value': value,
    if (min != null) 'min': min,
    if (max != null) 'max': max,
    'label': label,
    'showInLegend': showInLegend,
  };

  static ValueType _parseValueType(String typeStr) {
    switch (typeStr.toLowerCase()) {
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

  static String _valueTypeToString(ValueType type) {
    switch (type) {
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
}
