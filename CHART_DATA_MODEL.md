# Chart Data Model Documentation

## Overview
Complete JSON schema and model definitions for chart data configuration.

## Models

### ChartMetadata
Standard metadata for chart information and configuration.

```dart
class ChartMetadata {
  final String title;              // Chart title
  final String? description;       // Optional description
  final String? author;            // Chart creator
  final DateTime? createdAt;       // Creation timestamp
  final DateTime? updatedAt;       // Last update timestamp
  final String? unit;              // Data unit (e.g., USD, meters)
  final String? currency;          // Currency code
  final Map<String, dynamic>? custom;  // Custom fields
}
```

### ChartField
Defines data field properties and mapping.

```dart
enum ChartFieldType { string, number, date, boolean }

class ChartField {
  final String name;       // Display name
  final String key;        // Unique identifier
  final ChartFieldType type;  // Data type
  final String axis;       // 'x' or 'y'
  final int index;         // Position in data array
}
```

### ChartData
Main container for chart configuration and data.

```dart
class ChartData {
  final List<Plot> plots;          // Plot configurations
  final List<List<dynamic>> data;  // Raw data
  final ChartMetadata metadata;    // Metadata
  final List<ChartField> fields;   // Field definitions
  final ChartField? timeField;     // Optional time axis
}
```

## JSON Schema

### Metadata Schema
```json
{
  "metadata": {
    "title": "Chart Title",
    "description": "Optional description",
    "author": "Author name",
    "unit": "USD",
    "currency": "USD",
    "createdAt": "2026-01-06T10:00:00Z",
    "updatedAt": "2026-01-06T15:30:00Z",
    "custom": {
      "key": "value"
    }
  }
}
```

### Field Schema
```json
{
  "fields": [
    {
      "name": "Field Name",
      "key": "field_key",
      "type": "number|string|date|boolean",
      "axis": "x|y",
      "index": 0
    }
  ]
}
```

### Plot Schema
```json
{
  "plots": [
    {
      "plotType": "line",
      "fieldKey": "value_field",
      "color": "#1890FF"
    }
  ]
}
```

## Examples

### Line Chart Example
See `json_examples.dart` for complete JSON with sample data:
- 10 data points
- Time series data
- Color configuration

### Candlestick Chart Example
See `json_examples.dart` for complete JSON with OHLC data:
- 5 candlesticks
- Open, High, Low, Close values
- Up/down colors

## Usage

```dart
// Parse JSON to ChartData
final chartData = ChartData.fromJson(jsonMap);

// Access components
print(chartData.metadata.title);
print(chartData.plots.length);
print(chartData.data.length);

// Convert back to JSON
final json = chartData.toJson();
```

## Type Safety

✅ All metadata fields are typed (not generic Map)  
✅ Fields have type definitions  
✅ Plots reference valid types  
✅ Time field is optional but type-safe
