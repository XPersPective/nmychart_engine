import 'enums/enums.dart';

/// Base Chart Field Model
/// Abstract class for all field types
abstract class ChartField {
  final String name;
  final String key;
  final String axis;
  final ShowInLegendType showInLegendType;

  ChartField({
    required this.name,
    required this.key,
    required this.axis,
    this.showInLegendType = ShowInLegendType.nameAndValue,
  });

  /// Get the value type for this field
  ValueType get valueType;

  /// Factory constructor for polymorphic JSON deserialization
  static ChartField fromJson(Map<String, dynamic> json) {
    final valueTypeStr = json['valueType'] as String;
    final name = json['name'] as String;
    final key = json['key'] as String;
    final axis = json['axis'] as String;
    final showInLegendType = _parseShowInLegendType(
      json['showInLegendType'] as String,
    );

    switch (valueTypeStr.toLowerCase()) {
      case 'integer':
        return IntegerField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case 'double':
        return DoubleField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case 'string':
        return StringField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case 'timestamp':
        return TimestampField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
          format: json['format'] as String,
        );
      default:
        return StringField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
    }
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'key': key,
    'valueType': valueType.toString().split('.').last,
    'axis': axis,
    'showInLegendType': _showInLegendTypeToString(showInLegendType),
  };

  static ShowInLegendType _parseShowInLegendType(String typeStr) {
    switch (typeStr.toLowerCase()) {
      case 'hidden':
        return ShowInLegendType.hidden;
      case 'onlyValue':
        return ShowInLegendType.onlyValue;
      case 'nameAndValue':
        return ShowInLegendType.nameAndValue;
      default:
        return ShowInLegendType.nameAndValue;
    }
  }

  static String _showInLegendTypeToString(ShowInLegendType type) {
    switch (type) {
      case ShowInLegendType.hidden:
        return 'hidden';
      case ShowInLegendType.onlyValue:
        return 'onlyValue';
      case ShowInLegendType.nameAndValue:
        return 'nameAndValue';
    }
  }
}

/// Integer Field
class IntegerField extends ChartField {
  IntegerField({
    required super.name,
    required super.key,
    required super.axis,
    super.showInLegendType,
  });

  @override
  ValueType get valueType => ValueType.integer;
}

/// Double Field
class DoubleField extends ChartField {
  DoubleField({
    required super.name,
    required super.key,
    required super.axis,
    super.showInLegendType,
  });

  @override
  ValueType get valueType => ValueType.double;
}

/// String Field
class StringField extends ChartField {
  StringField({
    required super.name,
    required super.key,
    required super.axis,
    super.showInLegendType,
  });

  @override
  ValueType get valueType => ValueType.string;
}

/// Timestamp Field (requires format)
class TimestampField extends ChartField {
  final String format;

  TimestampField({
    required super.name,
    required super.key,
    required super.axis,
    required this.format,
    super.showInLegendType,
  });

  @override
  ValueType get valueType => ValueType.timestamp;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'format': format};
}
