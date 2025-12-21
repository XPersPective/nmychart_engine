final json = {
  "id": "indicator.macd.v1",
  "name": "Moving Average Convergence Divergence",
  "short_name": "MACD",
  "description":
      "MACD is a trend-following momentum indicator that shows the relationship between two moving averages of a security’s price.",
  "category": "Trend",
  "author": "Gerald Appel",
  "version": "1.0.0",
  "fields": [
    {
      "axis": "x",
      "index": 0,
      "key": "timestamp",
      "name": "Time",
      "type": "time",
      "format": "millisecond",
    },
    {
      "axis": "y",
      "index": 1,
      "key": "macd",
      "name": "Macd Line",
      "type": "number",
    },
    {
      "axis": "y",
      "index": 2,
      "key": "signal",
      "name": "Signal Line",
      "type": "number",
    },
    {
      "axis": "y",
      "index": 3,
      "key": "histogram",
      "name": "Histogram",
      "type": "number",
    },
  ],
  "data": [
    [1622505600000, 1.5, 1.2, 0.3],
    [1622592000000, 1.7, 1.3, 0.4],
    [1622678400000, 1.6, 1.4, 0.2],
  ],
  "plots": [
    {"type": "line", "fieldIndex": "1", "color": "#FF0000"},
    {"type": "line", "fieldIndex": "2", "color": "#0000FF"},
    {
      "type": "bar",
      "fieldIndex": "3",
      "style": {
        "condition": {
          "value1": {"type": "fieldIndex", "index": 1},
          "type": "greater_than",
          "value2": {"type": "value", "value": 0},
          "result": {
            "true": {"color": "#4CAF50"},
            "false": {"color": "#F44336"},
            "default": {"color": "#F44336"},
          },
        },
      },
    },
  ],
};
  

 
// chart
// main
// overflow
// subpanel

