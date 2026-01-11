/*
═══════════════════════════════════════════════════════════════════════════════
  Example 1: SMA Indicator (Simple Moving Average)
═══════════════════════════════════════════════════════════════════════════════

Type: financial
SubType: indicator

*/

const String smaIndicatorExample = '''{
  "metadata": {
    "id": "sma_v1_0_0",
    "name": "Simple Moving Average",
    "shortName": "SMA",
    "description": "SMA Indicator",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "financial",
    "subType": "indicator"
  },

  "inputs": [
    {
      "name": "Period",
      "key": "period",
      "valueType": "integer",
      "value": 14,
      "min": 2,
      "max": 100,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Smoothing",
      "key": "smoothing",
      "valueType": "double",
      "value": 0.5,
      "min": 0.0,
      "max": 1.0,
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "sma",
      "color": "#1890FF"
    }
  ],

  "fields": [
    {
      "name": "Date",
      "key": "date",
      "valueType": "timestamp",
      "axis": "x",
      "showInLegendType": "hidden",
      "format": "YYYY-MM-DD"
    },
    {
      "name": "SMA",
      "key": "sma",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "notations": [
    {
      "shape": "triangle",
      "label": "Peak",
      "dataIndices": [3],
      "color": "#FF4D4F",
      "direction": "up"
    },
    {
      "shape": "circle",
      "label": "Start",
      "dataIndices": [0],
      "color": "#52C41A",
      "direction": "down"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 154.5,
      "label": "Average",
      "color": "#FAAD14",
      "strokeStyle": "solid"
    },
    {
      "guideType": "line",
      "axis": "y",
      "value": 160.0,
      "label": "Resistance",
      "color": "#1890FF",
      "strokeStyle": "dashed"
    }
  ],

  "data": [
    ["2024-01-01", 150.5],
    ["2024-01-08", 152.3],
    ["2024-01-15", 151.8],
    ["2024-01-22", 155.2],
    ["2024-01-29", 157.1],
    ["2024-02-05", 156.5],
    ["2024-02-12", 158.9],
    ["2024-02-19", 160.2]
  ]
}''';

/*
═══════════════════════════════════════════════════════════════════════════════
  Example 2: Candlestick (OHLC Price Data)
═══════════════════════════════════════════════════════════════════════════════

Type: financial
SubType: price

NavBar ile seçilebilir: Symbol ve Interval

*/

const String candlestickExample = '''{
  "metadata": {
    "id": "btc_ohlc_1h",
    "name": "Bitcoin OHLC",
    "shortName": "BTC",
    "description": "Bitcoin 1-hour candlestick",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "financial",
    "subType": "price"
  },

  "inputs": [
    {
      "name": "Symbol",
      "key": "symbol",
      "valueType": "symbol",
      "value": "BTC/USDT",
      "base": "BTC",
      "quote": "USDT",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Interval",
      "key": "interval",
      "valueType": "interval",
      "value": "1h",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "candlestick",
      "fieldKeyX": "date",
      "fieldKeyOpen": "open",
      "fieldKeyHigh": "high",
      "fieldKeyLow": "low",
      "fieldKeyClose": "close",
      "color": "#1890FF"
    }
  ],

  "fields": [
    {
      "name": "Date",
      "key": "date",
      "valueType": "timestamp",
      "axis": "x",
      "showInLegendType": "hidden",
      "format": "YYYY-MM-DD HH:mm"
    },
    {
      "name": "Open",
      "key": "open",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "High",
      "key": "high",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Low",
      "key": "low",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Close",
      "key": "close",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "notations": [
    {
      "shape": "triangle",
      "label": "Peak",
      "dataIndices": [3],
      "color": "#FF4D4F",
      "direction": "up"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 42500.0,
      "label": "Resistance",
      "color": "#FF4D4F",
      "strokeStyle": "dashed"
    }
  ],

  "data": [
    ["2024-01-11 00:00", 42300.0, 42600.0, 42200.0, 42500.0],
    ["2024-01-11 01:00", 42500.0, 42800.0, 42400.0, 42700.0],
    ["2024-01-11 02:00", 42700.0, 42900.0, 42600.0, 42800.0],
    ["2024-01-11 03:00", 42800.0, 43100.0, 42700.0, 43000.0],
    ["2024-01-11 04:00", 43000.0, 43200.0, 42900.0, 43100.0],
    ["2024-01-11 05:00", 43100.0, 43300.0, 43000.0, 43200.0],
    ["2024-01-11 06:00", 43200.0, 43400.0, 43100.0, 43300.0],
    ["2024-01-11 07:00", 43300.0, 43500.0, 43200.0, 43400.0]
  ]
}''';
