import 'enums/enums.dart';

/// Base Chart Input Model
/// Abstract class for all input types
abstract class ChartInput {
  final String name;
  final String key;
  final ShowInLegendType showInLegendType;

  ChartInput({
    required this.name,
    required this.key,
    this.showInLegendType = ShowInLegendType.nameAndValue,
  });

  /// Get the value type for this input
  ValueType get valueType;

  /// Factory constructor for polymorphic JSON deserialization
  static ChartInput fromJson(Map<String, dynamic> json) {
    final valueTypeStr = json['valueType'] as String;
    final name = json['name'] as String;
    final key = json['key'] as String;
    final value = json['value'];
    final showInLegendType = _parseShowInLegendType(
      json['showInLegendType'] as String? ?? 'nameAndValue',
    );

    switch (valueTypeStr.toLowerCase()) {
      case 'integer':
        return IntegerInput(
          name: name,
          key: key,
          value: value as int,
          min: json['min'] as int?,
          max: json['max'] as int?,
          showInLegendType: showInLegendType,
        );
      case 'double':
        return DoubleInput(
          name: name,
          key: key,
          value: value as double,
          min: json['min'] as double?,
          max: json['max'] as double?,
          showInLegendType: showInLegendType,
        );
      case 'string':
        return StringInput(
          name: name,
          key: key,
          value: value as String,
          showInLegendType: showInLegendType,
        );
      case 'symbol':
        return SymbolInput(
          name: name,
          key: key,
          base: json['base'] as String,
          quote: json['quote'] as String,
          showInLegendType: showInLegendType,
        );
      case 'interval':
        return IntervalInput(
          name: name,
          key: key,
          value: value as String,
          showInLegendType: showInLegendType,
        );
      default:
        return StringInput(
          name: name,
          key: key,
          value: value as String,
          showInLegendType: showInLegendType,
        );
    }
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'key': key,
    'valueType': valueType.toString().split('.').last,
    'showInLegendType': _showInLegendTypeToString(showInLegendType),
  };

  static ShowInLegendType _parseShowInLegendType(String typeStr) {
    switch (typeStr.toLowerCase()) {
      case 'hidden':
        return ShowInLegendType.hidden;
      case 'onlyvalue':
        return ShowInLegendType.onlyValue;
      case 'nameandvalue':
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

/// Integer Input (with int min/max)
class IntegerInput extends ChartInput {
  final int value;
  final int? min;
  final int? max;

  IntegerInput({
    required String name,
    required String key,
    required this.value,
    this.min,
    this.max,
    ShowInLegendType showInLegendType = ShowInLegendType.nameAndValue,
  }) : super(name: name, key: key, showInLegendType: showInLegendType);

  @override
  ValueType get valueType => ValueType.integer;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'value': value,
    if (min != null) 'min': min,
    if (max != null) 'max': max,
  };
}

/// Double Input (with double min/max)
class DoubleInput extends ChartInput {
  final double value;
  final double? min;
  final double? max;

  DoubleInput({
    required String name,
    required String key,
    required this.value,
    this.min,
    this.max,
    ShowInLegendType showInLegendType = ShowInLegendType.nameAndValue,
  }) : super(name: name, key: key, showInLegendType: showInLegendType);

  @override
  ValueType get valueType => ValueType.double;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'value': value,
    if (min != null) 'min': min,
    if (max != null) 'max': max,
  };
}

/// String Input (no min/max)
class StringInput extends ChartInput {
  final String value;

  StringInput({
    required String name,
    required String key,
    required this.value,
    ShowInLegendType showInLegendType = ShowInLegendType.nameAndValue,
  }) : super(name: name, key: key, showInLegendType: showInLegendType);

  @override
  ValueType get valueType => ValueType.string;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};
}

/// Symbol Input (finansal çiftler: BTC/USDT)
/// Base ve Quote ayrı tutulur
class SymbolInput extends ChartInput {
  final String base;
  final String quote;

  SymbolInput({
    required String name,
    required String key,
    required this.base,
    required this.quote,
    ShowInLegendType showInLegendType = ShowInLegendType.nameAndValue,
  }) : super(name: name, key: key, showInLegendType: showInLegendType);

  /// Tam sembol: BTC/USDT
  String get symbol => '$base/$quote';

  @override
  ValueType get valueType => ValueType.symbol;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'value': symbol,
    'base': base,
    'quote': quote,
  };
}

/// Interval Input (finansal zaman aralıkları)
class IntervalInput extends ChartInput {
  final String value;

  IntervalInput({
    required String name,
    required String key,
    required this.value,
    ShowInLegendType showInLegendType = ShowInLegendType.nameAndValue,
  }) : super(name: name, key: key, showInLegendType: showInLegendType);

  @override
  ValueType get valueType => ValueType.interval;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};
}
