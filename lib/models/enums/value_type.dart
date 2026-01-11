enum ValueType { integer, double, string, timestamp, symbol, interval }

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
      case ValueType.symbol:
        return 'symbol';
      case ValueType.interval:
        return 'interval';
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
      case 'symbol':
        return ValueType.symbol;
      case 'interval':
        return ValueType.interval;
      default:
        return ValueType.string;
    }
  }
}
