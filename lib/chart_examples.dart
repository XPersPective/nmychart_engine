/*
═══════════════════════════════════════════════════════════════════════════════
  Chart Examples - Different Plot Types
═══════════════════════════════════════════════════════════════════════════════

Her plot tipine uygun profesyonel JSON örnekleri
*/

// ═══════════════════════════════════════════════════════════════════════════════
// 1. BAR CHART - Kategorik veri (Aylık Satışlar)
// ═══════════════════════════════════════════════════════════════════════════════

const String barChartExample = '''{
  "metadata": {
    "id": "monthly_sales",
    "name": "Monthly Sales",
    "shortName": "Sales",
    "description": "Monthly sales by region",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "business",
    "subType": "sales"
  },

  "inputs": [],

  "fields": [
    {
      "name": "Month",
      "key": "month",
      "valueType": "string",
      "axis": "x",
      "showInLegendType": "hidden"
    },
    {
      "name": "Sales",
      "key": "sales",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "bar",
      "fieldKeyX": "month",
      "fieldKeyY": "sales",
      "color": "#1890FF",
      "conditions": [
        {
          "name": "HighSales",
          "description": "Highlight sales > 5000",
          "type": "threshold",
          "field": "sales",
          "operator": ">",
          "value": 5000.0,
          "color": "#FF4D4F"
        }
      ]
    }
  ],

  "notations": [
    {
      "shape": "triangle",
      "label": "Peak Sales",
      "dataIndices": [4],
      "color": "#FAAD14",
      "direction": "up"
    },
    {
      "shape": "circle",
      "label": "Low Sales",
      "dataIndices": [1],
      "color": "#52C41A",
      "direction": "down"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 5000.0,
      "label": "Target",
      "color": "#1890FF",
      "strokeStyle": "dashed"
    },
    {
      "guideType": "line",
      "axis": "y",
      "value": 4000.0,
      "label": "Average",
      "color": "#52C41A",
      "strokeStyle": "solid"
    }
  ],

  "data": [
    ["January", 4000.0],
    ["February", 3000.0],
    ["March", 5000.0],
    ["April", 4500.0],
    ["May", 6000.0],
    ["June", 5500.0]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 2. LINE CHART - Zaman serisi (Hava Sıcaklığı)
// ═══════════════════════════════════════════════════════════════════════════════

const String lineChartExample = '''{
  "metadata": {
    "id": "temperature_daily",
    "name": "Daily Temperature",
    "shortName": "Temp",
    "description": "Daily temperature forecast",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "weather",
    "subType": "temperature"
  },

  "inputs": [
    {
      "name": "Location",
      "key": "location",
      "valueType": "string",
      "value": "Istanbul",
      "showInLegendType": "nameAndValue"
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
      "name": "Temperature",
      "key": "temperature",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "temperature",
      "color": "#FF7A00",
      "conditions": [
        {
          "name": "FreezingTemp",
          "description": "Temperature < 0°C",
          "type": "threshold",
          "field": "temperature",
          "operator": "<",
          "value": 0.0,
          "color": "#1890FF"
        },
        {
          "name": "HotWeather",
          "description": "Temperature > 25°C",
          "type": "threshold",
          "field": "temperature",
          "operator": ">",
          "value": 25.0,
          "color": "#FF4D4F"
        }
      ]
    }
  ],

  "notations": [
    {
      "shape": "triangle",
      "label": "Peak Temp",
      "dataIndices": [4],
      "color": "#FF4D4F",
      "direction": "up"
    },
    {
      "shape": "triangle",
      "label": "Low Temp",
      "dataIndices": [2],
      "color": "#1890FF",
      "direction": "down"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 0.0,
      "label": "Freezing Point",
      "color": "#1890FF",
      "strokeStyle": "dashed"
    },
    {
      "guideType": "line",
      "axis": "y",
      "value": 6.0,
      "label": "Average Temp",
      "color": "#FF7A00",
      "strokeStyle": "solid"
    }
  ],

  "data": [
    ["2026-01-01", 5.2],
    ["2026-01-02", 6.1],
    ["2026-01-03", 4.8],
    ["2026-01-04", 7.3],
    ["2026-01-05", 8.9],
    ["2026-01-06", 6.5]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 3. PIE CHART - Dağılım (Pazar Payı)
// ═══════════════════════════════════════════════════════════════════════════════

const String pieChartExample = '''{
  "metadata": {
    "id": "market_share",
    "name": "Market Share",
    "shortName": "Share",
    "description": "Browser market share",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "business",
    "subType": "distribution"
  },

  "inputs": [],

  "fields": [
    {
      "name": "Browser",
      "key": "browser",
      "valueType": "string",
      "axis": "x",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Percentage",
      "key": "percentage",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "onlyValue"
    }
  ],

  "plots": [
    {
      "plotType": "pie",
      "fieldKeyLabel": "browser",
      "fieldKeyValue": "percentage",
      "colors": ["#1890FF", "#52C41A", "#FAAD14", "#F5222D", "#722ED1"]
    }
  ],

  "data": [
    ["Chrome", 65.5],
    ["Safari", 18.3],
    ["Edge", 10.2],
    ["Firefox", 4.8],
    ["Other", 1.2]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 4. AREA CHART - Kümülatif Trend (Aylık Gelir)
// ═══════════════════════════════════════════════════════════════════════════════

const String areaChartExample = '''{
  "metadata": {
    "id": "monthly_revenue",
    "name": "Monthly Revenue",
    "shortName": "Revenue",
    "description": "Cumulative monthly revenue",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "business",
    "subType": "revenue"
  },

  "inputs": [],

  "fields": [
    {
      "name": "Month",
      "key": "month",
      "valueType": "string",
      "axis": "x",
      "showInLegendType": "hidden"
    },
    {
      "name": "Revenue",
      "key": "revenue",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "area",
      "fieldKeyX": "month",
      "fieldKeyY": "revenue",
      "color": "#1890FF",
      "fillOpacity": 0.3
    }
  ],

  "data": [
    ["Q1", 15000.0],
    ["Q2", 28000.0],
    ["Q3", 42000.0],
    ["Q4", 58000.0]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 5. HISTOGRAM - Frekans Dağılımı (Fiyat Dağılımı)
// ═══════════════════════════════════════════════════════════════════════════════

const String histogramExample = '''{
  "metadata": {
    "id": "price_distribution",
    "name": "Price Distribution",
    "shortName": "PriceHist",
    "description": "Price range distribution",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "business",
    "subType": "distribution"
  },

  "inputs": [
    {
      "name": "Bins",
      "key": "bins",
      "valueType": "integer",
      "value": 10,
      "min": 5,
      "max": 50,
      "showInLegendType": "hidden"
    }
  ],

  "fields": [
    {
      "name": "Price Range",
      "key": "priceRange",
      "valueType": "string",
      "axis": "x",
      "showInLegendType": "hidden"
    },
    {
      "name": "Frequency",
      "key": "frequency",
      "valueType": "integer",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "histogram",
      "fieldKeyX": "priceRange",
      "fieldKeyY": "frequency",
      "color": "#52C41A",
      "binWidth": 10
    }
  ],

  "data": [
    ["10-20", 5],
    ["20-30", 12],
    ["30-40", 28],
    ["40-50", 35],
    ["50-60", 20],
    ["60-70", 8],
    ["70-80", 2]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 6. SCATTER CHART - Korelasyon (Yaş vs Gelir)
// ═══════════════════════════════════════════════════════════════════════════════

const String scatterChartExample = '''{
  "metadata": {
    "id": "age_income_correlation",
    "name": "Age vs Income",
    "shortName": "Correlation",
    "description": "Age and income relationship",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "business",
    "subType": "analysis"
  },

  "inputs": [],

  "fields": [
    {
      "name": "Age",
      "key": "age",
      "valueType": "integer",
      "axis": "x",
      "showInLegendType": "hidden"
    },
    {
      "name": "Income",
      "key": "income",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "scatter",
      "fieldKeyX": "age",
      "fieldKeyY": "income",
      "color": "#FF7A00",
      "pointSize": 6
    }
  ],

  "data": [
    [25, 30000.0],
    [28, 35000.0],
    [32, 45000.0],
    [35, 50000.0],
    [40, 60000.0],
    [45, 70000.0],
    [50, 75000.0],
    [55, 80000.0]
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 7. MULTI-CHART COLLECTION - Finansal Dashboard
// ═══════════════════════════════════════════════════════════════════════════════

const String multiChartCollectionExample = '''{
  "charts": [
    {
      "metadata": {
        "id": "btc_ohlc_1h",
        "name": "Bitcoin 1H",
        "shortName": "BTC",
        "description": "Bitcoin 1-hour candlestick with overlays",
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

      "data": [
        ["2024-01-11 00:00", 42300.0, 42600.0, 42200.0, 42500.0],
        ["2024-01-11 01:00", 42500.0, 42800.0, 42400.0, 42700.0],
        ["2024-01-11 02:00", 42700.0, 42900.0, 42600.0, 42800.0],
        ["2024-01-11 03:00", 42800.0, 43100.0, 42700.0, 43000.0],
        ["2024-01-11 04:00", 43000.0, 43200.0, 42900.0, 43100.0],
        ["2024-01-11 05:00", 43100.0, 43300.0, 43000.0, 43200.0],
        ["2024-01-11 06:00", 43200.0, 43400.0, 43100.0, 43300.0],
        ["2024-01-11 07:00", 43300.0, 43500.0, 43200.0, 43400.0]
      ],

      "notations": [],
      "guides": [],

      "overlays": [
        {
          "metadata": {
            "id": "sma_20",
            "name": "SMA 20",
            "shortName": "SMA",
            "description": "Simple Moving Average 20",
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
              "value": 20,
              "min": 2,
              "max": 100,
              "showInLegendType": "onlyValue"
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
              "name": "SMA",
              "key": "sma",
              "valueType": "double",
              "axis": "y",
              "showInLegendType": "nameAndValue"
            }
          ],

          "plots": [
            {
              "plotType": "line",
              "fieldKeyX": "date",
              "fieldKeyY": "sma",
              "color": "#52C41A"
            }
          ],

          "data": [
            ["2024-01-11 00:00", 42400.0],
            ["2024-01-11 01:00", 42450.0],
            ["2024-01-11 02:00", 42520.0],
            ["2024-01-11 03:00", 42620.0],
            ["2024-01-11 04:00", 42750.0],
            ["2024-01-11 05:00", 42850.0],
            ["2024-01-11 06:00", 42950.0],
            ["2024-01-11 07:00", 43050.0]
          ],

          "notations": [],
          "guides": []
        }
      ]
    },

    {
      "metadata": {
        "id": "macd_1h",
        "name": "MACD",
        "shortName": "MACD",
        "description": "MACD Indicator Panel",
        "version": "1.0.0",
        "createdAt": "2026-01-11T10:00:00Z",
        "updatedAt": "2026-01-11T10:00:00Z",
        "type": "financial",
        "subType": "indicator"
      },

      "inputs": [
        {
          "name": "Fast Period",
          "key": "fastPeriod",
          "valueType": "integer",
          "value": 12,
          "min": 2,
          "max": 50,
          "showInLegendType": "onlyValue"
        },
        {
          "name": "Slow Period",
          "key": "slowPeriod",
          "valueType": "integer",
          "value": 26,
          "min": 2,
          "max": 100,
          "showInLegendType": "onlyValue"
        },
        {
          "name": "Signal Period",
          "key": "signalPeriod",
          "valueType": "integer",
          "value": 9,
          "min": 2,
          "max": 50,
          "showInLegendType": "onlyValue"
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
          "name": "MACD",
          "key": "macd",
          "valueType": "double",
          "axis": "y",
          "showInLegendType": "nameAndValue"
        },
        {
          "name": "Signal",
          "key": "signal",
          "valueType": "double",
          "axis": "y",
          "showInLegendType": "nameAndValue"
        },
        {
          "name": "Histogram",
          "key": "histogram",
          "valueType": "double",
          "axis": "y",
          "showInLegendType": "onlyValue"
        }
      ],

      "plots": [
        {
          "plotType": "line",
          "fieldKeyX": "date",
          "fieldKeyY": "macd",
          "color": "#1890FF"
        },
        {
          "plotType": "line",
          "fieldKeyX": "date",
          "fieldKeyY": "signal",
          "color": "#FF7A00"
        },
        {
          "plotType": "bar",
          "fieldKeyX": "date",
          "fieldKeyY": "histogram",
          "color": "#52C41A"
        }
      ],

      "data": [
        ["2024-01-11 00:00", 150.5, 145.2, 5.3],
        ["2024-01-11 01:00", 152.3, 147.1, 5.2],
        ["2024-01-11 02:00", 151.8, 148.5, 3.3],
        ["2024-01-11 03:00", 155.2, 150.2, 5.0],
        ["2024-01-11 04:00", 157.1, 152.1, 5.0],
        ["2024-01-11 05:00", 156.5, 153.5, 3.0],
        ["2024-01-11 06:00", 158.9, 155.2, 3.7],
        ["2024-01-11 07:00", 160.2, 156.8, 3.4]
      ],

      "notations": [],
      "guides": [],
      "overlays": []
    }
  ]
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 8. CANDLESTICK CHART - Finansal OHLC verisi
// ═══════════════════════════════════════════════════════════════════════════════

const String candlestickFinancialExample = '''{
  "metadata": {
    "id": "eth_ohlc_4h",
    "name": "Ethereum 4H",
    "shortName": "ETH",
    "description": "Ethereum 4-hour candlestick chart",
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
      "value": "ETH/USDT",
      "base": "ETH",
      "quote": "USDT",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Interval",
      "key": "interval",
      "valueType": "interval",
      "value": "4h",
      "showInLegendType": "nameAndValue"
    }
  ],

  "fields": [
    {
      "name": "Date",
      "key": "date",
      "valueType": "timestamp",
      "axis": "x",
      "showInLegendType": "hidden",
      "format": "YYYY-MM-DD HH:00"
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

  "data": [
    ["2024-01-11 00:00", 2450.5, 2480.2, 2440.1, 2470.8],
    ["2024-01-11 04:00", 2470.8, 2510.3, 2465.2, 2505.5],
    ["2024-01-11 08:00", 2505.5, 2520.1, 2490.3, 2515.2],
    ["2024-01-11 12:00", 2515.2, 2540.8, 2510.5, 2535.3],
    ["2024-01-11 16:00", 2535.3, 2560.2, 2528.1, 2555.8],
    ["2024-01-11 20:00", 2555.8, 2570.5, 2540.3, 2565.2],
    ["2024-01-12 00:00", 2565.2, 2590.1, 2560.5, 2585.7]
  ],

  "notations": [
    {
      "shape": "triangle",
      "label": "Buy Signal",
      "dataIndices": [2],
      "color": "#52C41A",
      "direction": "up"
    },
    {
      "shape": "triangle",
      "label": "Resistance",
      "dataIndices": [5],
      "color": "#FF4D4F",
      "direction": "down"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 2500.0,
      "label": "Support",
      "color": "#52C41A",
      "strokeStyle": "dashed"
    },
    {
      "guideType": "line",
      "axis": "y",
      "value": 2550.0,
      "label": "Resistance",
      "color": "#FF4D4F",
      "strokeStyle": "dashed"
    }
  ],

  "overlays": []
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 9. MACD INDICATOR - Finansal momentum göstergesi
// ═══════════════════════════════════════════════════════════════════════════════

const String macdIndicatorExample = '''{
  "metadata": {
    "id": "macd_btc_daily",
    "name": "Bitcoin MACD Daily",
    "shortName": "MACD",
    "description": "MACD Indicator for Bitcoin daily chart",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "financial",
    "subType": "indicator"
  },

  "inputs": [
    {
      "name": "Fast EMA",
      "key": "fastEma",
      "valueType": "integer",
      "value": 12,
      "min": 5,
      "max": 30,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Slow EMA",
      "key": "slowEma",
      "valueType": "integer",
      "value": 26,
      "min": 10,
      "max": 50,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Signal Line",
      "key": "signalLine",
      "valueType": "integer",
      "value": 9,
      "min": 5,
      "max": 20,
      "showInLegendType": "onlyValue"
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
      "name": "MACD Line",
      "key": "macdLine",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Signal Line",
      "key": "signalLine",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Histogram",
      "key": "histogram",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "onlyValue"
    }
  ],

  "plots": [
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "macdLine",
      "color": "#1890FF"
    },
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "signalLine",
      "color": "#FF7A00"
    },
    {
      "plotType": "bar",
      "fieldKeyX": "date",
      "fieldKeyY": "histogram",
      "color": "#52C41A"
    }
  ],

  "data": [
    ["2024-01-05", 180.5, 175.2, 5.3],
    ["2024-01-06", 182.3, 177.1, 5.2],
    ["2024-01-07", 181.8, 178.5, 3.3],
    ["2024-01-08", 185.2, 180.2, 5.0],
    ["2024-01-09", 187.1, 182.1, 5.0],
    ["2024-01-10", 186.5, 183.5, 3.0],
    ["2024-01-11", 189.9, 185.2, 4.7]
  ],

  "notations": [
    {
      "shape": "circle",
      "label": "Bullish Crossover",
      "dataIndices": [3],
      "color": "#52C41A",
      "direction": "up"
    },
    {
      "shape": "circle",
      "label": "Divergence",
      "dataIndices": [5],
      "color": "#FF4D4F",
      "direction": "down"
    }
  ],

  "guides": [
    {
      "guideType": "line",
      "axis": "y",
      "value": 0.0,
      "label": "Zero Line",
      "color": "#FAAD14",
      "strokeStyle": "solid"
    }
  ],

  "overlays": []
}''';

// ═══════════════════════════════════════════════════════════════════════════════
// 10. BOLLINGER BANDS - Volatilite göstergesi
// ═══════════════════════════════════════════════════════════════════════════════

const String bollingerBandsExample = '''{
  "metadata": {
    "id": "bb_eth_4h",
    "name": "Bollinger Bands",
    "shortName": "BB",
    "description": "Bollinger Bands on Ethereum 4H",
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
      "value": 20,
      "min": 5,
      "max": 50,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Standard Deviations",
      "key": "stdDev",
      "valueType": "double",
      "value": 2.0,
      "min": 1.0,
      "max": 3.0,
      "showInLegendType": "onlyValue"
    }
  ],

  "fields": [
    {
      "name": "Date",
      "key": "date",
      "valueType": "timestamp",
      "axis": "x",
      "showInLegendType": "hidden",
      "format": "YYYY-MM-DD HH:00"
    },
    {
      "name": "Upper Band",
      "key": "upperBand",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Middle Band",
      "key": "middleBand",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    },
    {
      "name": "Lower Band",
      "key": "lowerBand",
      "valueType": "double",
      "axis": "y",
      "showInLegendType": "nameAndValue"
    }
  ],

  "plots": [
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "upperBand",
      "color": "#FF7A00"
    },
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "middleBand",
      "color": "#1890FF"
    },
    {
      "plotType": "line",
      "fieldKeyX": "date",
      "fieldKeyY": "lowerBand",
      "color": "#FF7A00"
    }
  ],

  "data": [
    ["2024-01-11 00:00", 2520.5, 2485.3, 2450.1],
    ["2024-01-11 04:00", 2535.2, 2500.8, 2466.4],
    ["2024-01-11 08:00", 2550.1, 2515.2, 2480.3],
    ["2024-01-11 12:00", 2565.8, 2530.5, 2495.2],
    ["2024-01-11 16:00", 2575.3, 2540.1, 2504.9],
    ["2024-01-11 20:00", 2585.2, 2550.8, 2516.4],
    ["2024-01-12 00:00", 2595.1, 2560.2, 2525.3]
  ],

  "notations": [
    {
      "shape": "circle",
      "label": "Overbought",
      "dataIndices": [5],
      "color": "#FF4D4F",
      "direction": "up"
    }
  ],

  "guides": [],

  "overlays": []
}''';
