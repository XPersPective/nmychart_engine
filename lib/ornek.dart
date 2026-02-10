/*
═══════════════════════════════════════════════════════════════════════════════
  Example 1: SMA Indicator (Simple Moving Average)
═══════════════════════════════════════════════════════════════════════════════

Type: financial
SubType: indicator

*/
///////////////////////////////////////////////////////////////////////////////

List<List<Map<String, dynamic>>> financialMapList = [
  [{}, {}, {}],
  [{}, {}, {}],
  [{}, {}, {}],
  [{}, {}, {}],
];

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
    menuBar:{
      "show": true,
      "position": "top"
  },
manuBar:None,

  "inputs": [
    {
      "name": "Period",
      "key": "period",
      "type": "integer",
      "value": 14,
      "min": 2,
      "max": 100,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Smoothing",
      "key": "smoothing",
      "type": "double",
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

///////////////////////////////////////////////////////////////////////////////
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
      "type": "integer",
      "value": 14,
      "min": 2,
      "max": 100,
      "showInLegendType": "onlyValue"
    },
    {
      "name": "Smoothing",
      "key": "smoothing",
      "type": "double",
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

/* Problem Tanımı ve Çözüm Mimarisi (Kopyalanabilir Metin)
Konu: Flutter Tabanlı Grafik Motoru İçin Dinamik Veri Bağlama (Data Binding) Protokolü Tasarımı

Mevcut Durum: Flutter ile geliştirilen, tamamen JSON tabanlı konfigürasyonlarla yönetilen (Data-Driven) bir Finansal Grafik Motoru (Charting Library) tasarlıyorum. Bu sistemde indikatörlerin (örneğin SMA, RSI) tüm özellikleri (hesaplama parametreleri, görsel stiller, veri setleri) sunucudan gelen statik bir JSON dosyası ile tanımlanıyor.

Çözülmesi Beklenen Problem: Statik JSON yapısı içerisindeki metin alanlarının (örneğin Lejant etiketleri, Tooltip açıklamaları veya Grafik üzerindeki notasyonlar), çalışma zamanında (runtime) değişen dinamik verilere erişebilmesi gerekmektedir.

Örneğin:

Kullanıcı "Periyot" inputunu 14'ten 20'ye değiştirdiğinde, lejanttaki metin otomatik olarak "SMA (14)" yerine "SMA (20)" olmalıdır.
Grafik üzerindeki bir etikette, o anki son fiyat veya hesaplanan indikatör değeri (örneğin RSI: 70.5) dinamik olarak gösterilmelidir.
Beklenti: Hem son kullanıcı (veya JSON'ı düzenleyen kişi) için okunabilir ve basit, hem de yazılım tarafında (Parser) standart, hatasız ve genişletilebilir bir Erişim Sözdizimi (Access Syntax) geliştirmek.

✅ Önerilen Çözüm Protokolü: {{Scope.Key.Property}}
Bu problemi çözmek için Mustache-style (çift süslü parantez) interpolasyon kullanan, nokta notasyonu ile hiyerarşik erişim sağlayan bir standart belirlenmiştir.

Sözdizimi: {{Kapsam.Anahtar.Özellik}}

Yapı:

Scope (Kapsam): Verinin kaynağını belirtir (inputs, data, meta vb.).
Key (Anahtar): İlgili veri objesinin benzersiz kimliğidir (period, sma, close vb.).
Property (Özellik): Objenin hangi değerinin istendiği (value, name, last vb.).
Örnek Kullanım Senaryoları:

Input Değerine Erişim:

Senaryo: "Periyot" parametresini metin içinde göstermek.
Kod: {{inputs.period.value}} → Çıktı: 14
Veri Serisine Erişim:

Senaryo: Hesaplanan SMA indikatörünün son değerini göstermek.
Kod: {{data.sma.last}} → Çıktı: 156.2
Metadata Erişim:

Senaryo: İndikatörün tam adını başlıkta kullanmak.
Kod: {{meta.name}} → Çıktı: Simple Moving Average
Teknik Avantajlar:

Parsing Kolaylığı: Regex veya String Split ile kolayca . (nokta) karakterinden parçalanıp işlenebilir.
Tip Güvenliği: Kapsamlar (inputs, data) belli olduğu için yanlış veri çağırımları (örneğin data içinde input aramak) önlenir.
Okunabilirlik: JSON'ı okuyan bir insan, {{inputs.period.value}} gördüğünde bunun "Inputlar içindeki period'un değeri" olduğunu hemen anlar.
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

  "rules": [
    {
      "id": "trendRule",
      "logic": {
        "positive": "@data.close.value > data.open",
        "negative": "data.close < data.open"
      }
    }
  ],
  "styles": [
    { "id": "bullGreen", "color": "#00FF00" },
    { "id": "bearRed", "color": "#FF0000" },
    { "id": "neutralGray", "color": "#888888" }
  ],
  
  legand: [
  { 
    "label": "{{inputs.symbol.value}}",
    "color": {  "type": "static", "style": "neutralGray" },"
  }
  
  ]
  
  
  
  "{{inputs.symbol.value}} {{inputs.interval.value}} {{data.close.value,
   color: pilots.candlestick.conditions[0].color}}",


  "inputs": [
    {
      "name": "Symbol",
      "key": "symbol",
      "valueType": "symbol",
      "value": "BTC/USDT",
      "base": "BTC",
      "quote": "USDT",
      "showInLegendType": "nameAndValue"
    },"inputs": [
  {
    "id": "textExample",
    "name": "Text Example",
    "type": "string",
    "value": "Sample Text"
  },
  {
    "id": "symbol",
    "name": "Symbol",
    "type": "symbol",
    "value": "BTC/USDT",
    "base": "BTC",
    "quote": "USDT"
  },
  {
    "id": "interval",
    "name": "Interval",
    "type": "interval",
    "value": "4h"
  },
  {
    "id": "period",
    "name": "Period",
    "type": "integer",
    "value": 14,
    "min": 2,
    "max": 100
  },
  {
    "id": "smoothing",
    "name": "Smoothing",
    "type": "double",
    "value": 0.5,
    "min": 0.0,
    "max": 1.0
  },
  {
    "id": "showLine",
    "name": "Show Line",
    "type": "boolean",
    "value": true
  },
  {
    "id": "startDate",
    "name": "Start Date",
    "type": "date",
    "value": "2026-02-10",
    "format": "YYYY-MM-DD",
    "unit": "iso"
  },
  {
    "id": "endDateMillis",
    "name": "End Date Milliseconds",
    "type": "date",
    "value": 1676985600000,
    "format": "milliseconds",
    "unit": "ms"
  },
  {
    "id": "endDateSeconds",
    "name": "End Date Seconds",
    "type": "date",
    "value": 1676985600,
    "format": "seconds",
    "unit": "s"
  }
]

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
      "color": {
  "type": "rule",
  "rule": "trendState",
  "positive": "bullGreen", // ID referansı
  "negative": "bearRed",
  "neutral": "standardBlue"
}
    },
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
  "color": {
  "type": "static",
  "style": "neutralGray" // ID referansı
},
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
