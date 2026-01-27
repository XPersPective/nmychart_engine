import 'utils.dart';

/// Metadata model for chart configuration and information
class ChartMetadata {
  final String id;
  final String name;
  final String shortName;
  final String description;
  final String version;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String type;
  final String subType;

  const ChartMetadata({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.subType,
  });

  /// Create from JSON
  factory ChartMetadata.fromJson(Map<String, dynamic> json) {
    return ChartMetadata(
      id: json['id'] as String,
      name: json['name'] as String,
      shortName: json['shortName'] as String,
      description: json['description'] as String,
      version: json['version'] as String,
      createdAt: Utils.parseDateTime(json['createdAt']),
      updatedAt: Utils.parseDateTime(json['updatedAt']),
      type: json['type'] as String,
      subType: json['subType'] as String,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'shortName': shortName,
    'description': description,
    'version': version,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'type': type,
    'subType': subType,
  };
}
