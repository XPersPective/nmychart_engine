/// Metadata model for chart configuration and information
class ChartMetadata {
  final String id;
  final String name;
  final String? shortName;
  final String description;
  final String version;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? type; // Örn: financial, business, weather
  final String? subType; // Örn: price, indicator, sales, temperature

  ChartMetadata({
    required this.id,
    required this.name,
    this.shortName,
    required this.description,
    required this.version,
    required this.createdAt,
    this.updatedAt,
    this.type,
    this.subType,
  });

  /// Create from JSON
  factory ChartMetadata.fromJson(Map<String, dynamic> json) {
    return ChartMetadata(
      id:
          json['id'] as String? ??
          'chart_${DateTime.now().millisecondsSinceEpoch}',
      name: json['name'] as String? ?? 'Chart',
      shortName: json['shortName'] as String?,
      description: json['description'] as String? ?? '',
      version: json['version'] as String? ?? '1.0.0',
      createdAt: json['createdAt'] != null
          ? _parseDateTime(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? _parseDateTime(json['updatedAt'])
          : null,
      type: json['type'] as String?,
      subType: json['subType'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (shortName != null) 'shortName': shortName,
    'description': description,
    'version': version,
    'createdAt': createdAt.toIso8601String(),
    if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    if (type != null) 'type': type,
    if (subType != null) 'subType': subType,
  };

  static DateTime _parseDateTime(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }
}
