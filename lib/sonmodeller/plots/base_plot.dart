import '../../models/enums/enums.dart';
import 'plot_condition.dart';
import 'line_plot.dart';
import 'bar_plot.dart';
import 'area_plot.dart';
import 'histogram_plot.dart';
import 'pie_plot.dart';
import 'candlestick_plot.dart';
import '../../widgets/painters/delegates/plot_render_delegate_factory.dart';
import '../../widgets/painters/delegates/plot_render_delegate.dart';

/// Base abstract class for all plot types
/// Each plot type handles its own rendering logic
abstract class Plot {
  final String? color;
  final List<PlotCondition>? conditions;

  Plot({this.color, this.conditions});

  /// Type-safe getter for plot type
  PlotType get plotType;

  /// Create a render delegate for this plot
  /// Uses factory pattern to instantiate type-specific delegate
  PlotRenderDelegate createDelegate() {
    return PlotRenderDelegateFactory.createDelegate(this);
  }

  /// Serialize to JSON
  Map<String, dynamic> toJson();

  /// Get allowed transformations for this plot type
  List<String> getTransformations() => plotType.getTransforms();

  /// Factory constructor for polymorphic JSON deserialization
  static Plot fromJson(Map<String, dynamic> json) {
    final plotTypeStr = json['plotType'] as String? ?? 'line';
    final plotType = _parseType(plotTypeStr);
    final conditions = json['conditions'] != null
        ? (json['conditions'] as List)
              .map((c) => PlotCondition.fromJson(c as Map<String, dynamic>))
              .toList()
        : null;

    switch (plotType) {
      case PlotType.line:
        return LinePlot(
          fieldKeyX: json['fieldKeyX'] as String?,
          fieldKeyY: json['fieldKeyY'] as String?,
          color: json['color'] as String?,
          conditions: conditions,
        );
      case PlotType.bar:
        return BarPlot(
          fieldKeyX: json['fieldKeyX'] as String?,
          fieldKeyY: json['fieldKeyY'] as String?,
          color: json['color'] as String?,
          conditions: conditions,
        );
      case PlotType.area:
        return AreaPlot(
          fieldKeyX: json['fieldKeyX'] as String?,
          fieldKeyY: json['fieldKeyY'] as String?,
          color: json['color'] as String?,
          conditions: conditions,
        );
      case PlotType.histogram:
        return HistogramPlot(
          fieldKey: json['fieldKey'] as String?,
          color: json['color'] as String?,
          conditions: conditions,
        );
      case PlotType.pie:
        return PiePlot(
          fieldKeyValue: json['fieldKeyValue'] as String?,
          fieldKeyLabel: json['fieldKeyLabel'] as String?,
          colors: (json['colors'] as List?)?.cast<String>(),
          color: json['color'] as String?,
          conditions: conditions,
        );
      case PlotType.candlestick:
        return CandlestickPlot(
          fieldKeyOpen: json['fieldKeyOpen'] as String?,
          fieldKeyHigh: json['fieldKeyHigh'] as String?,
          fieldKeyLow: json['fieldKeyLow'] as String?,
          fieldKeyClose: json['fieldKeyClose'] as String?,
          upColor: json['upColor'] as String?,
          downColor: json['downColor'] as String?,
          conditions: conditions,
        );
    }
  }

  static PlotType _parseType(String typeStr) {
    switch (typeStr.toLowerCase()) {
      case 'line':
        return PlotType.line;
      case 'bar':
        return PlotType.bar;
      case 'area':
        return PlotType.area;
      case 'histogram':
        return PlotType.histogram;
      case 'pie':
        return PlotType.pie;
      case 'candlestick':
        return PlotType.candlestick;
      default:
        return PlotType.line;
    }
  }
}
