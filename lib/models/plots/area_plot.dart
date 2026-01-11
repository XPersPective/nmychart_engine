import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

/// Area plot - renders filled areas under lines
class AreaPlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;

  AreaPlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.area;

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
