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
