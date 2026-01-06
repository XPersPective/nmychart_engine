/// Metadata model for chart configuration and information
class ChartMetadata {
  final String id;
  final String name;
  final String description;
  final String version;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ChartMetadata({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.createdAt,
    this.updatedAt,
  });

  /// Create from JSON
  factory ChartMetadata.fromJson(Map<String, dynamic> json) {
    return ChartMetadata(
      id:
          json['id'] as String? ??
          'chart_${DateTime.now().millisecondsSinceEpoch}',
      name: json['name'] as String? ?? 'Chart',
      description: json['description'] as String? ?? '',
      version: json['version'] as String? ?? '1.0.0',
      createdAt: json['createdAt'] != null
          ? _parseDateTime(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? _parseDateTime(json['updatedAt'])
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'version': version,
    'createdAt': createdAt.toIso8601String(),
    if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
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
