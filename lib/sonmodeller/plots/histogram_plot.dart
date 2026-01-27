import '../../models/enums/enums.dart';
import 'base_plot.dart';

/// Histogram plot - renders distribution data
class HistogramPlot extends Plot {
  final String? fieldKey;
  final String? fieldKeyY;
  final int? binCount;

  HistogramPlot({
    this.fieldKey,
    this.fieldKeyY,
    this.binCount,
    super.color,
    super.conditions,
  });

  @override
  PlotType get plotType => PlotType.histogram;

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKey != null) 'fieldKey': fieldKey,
    if (fieldKeyY != null) 'fieldKeyY': fieldKeyY,
    if (binCount != null) 'binCount': binCount,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
