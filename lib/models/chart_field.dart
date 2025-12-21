/// Grafik alanı tanımı
class ChartField {
  final String axis;
  final int index;
  final String key;
  final String name;
  final ChartFieldType type;
  final String? format;

  ChartField({
    required this.axis,
    required this.index,
    required this.key,
    required this.name,
    required this.type,
    this.format,
  });

  factory ChartField.fromJson(Map<String, dynamic> json) {
    return ChartField(
      axis: json['axis'] ?? 'y',
      index: json['index'] ?? 0,
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      type: ChartFieldTypeExtension.fromString(json['type'] ?? 'number'),
      format: json['format'],
    );
  }
}

/// Alan tipi
enum ChartFieldType { time, number, string, boolean }

extension ChartFieldTypeExtension on ChartFieldType {
  static ChartFieldType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'time':
        return ChartFieldType.time;
      case 'string':
        return ChartFieldType.string;
      case 'boolean':
        return ChartFieldType.boolean;
      default:
        return ChartFieldType.number;
    }
  }
}
