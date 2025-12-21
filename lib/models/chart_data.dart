import 'chart_field.dart';
import 'chart_plot.dart';
import '../utils/extensions.dart';

/// Ana grafik veri modeli - JSON'dan parse edilecek
class ChartData {
  final String id;
  final String name;
  final String shortName;
  final String description;
  final String category;
  final String author;
  final String version;
  final List<ChartField> fields;
  final List<List<dynamic>> data;
  final List<ChartPlot> plots;

  ChartData({
    required this.id,
    required this.name,
    required this.shortName,
    required this.description,
    required this.category,
    required this.author,
    required this.version,
    required this.fields,
    required this.data,
    required this.plots,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      id: json['id'] ?? 'unknown',
      name: json['name'] ?? '',
      shortName: json['short_name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      author: json['author'] ?? '',
      version: json['version'] ?? '1.0.0',
      fields: (json['fields'] as List? ?? [])
          .map((e) => ChartField.fromJson(e))
          .toList(),
      data: (json['data'] as List? ?? []).cast<List<dynamic>>(),
      plots: (json['plots'] as List? ?? [])
          .map((e) => ChartPlot.fromJson(e))
          .toList(),
    );
  }

  /// Zaman alanını bul
  ChartField? get timeField =>
      fields.firstWhereOrNull((f) => f.type == ChartFieldType.time);
}
