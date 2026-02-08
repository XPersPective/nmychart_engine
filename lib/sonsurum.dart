/*
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

 

"menuBar": {
    "id": "mainMenuBar",
    "position": "top",  // Menü çubuğunun yerleşim yeri: üstte, sağda, solda vb.
    "menus": [
      {
        "id": "chartShapeMenu",
        "type": "chartShape",
        "targetPilotId": "pilot_123",
        "options": ["candlestick", "line", "area", "bar"],
        "selectedType": "line"
      },
      {
        "id": "symbolMenu",
        "type": "symbol",
        "targetInputId": "symbolInput",
        "options": ["BTC/USDT", "ETH/USDT", "XRP/USDT"]  // Örnek semboller
      },
      {
        "id": "intervalMenu",
        "type": "interval",
        "targetInputId": "intervalInput",
        "options": ["1h", "1d", "1w"]  // Örnek zaman aralıkları
      },
      {
        "id": "indicatorMenu",
        "type": "indicator",
        "options": ["MACD", "RSI", "Bollinger Bands"]  // Örnek indikatörler
      }
    ]
  }

  "rules": [
    {
      "id": "trendRule",
      "logic": {
        "positive": "@fields.close.value > @fields.open.value",
        "negative": "@fields.close.value <= @fields.open.value",
        "neutral": "close == open"
      }
    }
  ],

  "styles": [
    { "id": "bullGreen", "color": "#00FF00" },
    { "id": "bearRed", "color": "#FF0000" },
    { "id": "neutralGray", "color": "#888888" }
  ],

  "legend": [
    { "text": "Parite" style: "" },
    { "text": "@inputs.symbol.value", style: "" },
    { "text": "@inputs.interval.value", style: "@styles.neutralGray" },
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
      "fieldKeyX": "date",
      "fieldKeyOpen": "open",
      "fieldKeyHigh": "high",
      "fieldKeyLow": "low",
      "fieldKeyClose": "close",
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

5. kural da eee condition yani rules yani kurallar kuralların yapısı tek bir şekildedir ya içerisinde referans data alır veyahutta bir değer alır bu değerde w türdedir dolayısıyla condition şartları karşılaştırmaları w türünde değerleri karşılaştırır.

6. Diğer kural herhangi bir veri yapısına yani herhangi bir data verisine erişmek için field. IS. Özel nokta value şeklinde erişilir vali onun sonuna köşeli parantez ile sıfırdan- bir eksi sonsuza kadar bir değer verilebilir bu da önceki periyodları serinin önceki periyotlarında karşılık gelir kısacası data için felt aids yine fill this lerden ids dataya erişilebilir direkt at data diye kullanımı yoktur
7.
*/
