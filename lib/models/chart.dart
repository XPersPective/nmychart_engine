import '../sonmodeller/plots/plots.dart';
import '../sonmodeller/chart_field.dart';
import 'chart_metadata.dart';
import '../sonmodeller/chart_input.dart';
import 'chart_notation.dart';
import 'chart_guide.dart';

/// Chart Model
/// Represents a single chart within a collection.
/// Can have overlays but overlays cannot have nested overlays (max 2-level nesting).
class Chart {
  final ChartMetadata metadata;
  final List<ChartInput> inputs;
  final List<ChartField> fields;
  final List<Plot> plots;
  final List<List<dynamic>> data;
  final List<ChartNotation> notations;
  final List<ChartGuide> guides;
  final List<Overlay> overlays; // Charts can have overlays

  Chart({
    required this.metadata,
    required this.inputs,
    required this.fields,
    required this.plots,
    required this.data,
    this.notations = const [],
    this.guides = const [],
    this.overlays = const [],
  });

  /// Create Chart from JSON
  factory Chart.fromJson(Map<String, dynamic> json) {
    final metadataJson = json['metadata'] as Map<String, dynamic>? ?? {};
    final metadata = ChartMetadata.fromJson(metadataJson);

    final inputsJson =
        (json['inputs'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final inputs = inputsJson.map((i) => ChartInput.fromJson(i)).toList();

    final fieldsJson =
        (json['fields'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final fields = fieldsJson.map((f) => ChartField.fromJson(f)).toList();

    final plotsJson =
        (json['plots'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final plots = plotsJson.map((p) => Plot.fromJson(p)).toList();

    final dataJson = (json['data'] as List?)?.cast<List<dynamic>>() ?? [];

    final notationsJson =
        (json['notations'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final notations = notationsJson
        .map((n) => ChartNotation.fromJson(n))
        .toList();

    final guidesJson =
        (json['guides'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final guides = guidesJson.map((g) => ChartGuide.fromJson(g)).toList();

    final overlaysJson =
        (json['overlays'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final overlays = overlaysJson.map((o) => Overlay.fromJson(o)).toList();

    return Chart(
      metadata: metadata,
      inputs: inputs,
      fields: fields,
      plots: plots,
      data: dataJson,
      notations: notations,
      guides: guides,
      overlays: overlays,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'metadata': metadata.toJson(),
    'inputs': inputs.map((i) => i.toJson()).toList(),
    'fields': fields.map((f) => f.toJson()).toList(),
    'plots': plots.map((p) => p.toJson()).toList(),
    'data': data,
    'notations': notations.map((n) => n.toJson()).toList(),
    'guides': guides.map((g) => g.toJson()).toList(),
    'overlays': overlays.map((o) => o.toJson()).toList(),
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
            f.valueType.toString().contains('timestamp') == true ||
            f.key.toLowerCase().contains('date') == true ||
            f.key.toLowerCase().contains('time') == true,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get overlay by index
  Overlay? getOverlay(int index) =>
      index >= 0 && index < overlays.length ? overlays[index] : null;
}

/// Overlay Model
/// Overlay on a chart. Same structure as Chart but NO overlays (max 2-level nesting).
class Overlay {
  final ChartMetadata metadata;
  final List<ChartInput> inputs;
  final List<ChartField> fields;
  final List<Plot> plots;
  final List<List<dynamic>> data;
  final List<ChartNotation> notations;
  final List<ChartGuide> guides;

  Overlay({
    required this.metadata,
    required this.inputs,
    required this.fields,
    required this.plots,
    required this.data,
    this.notations = const [],
    this.guides = const [],
  });

  /// Create Overlay from JSON
  factory Overlay.fromJson(Map<String, dynamic> json) {
    final metadataJson = json['metadata'] as Map<String, dynamic>? ?? {};
    final metadata = ChartMetadata.fromJson(metadataJson);

    final inputsJson =
        (json['inputs'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final inputs = inputsJson.map((i) => ChartInput.fromJson(i)).toList();

    final fieldsJson =
        (json['fields'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final fields = fieldsJson.map((f) => ChartField.fromJson(f)).toList();

    final plotsJson =
        (json['plots'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final plots = plotsJson.map((p) => Plot.fromJson(p)).toList();

    final dataJson = (json['data'] as List?)?.cast<List<dynamic>>() ?? [];

    final notationsJson =
        (json['notations'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final notations = notationsJson
        .map((n) => ChartNotation.fromJson(n))
        .toList();

    final guidesJson =
        (json['guides'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final guides = guidesJson.map((g) => ChartGuide.fromJson(g)).toList();

    return Overlay(
      metadata: metadata,
      inputs: inputs,
      fields: fields,
      plots: plots,
      data: dataJson,
      notations: notations,
      guides: guides,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'metadata': metadata.toJson(),
    'inputs': inputs.map((i) => i.toJson()).toList(),
    'fields': fields.map((f) => f.toJson()).toList(),
    'plots': plots.map((p) => p.toJson()).toList(),
    'data': data,
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
            f.valueType.toString().contains('timestamp') == true ||
            f.key.toLowerCase().contains('date') == true ||
            f.key.toLowerCase().contains('time') == true,
      );
    } catch (e) {
      return null;
    }
  }
}
