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
