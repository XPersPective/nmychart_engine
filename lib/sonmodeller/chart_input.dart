import '../models/enums/enums.dart';

enum InputType { integer, double, string, symbol, interval }

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
  InputType get type;

  /// Factory constructor for polymorphic JSON deserialization
  static ChartInput fromJson(Map<String, dynamic> json) {
    final type = InputType.values.byName(json['type'] as String);
    final name = json['name'] as String;
    final key = json['key'] as String;
    final value = json['value'];
    final showInLegendType = ShowInLegendType.values.byName(
      json['showInLegendType'] as String,
    );

    switch (type) {
      case InputType.integer:
        return IntegerInput(
          name: name,
          key: key,
          value: value as int,
          min: json['min'] as int,
          max: json['max'] as int,
          showInLegendType: showInLegendType,
        );
      case InputType.double:
        return DoubleInput(
          name: name,
          key: key,
          value: value as double,
          min: json['min'] as double,
          max: json['max'] as double,
          showInLegendType: showInLegendType,
        );
      case InputType.string:
        return StringInput(
          name: name,
          key: key,
          value: value as String,
          showInLegendType: showInLegendType,
        );
      case InputType.symbol:
        return SymbolInput(
          name: name,
          key: key,
          base: json['base'] as String,
          quote: json['quote'] as String,
          showInLegendType: showInLegendType,
        );
      case InputType.interval:
        return IntervalInput(
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
    'type': type.name,
    'showInLegendType': showInLegendType.name,
  };
}

class IntegerInput extends ChartInput {
  final int value;
  final int min;
  final int max;

  IntegerInput({
    required super.name,
    required super.key,
    required this.value,
    required this.min,
    required this.max,
    super.showInLegendType,
  });

  @override
  InputType get type => InputType.integer;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'value': value,
    'min': min,
    'max': max,
  };
}

class DoubleInput extends ChartInput {
  final double value;
  final double min;
  final double max;

  DoubleInput({
    required super.name,
    required super.key,
    required this.value,
    required this.min,
    required this.max,
    super.showInLegendType,
  });

  @override
  InputType get type => InputType.double;

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    'value': value,
    'min': min,
    'max': max,
  };
}

class StringInput extends ChartInput {
  final String value;

  StringInput({
    required super.name,
    required super.key,
    required this.value,
    super.showInLegendType,
  });

  @override
  InputType get type => InputType.string;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};
}

class SymbolInput extends ChartInput {
  final String base;
  final String quote;

  SymbolInput({
    required super.name,
    required super.key,
    required this.base,
    required this.quote,
    super.showInLegendType,
  });

  /// Tam sembol: BTC/USDT
  String get symbol => '$base/$quote';

  @override
  InputType get type => InputType.symbol;

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
    required super.name,
    required super.key,
    required this.value,
    super.showInLegendType,
  });

  @override
  InputType get type => InputType.interval;

  @override
  Map<String, dynamic> toJson() => {...super.toJson(), 'value': value};
}
