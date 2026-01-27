import '../enums/enums.dart';
import 'base_plot.dart';

/// Pie plot - renders pie/donut charts
class PiePlot extends Plot {
  final String? fieldKeyValue;
  final String? fieldKeyLabel;
  final String? fieldKeyY;
  final List<String>? colors;

  PiePlot({
    this.fieldKeyValue,
    this.fieldKeyLabel,
    this.fieldKeyY,
    this.colors,
    super.color,
    super.conditions,
  });

  @override
  PlotType get plotType => PlotType.pie;

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKeyValue != null) 'fieldKeyValue': fieldKeyValue,
    if (fieldKeyLabel != null) 'fieldKeyLabel': fieldKeyLabel,
    if (fieldKeyY != null) 'fieldKeyY': fieldKeyY,
    if (colors != null) 'colors': colors,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
