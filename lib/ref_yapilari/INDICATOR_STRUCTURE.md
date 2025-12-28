% # Indicator JSON Structure Documentation

## Overview

This document explains the complete JSON structure for indicators, including all data types, enums, and model definitions.

---

## 1. DATA TYPES (ValueType)

These are the allowed data types for input values and fields:

```
- integer: Whole numbers (1, 100, 1000)
- double: Decimal numbers (1.5, 100.25, 1000.99)
- string: Text values ("North", "momentum", "2024-01-01")
- timestamp: Unix timestamps in milliseconds (1704067200000)
```

**Important:** Only `timestamp` valueType requires a `format` field.

---

## 2. TIME FORMATS (TimeFormat)

Only used when `valueType: "timestamp"`. Specifies how timestamps are formatted/stored:

```
- milliseconds: 1704067200000
- seconds: 1704067200
- minutes: 28401120
- hours: 473352
- days: 19723
- weeks: 2817.57
- months: "2024-01"
- years: 2024
- iso8601: "2024-01-01T12:00:00Z"
```

---

## 3. PLOT TYPES (PlotType)

Visualization types for plots:

```
- line: Line chart
- bar: Bar chart
- area: Area chart
- candlestick: OHLC candlestick (requires open, high, low, close)
- pie: Pie chart (requires categoryFieldKey)
- histogram: Histogram/distribution
- map: Geographical map
```

**Transformations (what each type can change to):**
- line → [line, area, bar]
- bar → [bar, area, line]
- area → [area, line, bar]
- candlestick → [candlestick, line, bar]
- pie → [pie, donut]
- histogram → [histogram, bar, area]
- map → [map, heatmap]

---

## 4. CONDITION OPERATORS

For conditional coloring in plots:

```
- >   (greater than)
- <   (less than)
- >=  (greater or equal)
- <=  (less or equal)
- ==  (equal)
- !=  (not equal)
```

---

## 5. NOTATION SHAPES

Marker/annotation shapes on chart:

```
- triangle
- circle
- diamond
- square
- star
- arrow
- cross
- hexagon
```

---

## 6. DIRECTIONS

Direction for notation labels/markers:

```
- up
- down
- left
- right
- upLeft
- upRight
- downLeft
- downRight
```

---

## 7. GUIDE TYPES

Reference elements on chart:

```
- line: Single reference line
- zone: Area between two values
- ribbon: Dynamic band
- bands: Multiple bands (like Bollinger Bands)
- circle: Circular marker
- rectangle: Rectangular area
```

---

## 8. AXIS TYPES

Axis specification:

```
- x: X-axis (horizontal)
- y: Y-axis (vertical)
- xy: Both axes
```

---

## 9. STROKE STYLES

Line drawing styles:

```
- solid: ———
- dashed: — — —
- dotted: · · ·
- dashedDot: —·—·
```

---

## COMPLETE EXAMPLE: Candlestick with Conditions

```json
{
  "metadata": {
    "id": "candlestick_v1",
    "name": "OHLC Candlestick",
    "short_name": "Candlestick",
    "description": "Open High Low Close candlestick chart",
    "category": "momentum",
    "author": "System",
    "version": "1.0.0",
    "createdAt": 1704067200000
  },
  
  "inputs": [
    {
      "key": "period",
      "valueType": "integer",
      "value": 20,
      "min": 1,
      "max": 100,
      "label": "Period",
      "showInLegend": true
    }
  ],
  
  "fields": [
    {
      "axis": "x",
      "key": "timestamp",
      "name": "Time",
      "valueType": "timestamp",
      "format": "milliseconds",
      "showInLegend": false
    },
    {
      "axis": "y",
      "key": "open",
      "name": "Open",
      "valueType": "double",
      "showInLegend": false
    },
    {
      "axis": "y",
      "key": "high",
      "name": "High",
      "valueType": "double",
      "showInLegend": false
    },
    {
      "axis": "y",
      "key": "low",
      "name": "Low",
      "valueType": "double",
      "showInLegend": false
    },
    {
      "axis": "y",
      "key": "close",
      "name": "Close",
      "valueType": "double",
      "showInLegend": true
    }
  ],
  
  "data": [
    [1704067200000, 100.0, 105.0, 98.0, 102.0],
    [1704153600000, 102.0, 108.0, 101.0, 106.0],
    [1704240000000, 106.0, 107.0, 103.0, 104.0]
  ],
  
  "plots": [
    {
      "plotType": "candlestick",
      "fieldKeyOpen": "open",
      "fieldKeyHigh": "high",
      "fieldKeyLow": "low",
      "fieldKeyClose": "close",
      "upColor": "#4CAF50",
      "downColor": "#F44336",
      "conditions": [
        {
          "value1": {"fieldKey": "close"},
          "operator": ">",
          "value2": {"fieldKey": "open"},
          "result": {"color": "#4CAF50"}
        }
      ]
    }
  ],
  
  "notations": [
    {
      "shape": "triangle",
      "label": "Buy",
      "dataIndices": [0, 2],
      "color": "#4CAF50",
      "direction": "up"
    }
  ],
  
  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 105,
      "label": "Resistance",
      "color": "#FF0000",
      "strokeStyle": "dashed"
    },
    {
      "guideType": "zone",
      "axis": "y",
      "start": 100,
      "end": 110,
      "label": "Trading Zone",
      "color": "#FFC107",
      "strokeStyle": "solid"
    }
  ]
}
```

---

## STRUCTURE DETAILS

### metadata
- `id`: Unique identifier
- `name`: Full name
- `short_name`: Abbreviated name
- `description`: What this indicator does
- `category`: Classification (user-defined label)
- `author`: Creator
- `version`: Semantic version
- `createdAt`: Unix timestamp (optional)

### inputs
Array of user-configurable parameters.
Each input has:
- `key`: Unique identifier
- `valueType`: Data type (integer, double, string, timestamp)
- `value`: Default value
- `min`, `max`: Constraints (optional, for numeric types)
- `label`: Display name
- `showInLegend`: Should appear in legend

### fields
Array of data columns. Order matters - data arrays follow this order.
Each field has:
- `axis`: x, y, or xy
- `key`: Data column identifier
- `name`: Display name
- `valueType`: Data type
- `format`: Only if valueType is "timestamp"
- `showInLegend`: Display in legend

### data
Array of arrays. Each inner array is a data point.
Order and types match the `fields` array.

```json
"data": [
  [timestamp, open, high, low, close],
  [timestamp, open, high, low, close]
]
```

### plots
Array of visualization configurations.
Each plot has:
- `plotType`: visualization type
- `fieldKey`: (for simple plots) which field to visualize
- Type-specific fields:
  - **Candlestick**: fieldKeyOpen, fieldKeyHigh, fieldKeyLow, fieldKeyClose
  - **Pie**: fieldKey (values), categoryFieldKey (labels)
  - **Bubble**: fieldKey (y), sizeFieldKey (bubble size), categoryFieldKey (bubbles)
- `color`: Default color
- `upColor`, `downColor`: For candlestick
- `conditions`: Array of conditional colorization rules

### conditions
Coloring rules based on data values.
Each condition has:
- `value1`: Left side of comparison (can reference fieldKey or be literal)
- `operator`: Comparison operator (>, <, >=, <=, ==, !=)
- `value2`: Right side of comparison
- `result`: What to apply if condition is true (e.g., color)

### notations
Markers/annotations on chart.
Each notation has:
- `shape`: Triangle, circle, diamond, etc.
- `label`: Text to display
- `dataIndices`: Array of data point indices where to show
- `color`: Marker color
- `direction`: Label direction (up, down, left, etc.)

### guides
Reference lines/zones on chart.
Each guide has:
- `guideType`: line, zone, ribbon, bands, circle, rectangle
- `axis`: x, y, or xy
- Value fields (depends on type):
  - **line**: `value`
  - **zone**: `start`, `end`
  - **circle**: `centerX`, `centerY`, `radius`
- `label`: Display text
- `color`: Line/area color
- `strokeStyle`: solid, dashed, dotted, dashedDot

---

## CREATING AN INDICATOR

Step-by-step workflow:

1. **Create metadata** - Define indicator identity
2. **Define inputs** - What parameters can user adjust?
3. **Define fields** - What data columns exist?
4. **Provide data** - Populate arrays matching field order
5. **Create plots** - How to visualize?
6. **Add conditions** (optional) - Color rules?
7. **Add notations** (optional) - Mark important points?
8. **Add guides** (optional) - Reference lines/zones?

---

## INHERITANCE RULES

When defining structures:

- **Input inherits from:** valueType
  - If valueType is timestamp → must have format
  - Otherwise → no format field

- **Field inherits from:** valueType
  - If valueType is timestamp → must have format
  - Otherwise → no format field

- **Plot inherits from:** plotType
  - If plotType is candlestick → fieldKeyOpen, fieldKeyHigh, fieldKeyLow, fieldKeyClose
  - If plotType is pie → fieldKey (values), categoryFieldKey (labels)
  - If plotType is bubble → fieldKey, sizeFieldKey, categoryFieldKey
  - Otherwise → just fieldKey

- **Guide inherits from:** guideType
  - If guideType is line → value
  - If guideType is zone → start, end
  - If guideType is circle → centerX, centerY, radius
  - If guideType is bands/ribbon → dynamic fields

---

## JSON VALIDATION CHECKLIST

✓ Metadata has id, name, short_name, description, category, author, version
✓ Inputs have key, valueType, value, label, showInLegend
✓ Fields have axis, key, name, valueType, showInLegend
✓ Fields with valueType=timestamp have format field
✓ Data array rows match field count and types
✓ Plots have plotType and appropriate fieldKey(s)
✓ Candlestick plots have fieldKeyOpen, High, Low, Close
✓ Pie plots have fieldKey and categoryFieldKey
✓ Conditions have value1, operator, value2, result
✓ Notations have shape, label, dataIndices, direction
✓ Guides have guideType, axis, appropriate value fields
✓ Colors are valid hex codes (#RRGGBB)
✓ Data indices are within data array bounds
