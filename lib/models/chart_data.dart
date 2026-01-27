import '../sonmodeller/plots/plots.dart';
import '../sonmodeller/chart_field.dart';
import 'chart_metadata.dart';
import 'chart_data_source.dart';
import '../sonmodeller/chart_input.dart';
import 'chart_notation.dart';
import 'chart_guide.dart';

/// Chart Data Model
/// Container for chart configuration and data
class ChartData {
  final ChartMetadata metadata;
  final List<ChartInput> inputs;
  final List<ChartField> fields;
  final List<Plot> plots;
  final List<List<dynamic>> data;
  final ChartDataSource dataSource;
  final List<ChartNotation> notations;
  final List<ChartGuide> guides;

  ChartData({
    required this.plots,
    required this.data,
    required this.metadata,
    required this.dataSource,
    this.fields = const [],
    this.inputs = const [],
    this.notations = const [],
    this.guides = const [],
  });

  /// Create ChartData from JSON
  factory ChartData.fromJson(Map<String, dynamic> json) {
    final plotsJson =
        (json['plots'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final plots = plotsJson.map((p) => Plot.fromJson(p)).toList();

    final dataJson = (json['data'] as List?)?.cast<List<dynamic>>() ?? [];

    final fieldsJson =
        (json['fields'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final fields = fieldsJson.map((f) => ChartField.fromJson(f)).toList();

    final metadataJson = json['metadata'] as Map<String, dynamic>? ?? {};
    final metadata = ChartMetadata.fromJson(metadataJson);

    final dataSourceJson = json['dataSource'] as Map<String, dynamic>? ?? {};
    final dataSource = ChartDataSource.fromJson(dataSourceJson);

    final inputsJson =
        (json['inputs'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final inputs = inputsJson.map((i) => ChartInput.fromJson(i)).toList();

    final notationsJson =
        (json['notations'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final notations = notationsJson
        .map((n) => ChartNotation.fromJson(n))
        .toList();

    final guidesJson =
        (json['guides'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final guides = guidesJson.map((g) => ChartGuide.fromJson(g)).toList();

    return ChartData(
      plots: plots,
      data: dataJson,
      metadata: metadata,
      dataSource: dataSource,
      fields: fields,
      inputs: inputs,
      notations: notations,
      guides: guides,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'plots': plots.map((p) => p.toJson()).toList(),
    'data': data,
    'metadata': metadata.toJson(),
    'dataSource': dataSource.toJson(),
    'fields': fields.map((f) => f.toJson()).toList(),
    'inputs': inputs.map((i) => i.toJson()).toList(),
    'notations': notations.map((n) => n.toJson()).toList(),
    'guides': guides.map((g) => g.toJson()).toList(),
  };

  /// Get plot by index
  Plot? getPlot(int index) =>
      index >= 0 && index < plots.length ? plots[index] : null;

  /// Get time field from fields list
  ChartField? getTimeField() {
    try {
      return fields.firstWhere(
        (f) =>
            f.axis.toLowerCase() == 'time' ||
            f.valueType.toString().contains('date') == true ||
            f.key.toLowerCase().contains('date') == true ||
            f.key.toLowerCase().contains('time') == true,
      );
    } catch (e) {
      return null;
    }
  }

  /// Add plot
  void addPlot(Plot plot) => plots.add(plot);

  /// Remove plot
  void removePlot(int index) {
    if (index >= 0 && index < plots.length) {
      plots.removeAt(index);
    }
  }
}
