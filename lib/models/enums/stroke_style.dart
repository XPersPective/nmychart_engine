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
