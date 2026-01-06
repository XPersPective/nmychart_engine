# Widgets Documentation

## Overview
Professional chart widget library with support for multiple plot types and interactive features.

## Architecture

### Chart Module (`chart/`)
- **nmychart.dart**: Main chart widget that orchestrates rendering and interaction
  - Manages chart state
  - Handles data binding
  - Coordinates painter selection

### Painters Module (`painters/`)
Each plot type has its own painter implementation:

- **chart_painter.dart** (Base): Abstract base class with common functionality
  - Grid and axes drawing
  - Color parsing
  - Painter lifecycle

- **line_chart_painter.dart**: Continuous line charts
- **bar_chart_painter.dart**: Vertical/horizontal bar charts
- **area_chart_painter.dart**: Filled area charts
- **histogram_painter.dart**: Histogram/distribution charts
- **pie_chart_painter.dart**: Pie/donut charts
- **candlestick_painter.dart**: OHLC financial charts

### Gestures Module (`gestures/`)
- **chart_gesture_handler.dart**: Centralized gesture management
  - Pan/drag handling
  - Zoom/scale handling
  - State management

## Usage Example

```dart
import 'package:nmychart_engine/widgets/widgets.dart';
import 'package:nmychart_engine/models/models.dart';

// Create a chart
final plot = LinePlot(
  fieldKey: 'price',
  color: '#1890FF',
);

final widget = CustomPaint(
  painter: LineChartPainter(
    plot: plot,
    canvasSize: Size(400, 300),
    dataPoints: [10, 20, 15, 25, 30],
  ),
  size: Size(400, 300),
);
```

## Hierarchy

```
NMychart (Main Widget)
    ├─ CustomPaint
    │   ├─ LineChartPainter
    │   ├─ BarChartPainter
    │   ├─ AreaChartPainter
    │   ├─ HistogramPainter
    │   ├─ PieChartPainter
    │   └─ CandlestickPainter
    └─ ChartGestureHandler
        ├─ Pan/Drag
        └─ Zoom/Scale
```
