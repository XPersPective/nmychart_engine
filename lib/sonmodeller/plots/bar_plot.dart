import '../../models/enums/enums.dart';
import 'base_plot.dart';

/// Bar plot - renders vertical or horizontal bars
class BarPlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;

  BarPlot({
    this.fieldKeyX,
    this.fieldKeyY,
    super.color,
    super.conditions,
  });

  @override
  PlotType get plotType => PlotType.bar;

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKeyX != null) 'fieldKeyX': fieldKeyX,
    if (fieldKeyY != null) 'fieldKeyY': fieldKeyY,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
