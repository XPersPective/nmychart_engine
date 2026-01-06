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
