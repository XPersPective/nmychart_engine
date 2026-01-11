import 'plot_render_delegate.dart';
import 'line_plot_render_delegate.dart';
import 'bar_plot_render_delegate.dart';
import 'area_plot_render_delegate.dart';
import 'histogram_plot_render_delegate.dart';
import 'pie_plot_render_delegate.dart';
import 'candlestick_plot_render_delegate.dart';
import '../../../models/models.dart';

/// Factory for creating plot render delegates
class PlotRenderDelegateFactory {
  static PlotRenderDelegate createDelegate(Plot plot) {
    switch (plot.runtimeType) {
      case LinePlot:
        return LinePlotRenderDelegate();
      case BarPlot:
        return BarPlotRenderDelegate();
      case AreaPlot:
        return AreaPlotRenderDelegate();
      case HistogramPlot:
        return HistogramPlotRenderDelegate();
      case PiePlot:
        return PiePlotRenderDelegate();
      case CandlestickPlot:
        return CandlestickPlotRenderDelegate();
      default:
        throw UnsupportedError('Unknown plot type: ${plot.runtimeType}');
    }
  }
}
