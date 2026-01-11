import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

/// Line plot - renders continuous lines connecting data points
class LinePlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;

  LinePlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.line;

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
