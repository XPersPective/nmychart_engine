var sonSurum = {
  "metadata": {
    "id": "unique_chart_id_123",
    "createdAt": 1676985600000,
    "updatedAt": 1676998900000,
    "symbol": "BTC/USDT",
    "interval": "1h",
    "plotType": "line",
    "layoutType": "financial",
    "axisConfig": {
      "baseAxis": "x",
      "baseAxisType": "date",
      "valueAxisType": "double",
    },
  },
  "charts": [
    [
      {
        "metadata": {
          "id": "ohlc_001",
          "name": "Open-High-Low-Close",
          "shortName": "OHLC",
          "description": "Financial price chart",
          "type": "financial",
          "category": "price",
          "renderMode": "separate",
          "provider": "system",
          "visibility": "public",
          "axisConfig": {
            "baseAxis": "x",
            "baseAxisType": "date",
            "valueAxisType": "double",
          },
          "author": "anonymous",
          "version": "1.0.0",
          "createdAt": 1676985600000,
          "updatedAt": 1676998700000,
        },
        "legend": [
          {
            "text": "@inputs.symbol.value",
            "color": "@styles.neutralGray.color",
          },
          {"text": "@inputs.interval.value", "color": "#3FA7D6"},
          {
            "text": "@fields.close.value",
            "color":
                "@rules.trendRule(@styles.bullGreen.color, @styles.bearRed.color, @styles.neutralGray.color)",
          },
        ],
        "inputs": [
          {
            "id": "textExample",
            "name": "Text Example",
            "type": "string",
            "value": "Sample Text",
          },
          {
            "id": "symbol",
            "name": "Symbol",
            "type": "symbol",
            "value": "BTC/USDT",
            "base": "BTC",
            "quote": "USDT",
          },
          {
            "id": "interval",
            "name": "Interval",
            "type": "interval",
            "value": "4h",
          },
          {
            "id": "period",
            "name": "Period",
            "type": "integer",
            "value": 14,
            "min": null,
            "max": null,
          },
          {
            "id": "smoothing",
            "name": "Smoothing",
            "type": "double",
            "value": 0.5,
            "min": 0.0,
            "max": 1.0,
          },
          {
            "id": "showLine",
            "name": "Show Line",
            "type": "boolean",
            "value": true,
          },
          {
            "id": "time",
            "name": "Start time",
            "type": "date",
            "value": 1676985600000,
          },
        ],
        "fields": [
          {"id": "date", "name": "Close Time", "type": "date", "axis": "x"},
          {"id": "close", "name": "Close", "type": "integer", "axis": "y"},
          {"id": "close", "name": "Close", "type": "double", "axis": "y"},
          {"id": "signal", "name": "Signal", "type": "string", "axis": "y"},
          {"id": "istrend", "name": "IsTrend", "type": "boolean", "axis": "y"},
        ],
        "data": [[], [], []],
        "plots": [
          {
            "id": "plot_id0",
            "type": "line",
            "dataForm": "scalar",
            "axisConfig": {
              "baseAxis": "x",
              "baseAxisType": "date",
              "valueAxisType": "double",
            },
            "x": "@fields.date.value",
            "y": "@fields.ma.value",
            "color": "#1890FF",
          },
          {
            "id": "plot_id1",
            "type": "area",
            "dataForm": "signedScalar",
            "axisConfig": {
              "baseAxis": "x",
              "baseAxisType": "date",
              "valueAxisType": "double",
            },
            "x": "@fields.date.value",
            "y": "@fields.ma.value",
            "color": "#1890FF",
          },
          {
            "id": "plot_id2",
            "type": "candlestick",
            "dataForm": "ohlc",
            "axisConfig": {
              "baseAxis": "x",
              "baseAxisType": "date",
              "valueAxisType": "double",
            },
            "x": "@fields.date.value",
            "open": "@fields.open.value",
            "high": "@fields.high.value",
            "low": "@fields.low.value",
            "close": "@fields.close.value",
            "color":
                "@rules.candlestick(@styles.bullGreen.color,@styles.bearRed.color,@styles.neutralGray.color)",
          },
          {
            "id": "plot_id3",
            "type": "bar",
            "dataForm": "scalar",
            "axisConfig": {
              "baseAxis": "x",
              "baseAxisType": "date",
              "valueAxisType": "double",
            },
            "x": "@fields.date.value",
            "y": "@fields.month.value",
            "color": "#1890FF",
          },
          {
            "id": "plot_id_band",
            "type": "band",
            "dataForm": "band",
            "axisConfig": {
              "baseAxis": "x",
              "baseAxisType": "date",
              "valueAxisType": "double",
            },
            "x": "@fields.date.value",
            "upper": "@fields.bb_upper.value",
            "lower": "@fields.bb_lower.value",
            "upperColor": "@styles.upper.color",
            "lowerColor": "@styles.lower.color",
            "fillColor": "@styles.fill.color",
          },
        ],
        "guides": [
          {
            "id": "guide_id_line",
            "type": "line",
            "axis": "y",
            "valueType": "double",
            "title": "Support",
            "value": 30.0,
            "color": "#52C41A",
            "strokeStyle": "dashed",
          },
          {
            "id": "guide_id_band",
            "type": "band",
            "axis": "y",
            "valueType": "double",
            "upperValue": 80.0,
            "lowerValue": 30.0,
            "upperTitle": "Resistance",
            "lowerTitle": "Support",
            "upperColor": "@styles.upper.color",
            "lowerColor": "@styles.lower.color",
            "fillColor": "@styles.fill.color",
            "strokeStyle": "dashed",
          },
        ],
        "notations": [
          {
            "id": "notation_id",
            "axis": "y",
            "valueType": "double",
            "title": "Signal Entry",
            "value": 30.0,
            "style":
                "@rules.candlestick(@styles.bullGreen,@styles.bearRed,@styles.neutralGray)",
          },
        ],
        "rules": [
          {
            "id": "trendRule",
            "positive": "@fields.clos.value > @fields.open.value",
            "negative": "@fields.clos.value <= @fields.open.value",
            "neutral": "@fields.clos.value == @fields.open.value",
          },
        ],
        "styles": [
          {"id": "bullGreen", "color": "#00FF00"},
          {"id": "bearRed", "color": "#FF0000"},
          {"id": "neutralGray", "color": "#888888"},
        ],
      },
      {},
      {},
    ],
    [{}, {}, {}],
    [{}, {}, {}],
    [{}, {}, {}],
  ],
};

/*
 
 
  "legend": [ 
    { "text": "@inputs.symbol.value", style: "" },
    { "text": "@inputs.interval.value", color: "@styles.neutralGray.color" },
  {
    "text": "@fields.close.value[-1]",
    "style": "@rules.trendRule(@styles.bullGreen,@styles.bearRed,@styles.neutralGray)"
  }
  ],

  *******
  bu serverde donusum iin saklanır ve froenddte menu donusumleri için saklanır orgindataform capalityes tir
"valueTypes": {
    "scalar": {
      "capabilities": ["line", "area"]
    },

    "signedScalar": {
      "capabilities": ["line", "area", "histogram"]
    },

    "ohlc": {
      "requires": ["open", "high", "low", "close"],
      "capabilities": ["candlestick", "bar", "line"]
    }
  },
*********
  "inputs": [
    {
      "name": "Symbol",
      "key": "symbol",
      "valueType": "symbol",
      "value": "BTC/USDT",
      "base": "BTC",
      "quote": "USDT",
 
    },
    {
      "name": "Interval",
      "key": "interval",
      "valueType": "interval",
      "value": "1h",
 
    }
  ],

  "plots": [
    { 
    "originForm": "ohlc",          // Veri formu
      "plotType": "candlestick",
      "date": "@field.date.value",
      "open": "@field.date.open",
      "high": "@field.date.high", 
      "low": "@field.date.low", 
      "close": "@field.date.close", 
      "style":"@rules.trendRule(@styles.bullGreen,@styles.bearRed,@styles.neutralGray)"  
    }
  ],

  "fields": [
    { "key": "date", "valueType": "timestamp" },
    { "key": "open", "valueType": "double" },
    { "key": "high", "valueType": "double" },
    { "key": "low", "valueType": "double" },
    { "key": "close", "valueType": "double" }
  ],

  "data": {
    "ohlc": {
      "open": 42300,
      "high": 42600,
      "low": 42200,
      "close": 42500
    }
  }
}
```

---

## Sorunlar Listesi
 

---

## Çözümler Listesi

1. **Referans kuralı:**
   Referans içeren tüm değerler `@` ile başlar.

2. **Derinlik kuralı:**
   Referans formatı **sabit 3 seviyedir**:
   `@scope.id.property`

3. **Scope sınırı:**
   İzinli scope’lar nettir:
   `inputs`, `data`, `styles`, `rules`

4. **Parser basitleştirme:**
   `@` yoksa → literal
   `@` varsa → resolver çalıştır
   `@rules`ile başlıyor ise →"@rules.trendRule(@styles.bullGreen,@styles.bearRed,@styles.neutralGray)" yapısı çalışır

5.   rules yani   kuralların yapısı tek bir şekildedir ya içerisinde referans data alır veyahutta bir değer alır bu değerde double  türdedir dolayısıyla rules şartları karşılaştırmaları double türünde değerleri karşılaştırır.

6. Diğer kural herhangi bir veri yapısına yani herhangi bir data verisine erişmek için field. IS. Özel nokta value şeklinde erişilir vali onun sonuna köşeli parantez ile sıfırdan [-1] gibi    bir değer verilebilir bu da  periyodları serinin o kadar ileride veya geride(-) periyotlarında karşılık gelir kısacası data içinde  bir veriye  felds.id.value[0]  ile erişilebilir direkt at data diye kullanımı yoktur
7.
*/
