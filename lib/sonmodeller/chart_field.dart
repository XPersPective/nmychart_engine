import '../models/enums/enums.dart';

enum FieldType { integer, double, string, timestamp }

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
  FieldType get type;

  /// Factory constructor for polymorphic JSON deserialization
  static ChartField fromJson(Map<String, dynamic> json) {
    final type = FieldType.values.byName(json['type'] as String);
    final name = json['name'] as String;
    final key = json['key'] as String;
    final axis = json['axis'] as String;
    final showInLegendType = ShowInLegendType.values.byName(
      json['showInLegendType'] as String,
    );

    switch (type) {
      case FieldType.integer:
        return IntegerField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case FieldType.double:
        return DoubleField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case FieldType.string:
        return StringField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
        );
      case FieldType.timestamp:
        return TimestampField(
          name: name,
          key: key,
          axis: axis,
          showInLegendType: showInLegendType,
          format: json['format'] as String,
        );
      }
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'key': key,
    'type': type.name,
    'axis': axis, 
    'showInLegendType': showInLegendType.name,
  };
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
  FieldType get type => FieldType.integer;
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
  FieldType get type => FieldType.double;
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
  FieldType get type => FieldType.string;
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
  FieldType get type => FieldType.timestamp;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'format': format};
}
