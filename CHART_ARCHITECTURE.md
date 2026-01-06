# NMyChart Engine - Complete Architecture

## 1. Overview

NMyChart is a type-safe, polymorphic charting engine for Flutter that separates concerns into distinct layers:
- **Models**: Type-safe data structures with complete serialization
- **Painters**: Canvas-based rendering with polymorphic plot support
- **Widgets**: User-facing components for chart interaction

## 2. Data Model Architecture

### 2.1 Core Container
```
ChartData (Main Container)
├── ChartMetadata (id, name, version, author, category, timestamps)
├── List<Plot> (polymorphic plot types)
├── List<ChartField> (field definitions with types)
├── List<ChartInput> (parameters with constraints)
├── List<ChartNotation> (visual markers/annotations)
├── List<ChartGuide> (reference lines/zones)
├── List<List<dynamic>> (raw data array)
└── ChartField? (optional timeField)
```

### 2.2 ChartMetadata (Type-Safe Metadata)
```dart
ChartMetadata {
  id: String,                    // Unique identifier
  name: String,                  // Full name
  shortName: String,             // Short name
  description: String,           // Description
  category: String,              // Category (finance, analytics, etc)
  author: String,                // Creator
  version: String,               // Version number
  createdAt: DateTime,           // Creation timestamp
  updatedAt: DateTime?,          // Last update timestamp
}
```

### 2.3 ChartField (Type-Safe Field Definition)
```dart
ChartField {
  name: String,                  // Display name
  key: String,                   // Data key (must match data column)
  valueType: ValueType,          // Enum: integer, double, string, boolean, timestamp
  axis: String,                  // x or y (default: y)
  showInLegend: bool,            // Include in legend (default: true)
  format: String?,               // ONLY for timestamp valueType (e.g., "milliseconds")
}
```

**Important**: 
- NO `index` field - Data array order determines field position automatically
- NO `type` field - Only `valueType` is used
- `format` is ONLY required when `valueType == timestamp`

### 2.4 ChartInput (Type-Safe Parameters)
```dart
ChartInput {
  key: String,                   // Parameter key
  valueType: ValueType,          // Enum: integer, double, string, boolean, timestamp
  value: dynamic,                // Current value
  min: dynamic?,                 // Minimum (for numeric types)
  max: dynamic?,                 // Maximum (for numeric types)
  label: String,                 // Display label
  showInLegend: bool,            // Show in legend
}
```

### 2.5 ChartNotation (Visual Markers)
```dart
ChartNotation {
  shape: NotationShape,          // Enum: triangle, circle, square, diamond, cross, star
  label: String,                 // Annotation label
  dataIndices: List<int>,        // Indices of marked data points
  color: String,                 // Hex color (e.g., "#1890FF")
  direction: Direction,          // Enum: up, down, left, right
}
```

### 2.6 ChartGuide (Reference Lines/Zones)
```dart
ChartGuide {
  guideType: GuideType,          // Enum: line, zone
  axis: String,                  // x or y
  value: dynamic?,               // Single value (for lines)
  start: dynamic?,               // Start value (for zones)
  end: dynamic?,                 // End value (for zones)
  label: String,                 // Guide label
  color: String,                 // Hex color
  strokeStyle: StrokeStyle,      // Enum: solid, dashed, dotted
}
```

### 2.7 Plot Hierarchy (Polymorphic)
```
Plot (Abstract Base)
├── Render Methods
│   └── render(Canvas, Size): void
├── JSON Serialization
│   ├── fromJson(Map): Factory Method
│   └── toJson(): Map
│
├── LinePlot
│   ├── fieldKey: String?
│   ├── color: String?
│   └── conditions: List<PlotCondition>?
│
├── BarPlot
│   ├── fieldKey: String?
│   ├── color: String?
│   ├── barWidth: double?
│   └── conditions: List<PlotCondition>?
│
├── AreaPlot
│   ├── fieldKey: String?
│   ├── color: String?
│   ├── fillOpacity: double?
│   └── conditions: List<PlotCondition>?
│
├── HistogramPlot
│   ├── fieldKey: String?
│   ├── binCount: int?
│   ├── color: String?
│   └── conditions: List<PlotCondition>?
│
├── PiePlot
│   ├── categoryFieldKey: String?
│   ├── colors: List<String>?
│   └── conditions: List<PlotCondition>?
│
└── CandlestickPlot
    ├── fieldKeyOpen: String?
    ├── fieldKeyHigh: String?
    ├── fieldKeyLow: String?
    ├── fieldKeyClose: String?
    ├── upColor: String?
    ├── downColor: String?
    └── conditions: List<PlotCondition>?
```

### 2.8 PlotCondition (Conditional Rendering)
```dart
PlotCondition {
  fieldKey: String,              // Field to evaluate
  operator: ConditionOperator,   // >, <, ==, !=, >=, <=
  value: dynamic,                // Comparison value
  result: dynamic,               // Result when true (color, style, etc)
}
```

## 3. Enum Definitions

### ValueType
```dart
enum ValueType { 
  integer,      // Int values
  double,       // Double values
  string,       // String values
  boolean,      // Boolean values
  timestamp,    // DateTime values
}
```

### ChartFieldType
```dart
enum ChartFieldType { 
  string,
  number,
  date,
  boolean,
  timestamp,
  double,
  integer,
}
```

### PlotType
```dart
enum PlotType { 
  line,
  bar,
  area,
  histogram,
  pie,
  candlestick,
}
```

### NotationShape
```dart
enum NotationShape { 
  triangle,
  circle,
  square,
  diamond,
  cross,
  star,
}
```

### Direction
```dart
enum Direction { 
  up,
  down,
  left,
  right,
  upLeft,
  upRight,
  downLeft,
  downRight,
}
```

### GuideType
```dart
enum GuideType { 
  line,    // Single value line
  zone,    // Range zone (start-end)
}
```

### StrokeStyle
```dart
enum StrokeStyle { 
  solid,
  dashed,
  dotted,
}
```

### ConditionOperator
```dart
enum ConditionOperator { 
  greaterThan,      // >
  lessThan,         // <
  equal,            // ==
  notEqual,         // !=
  greaterOrEqual,   // >=
  lessOrEqual,      // <=
}
```

## 4. Serialization Pattern

All models implement `fromJson()` factory and `toJson()` methods:

### fromJson() Factory Pattern
```dart
factory MyModel.fromJson(Map<String, dynamic> json) {
  return MyModel(
    field1: json['field1'] as String,
    field2: (json['field2'] as String?) == 'value' ? Type.value : Type.other,
  );
}
```

### toJson() Method
```dart
Map<String, dynamic> toJson() => {
  'field1': field1,
  'field2': field2.stringValue,  // Enums use stringValue extension
  'nested': nested.toJson(),     // Recursively serialize
};
```

### Polymorphic Deserialization
```dart
// Plot.fromJson() uses plotType to instantiate correct subclass
factory Plot.fromJson(Map<String, dynamic> json) {
  final plotTypeStr = json['plotType'] as String? ?? 'line';
  final plotType = PlotTypeExt.fromString(plotTypeStr);
  
  switch (plotType) {
    case PlotType.line:
      return LinePlot.fromJson(json);
    case PlotType.candlestick:
      return CandlestickPlot.fromJson(json);
    // ... other cases
  }
}
```

## 5. Widget Hierarchy

```
NMyChart (Main Widget)
├── GestureDetector
│   └── CustomPaint
│       └── _NMychartPainter
│           ├── ChartPainter (Abstract Base)
│           │   ├── drawGrid()
│           │   ├── drawAxes()
│           │   ├── _parseColor()
│           │
│           ├── LineChartPainter
│           ├── BarChartPainter
│           ├── AreaChartPainter
│           ├── HistogramPainter
│           ├── PieChartPainter
│           └── CandlestickPainter
│
└── ChartGestureHandler
    ├── _scale
    ├── _lastFocalPoint
    ├── handlePointerDown()
    ├── handlePointerMove()
    └── handlePointerUp()
```

## 6. Data Flow

```
JSON Input
    ↓
ChartData.fromJson()
    ├─→ Plot.fromJson() [polymorphic factory]
    ├─→ ChartMetadata.fromJson()
    ├─→ ChartField.fromJson()
    ├─→ ChartInput.fromJson()
    ├─→ ChartNotation.fromJson()
    └─→ ChartGuide.fromJson()
    ↓
Type-Safe Model Objects
    ↓
NMyChart Widget
    ↓
CustomPainter Selection
    ├─→ Determine plot types
    ├─→ Select appropriate painter
    └─→ Call painter.paint()
    ↓
Plot-Specific Rendering
    ├─→ plot.render() [conditions, styling]
    ├─→ drawGrid(), drawAxes() [base]
    ├─→ Draw notations
    ├─→ Draw guides
    └─→ Plot-specific shapes (lines, bars, candles, etc)
    ↓
Canvas Output
```

## 7. Type Safety Benefits

### Problem (Generic Maps)
```dart
// Before: Developer doesn't know what fields exist
final metadata = map['metadata'] as Map<String, dynamic>;
print(metadata['unknown_field']); // No compile error, runtime null
```

### Solution (Type-Safe Models)
```dart
// After: IDE autocomplete, compile-time checking
final metadata = ChartData.metadata;
print(metadata.createdAt); // ✅ Compile error if field doesn't exist
```

## 8. Extensibility

### Adding New Plot Type
1. Create new class extending `Plot`
2. Implement `plotType` getter returning enum value
3. Implement `render()` method for styling
4. Update `Plot.fromJson()` factory method
5. Create corresponding painter

### Adding New Input Type
1. Add value to `ValueType` enum
2. Create `ChartInput` with new `valueType`
3. Add parsing logic in `ChartInput.fromJson()`

### Adding New Notation Shape
1. Add value to `NotationShape` enum
2. Update painter to draw new shape in `render()`

## 9. JSON Schema Reference

See [CHART_DATA_MODEL.md](CHART_DATA_MODEL.md) for complete JSON schema examples.

## 10. File Structure

```
lib/
├── models/
│   ├── enums/
│   │   ├── enums.dart (index)
│   │   ├── plot_type.dart
│   │   ├── value_type.dart
│   │   ├── notation_shape.dart
│   │   ├── direction.dart
│   │   ├── guide_type.dart
│   │   ├── stroke_style.dart
│   │   └── condition_operator.dart
│   ├── plots/
│   │   ├── plots.dart (index)
│   │   ├── base_plot.dart
│   │   ├── line_plot.dart
│   │   ├── bar_plot.dart
│   │   ├── area_plot.dart
│   │   ├── histogram_plot.dart
│   │   ├── pie_plot.dart
│   │   ├── candlestick_plot.dart
│   │   └── plot_condition.dart
│   ├── models.dart (central export)
│   ├── chart_data.dart
│   ├── chart_metadata.dart
│   ├── chart_field.dart
│   ├── chart_input.dart
│   ├── chart_notation.dart
│   └── chart_guide.dart
├── widgets/
│   ├── chart/
│   │   └── nmychart.dart
│   ├── painters/
│   │   ├── chart_painter.dart
│   │   ├── line_chart_painter.dart
│   │   ├── bar_chart_painter.dart
│   │   ├── area_chart_painter.dart
│   │   ├── histogram_painter.dart
│   │   ├── pie_chart_painter.dart
│   │   └── candlestick_painter.dart
│   └── gestures/
│       └── chart_gesture_handler.dart
├── json_examples.dart
├── sample_data.dart
└── main.dart
```

---

**Architecture Status**: ✅ Complete and type-safe
**Last Updated**: January 2024
