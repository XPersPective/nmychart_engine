/// Data Source Model
/// Describes the source and characteristics of the data
class ChartDataSource {
  final String
  type; // financial, weather, business, inventory, analytics, analysis, demographics, webAnalytics

  // Financial specific
  final String? pair;
  final String? exchange;
  final String? interval;
  final String? dateFormat;

  // Weather specific
  final String? location;
  final String? unit;

  // Business specific
  final String? dataType;
  final String? currency;

  // Analytics specific
  final String? source;

  // Analysis specific
  final String? datasetName;

  // Demographics specific
  final String? dataset;

  ChartDataSource({
    required this.type,
    this.pair,
    this.exchange,
    this.interval,
    this.dateFormat,
    this.location,
    this.unit,
    this.dataType,
    this.currency,
    this.source,
    this.datasetName,
    this.dataset,
  });

  /// Create from JSON
  factory ChartDataSource.fromJson(Map<String, dynamic> json) {
    return ChartDataSource(
      type: json['type'] as String? ?? 'analytics',
      pair: json['pair'] as String?,
      exchange: json['exchange'] as String?,
      interval: json['interval'] as String?,
      dateFormat: json['dateFormat'] as String?,
      location: json['location'] as String?,
      unit: json['unit'] as String?,
      dataType: json['dataType'] as String?,
      currency: json['currency'] as String?,
      source: json['source'] as String?,
      datasetName: json['datasetName'] as String?,
      dataset: json['dataset'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'type': type};

    if (pair != null) json['pair'] = pair;
    if (exchange != null) json['exchange'] = exchange;
    if (interval != null) json['interval'] = interval;
    if (dateFormat != null) json['dateFormat'] = dateFormat;
    if (location != null) json['location'] = location;
    if (unit != null) json['unit'] = unit;
    if (dataType != null) json['dataType'] = dataType;
    if (currency != null) json['currency'] = currency;
    if (source != null) json['source'] = source;
    if (datasetName != null) json['datasetName'] = datasetName;
    if (dataset != null) json['dataset'] = dataset;

    return json;
  }
}
