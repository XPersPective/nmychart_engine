enum PlotType { line, bar, area, candlestick, pie, histogram }

extension PlotTypeExt on PlotType {
  String get stringValue {
    switch (this) {
      case PlotType.line:
        return 'line';
      case PlotType.bar:
        return 'bar';
      case PlotType.area:
        return 'area';
      case PlotType.candlestick:
        return 'candlestick';
      case PlotType.pie:
        return 'pie';
      case PlotType.histogram:
        return 'histogram';
    }
  }

  /// Whether this plot type is rendered as main chart (shows grid)
  bool get isMainChart {
    return this == PlotType.line ||
        this == PlotType.bar ||
        this == PlotType.area ||
        this == PlotType.candlestick;
  }

  /// Whether this plot type is rendered as panel (shows grid)
  bool get isPanel {
    return this == PlotType.histogram;
  }

  /// Whether this plot type is rendered as overlay (hides grid)
  bool get isOverlay {
    return false; // Overlays are determined at chart level, not plot level
  }

  static PlotType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'line':
        return PlotType.line;
      case 'bar':
        return PlotType.bar;
      case 'area':
        return PlotType.area;
      case 'candlestick':
        return PlotType.candlestick;
      case 'pie':
        return PlotType.pie;
      case 'histogram':
        return PlotType.histogram;
      default:
        return PlotType.line;
    }
  }

  /// Returns applicable transformation types for this plot type
  List<String> getTransforms() {
    switch (this) {
      case PlotType.line:
        return ['line', 'area', 'bar'];
      case PlotType.bar:
        return ['bar', 'area', 'line'];
      case PlotType.area:
        return ['area', 'line', 'bar'];
      case PlotType.candlestick:
        return ['candlestick', 'line', 'bar'];
      case PlotType.pie:
        return ['pie', 'donut'];
      case PlotType.histogram:
        return ['histogram', 'bar', 'area'];
    }
  }
}
