var sonSurum = {
  "metadata": {
    "id": "unique_chart_id_123",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "symbol": "BTC/USDT",
    "interval": "1h",
    "plotType": "line",
    "layoutType": "financial",
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
          "author": "anonymous",
          "version": "1.0.0",
          "createdAt": "2026-01-11T10:00:00Z",
          "updatedAt": "2026-01-11T10:00:00Z",
        },
        "legend": [
          {
            "label": "@inputs.symbol.value",
            "color": "@styles.neutralGray.color",
          },
          {
            "label": "@inputs.interval.value",
            "color": "@styles.neutralGray.color",
          },
          {
            "label": "@fields.close.value[-1]",
            "style":
                "@rules.trendRule(@styles.bullGreen, @styles.bearRed, @styles.neutralGray)",
          },
          {},
          {},
        ],
        "inputs": [{}, {}, {}],
        "fields": [{}, {}, {}],
        "data": [[], [], []],
        "plots": [{}, {}, {}],
        "guides": [{}, {}, {}],
        "notations": [{}, {}, {}],
        "rules": [
          {
            "id": "trendRule",
            "positive": "@fields.clos.value > @fields.open.value",
            "negative": "@fields.clos.value <= @fields.open.value",
            "neutral": "@fields.clos.value == @fields.open.value",
          },
          {},
          {},
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
  
  "rules": [
    {
      "id": "trendRule",
      "logic": {
        "positive": "@fields.close.value > @fields.open.value",
        "negative": "@fields.close.value <= @fields.open.value",
        "neutral": "@fields.close.value == "@fields.open.value",
      }
    }
  ],

  "styles": [
    { "id": "bullGreen", "color": "#00FF00" },
    { "id": "bearRed", "color": "#FF0000" },
    { "id": "neutralGray", "color": "#888888" }
  ],

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
