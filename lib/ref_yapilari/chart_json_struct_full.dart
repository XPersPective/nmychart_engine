// ===========================================================================
// JSON STRUCTURE EXAMPLES & DOCUMENTATION
// ===========================================================================
//
// This file contains JSON examples for different indicator types.
// All Dart enums and model classes are in models.dart
//
// See models.dart for:
//   - ValueType, TimeFormat, PlotType enums
//   - ConditionOperator, NotationShape, Direction enums
//   - GuideType, AxisType, StrokeStyle enums
//   - Input, Field, Plot, Notation, Guide, Indicator model classes
//   - PlotTypeTransformations utility class
//
// ===========================================================================

// EXAMPLE 1: FINANCIAL - Candlestick with Conditions
final Map<String, dynamic> financialCandlestickExample = {
  "metadata": {
    "id": "candlestick_v1",
    "name": "OHLC Candlestick Chart",
    "short_name": "Candlestick",
    "description":
        "Open, High, Low, Close candlestick visualization for price movements",
    "category": "momentum",
    "author": "Generated",
    "version": "1.0.0",
  },
  "inputs": [
    {
      "key": "period",
      "valueType": "integer",
      "value": 20,
      "min": 1,
      "max": 100,
      "label": "Period",
      "showInLegend": true,
    },
  ],
  "fields": [
    {
      "axis": "x",
      "key": "timestamp",
      "name": "Time",
      "valueType": "timestamp",
      "format": "milliseconds",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "open",
      "name": "Open",
      "valueType": "double",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "high",
      "name": "High",
      "valueType": "double",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "low",
      "name": "Low",
      "valueType": "double",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "close",
      "name": "Close",
      "valueType": "double",
      "showInLegend": true,
    },
  ],
  "data": [
    [1704067200000, 100.0, 105.0, 98.0, 102.0],
    [1704153600000, 102.0, 108.0, 101.0, 106.0],
    [1704240000000, 106.0, 107.0, 103.0, 104.0],
    [1704326400000, 104.0, 109.0, 102.0, 107.0],
    [1704412800000, 107.0, 110.0, 105.0, 108.0],
    [1704499200000, 108.0, 111.0, 106.0, 109.0],
    [1704585600000, 109.0, 112.0, 108.0, 110.0],
    [1704672000000, 110.0, 113.0, 109.0, 111.0],
    [1704758400000, 111.0, 114.0, 110.0, 112.0],
    [1704844800000, 112.0, 115.0, 111.0, 113.0],
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
          "result": {"color": "#4CAF50"},
        },
      ],
    },
  ],
  "notations": [
    {
      "shape": "triangle",
      "label": "Buy Signal",
      "dataIndices": [3, 8],
      "color": "#4CAF50",
      "direction": "up",
    },
    {
      "shape": "triangle",
      "label": "Sell Signal",
      "dataIndices": [5],
      "color": "#F44336",
      "direction": "down",
    },
  ],
  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 110,
      "label": "Resistance",
      "color": "#FF0000",
      "strokeStyle": "dashed",
    },
    {
      "guideType": "zone",
      "axis": "y",
      "start": 105,
      "end": 110,
      "label": "Trading Zone",
      "color": "#FFC107",
      "strokeStyle": "solid",
    },
  ],
};

// EXAMPLE 2: SALES - Pie Chart
final Map<String, dynamic> salesPieChartExample = {
  "metadata": {
    "id": "sales_pie_v1",
    "name": "Monthly Sales Distribution",
    "short_name": "Sales Pie",
    "description": "Distribution of sales across regions for current month",
    "category": "distribution",
    "author": "Generated",
    "version": "1.0.0",
  },
  "inputs": [],
  "fields": [
    {
      "axis": "x",
      "key": "region",
      "name": "Region",
      "valueType": "string",
      "showInLegend": true,
    },
    {
      "axis": "y",
      "key": "sales",
      "name": "Sales Amount",
      "valueType": "double",
      "showInLegend": true,
    },
  ],
  "data": [
    ["North", 45000.0],
    ["South", 38000.0],
    ["East", 52000.0],
    ["West", 41000.0],
    ["Central", 35000.0],
  ],
  "plots": [
    {"plotType": "pie", "fieldKey": "sales", "categoryFieldKey": "region"},
  ],
  "notations": [],
  "guides": [],
};

// EXAMPLE 3: WEATHER - Line with Area & Multiple Plots
final Map<String, dynamic> weatherForecastExample = {
  "metadata": {
    "id": "weather_forecast_v1",
    "name": "7-Day Temperature Forecast",
    "short_name": "Weather",
    "description": "Temperature trends and forecast with min/max range",
    "category": "forecast",
    "author": "Generated",
    "version": "1.0.0",
  },
  "inputs": [
    {
      "key": "unit",
      "valueType": "string",
      "value": "celsius",
      "label": "Temperature Unit",
      "showInLegend": false,
    },
  ],
  "fields": [
    {
      "axis": "x",
      "key": "date",
      "name": "Date",
      "valueType": "timestamp",
      "format": "days",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "temp_avg",
      "name": "Average Temperature",
      "valueType": "double",
      "showInLegend": true,
    },
    {
      "axis": "y",
      "key": "temp_min",
      "name": "Min Temperature",
      "valueType": "double",
      "showInLegend": true,
    },
    {
      "axis": "y",
      "key": "temp_max",
      "name": "Max Temperature",
      "valueType": "double",
      "showInLegend": true,
    },
  ],
  "data": [
    [1704067200000, 12.0, 8.0, 18.0],
    [1704153600000, 14.0, 10.0, 20.0],
    [1704240000000, 16.0, 12.0, 22.0],
    [1704326400000, 15.0, 11.0, 21.0],
    [1704412800000, 13.0, 9.0, 19.0],
    [1704499200000, 11.0, 7.0, 17.0],
    [1704585600000, 10.0, 6.0, 16.0],
  ],
  "plots": [
    {
      "plotType": "line",
      "fieldKey": "temp_avg",
      "color": "#2196F3",
      "conditions": [
        {
          "value1": {"fieldKey": "temp_avg"},
          "operator": ">",
          "value2": {"value": 15},
          "result": {"color": "#FF9800"},
        },
      ],
    },
    {"plotType": "area", "fieldKey": "temp_min", "color": "#4CAF50"},
    {"plotType": "area", "fieldKey": "temp_max", "color": "#F44336"},
  ],
  "notations": [
    {
      "shape": "circle",
      "label": "Coldest Day",
      "dataIndices": [6],
      "color": "#2196F3",
      "direction": "down",
    },
  ],
  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 0,
      "label": "Freezing Point",
      "color": "#00BCD4",
      "strokeStyle": "solid",
    },
  ],
};

// EXAMPLE 4: HISTOGRAM with Bar Transformation
final Map<String, dynamic> histogramExample = {
  "metadata": {
    "id": "histogram_v1",
    "name": "Price Distribution Histogram",
    "short_name": "Histogram",
    "description": "Distribution of price movements in specified intervals",
    "category": "distribution",
    "author": "Generated",
    "version": "1.0.0",
  },
  "inputs": [
    {
      "key": "bins",
      "valueType": "integer",
      "value": 10,
      "min": 5,
      "max": 50,
      "label": "Number of Bins",
      "showInLegend": false,
    },
  ],
  "fields": [
    {
      "axis": "x",
      "key": "price_range",
      "name": "Price Range",
      "valueType": "string",
      "showInLegend": false,
    },
    {
      "axis": "y",
      "key": "frequency",
      "name": "Frequency",
      "valueType": "integer",
      "showInLegend": true,
    },
  ],
  "data": [
    ["90-100", 15],
    ["100-110", 28],
    ["110-120", 35],
    ["120-130", 32],
    ["130-140", 18],
    ["140-150", 12],
  ],
  "plots": [
    {
      "plotType": "histogram",
      "fieldKey": "frequency",
      "color": "#9C27B0",
      "conditions": [
        {
          "value1": {"fieldKey": "frequency"},
          "operator": ">",
          "value2": {"value": 25},
          "result": {"color": "#4CAF50"},
        },
      ],
    },
  ],
  "notations": [],
  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 30,
      "label": "Average Frequency",
      "color": "#FF9800",
      "strokeStyle": "dashed",
    },
  ],
};
