import 'chart.dart';

/// Chart Collection Model
/// Top-level container for multiple charts.
/// Used for complex financial dashboards with multiple chart types.
///
/// Example:
/// - Main chart: Candlestick price chart (BTC/USDT)
///   - Overlay 1: SMA indicator
///   - Overlay 2: EMA indicator
/// - Panel chart: MACD indicator
/// - Panel chart: Volume
class ChartCollection {
  final List<Chart> charts;

  ChartCollection({required this.charts});

  /// Create ChartCollection from JSON
  factory ChartCollection.fromJson(Map<String, dynamic> json) {
    final chartsJson =
        (json['charts'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final charts = chartsJson.map((c) => Chart.fromJson(c)).toList();

    return ChartCollection(charts: charts);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'charts': charts.map((c) => c.toJson()).toList(),
  };

  /// Get chart by index
  Chart? getChart(int index) =>
      index >= 0 && index < charts.length ? charts[index] : null;

  /// Get main price chart (subType == "price")
  Chart? getMainPriceChart() {
    try {
      return charts.firstWhere(
        (c) => c.metadata.subType?.toLowerCase() == 'price',
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all panel charts (subType == "indicator")
  List<Chart> getPanelCharts() {
    return charts
        .where((c) => c.metadata.subType?.toLowerCase() == 'indicator')
        .toList();
  }

  /// Get all overlays from main chart
  List<Overlay> getMainChartOverlays() {
    final mainChart = getMainPriceChart();
    return mainChart?.overlays ?? [];
  }
}
