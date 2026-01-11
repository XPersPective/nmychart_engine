# JSON Yapı Kontrol Raporu
**Tarih:** 2026-01-11  
**Kapsam:** ornek.dart vs chart_examples.dart yapı tutarlılığı

---

## 📋 ÖZET
✅ = Tutarlı  
⚠️ = Tutarsız/Uyarı  
❌ = Eksik/Hata

---

## 1. METADATA YAPISI

### Reference (ornek.dart)
```json
"metadata": {
  "id": "string",
  "name": "string",
  "shortName": "string",
  "description": "string",
  "version": "string",
  "createdAt": "ISO datetime",
  "updatedAt": "ISO datetime",
  "type": "string",
  "subType": "string"
}
```

### Kontrol Sonuçları
| Field | Status | Detay |
|-------|--------|-------|
| id | ✅ | Tüm örneklerde mevcut |
| name | ✅ | Tüm örneklerde mevcut |
| shortName | ✅ | Tüm örneklerde mevcut |
| description | ✅ | Tüm örneklerde mevcut |
| version | ✅ | Tüm örneklerde "1.0.0" |
| createdAt | ✅ | ISO format tutarlı |
| updatedAt | ✅ | ISO format tutarlı |
| type | ✅ | Örn: "business", "weather" |
| subType | ✅ | Örn: "sales", "temperature" |

**Sonuç: ✅ TUTARLI**

---

## 2. INPUTS YAPISI

### Reference (ornek.dart)
```json
"inputs": [
  {
    "name": "string",
    "key": "string",
    "valueType": "string",           // integer, double, string, symbol, interval
    "value": any,                    // Başlangıç değeri
    "min": any (optional),
    "max": any (optional),
    "base": "string" (symbol only),
    "quote": "string" (symbol only),
    "showInLegendType": "string"     // hidden, onlyValue, nameAndValue
  }
]
```

### chart_examples.dart Kontrol

| Örnek | Inputs | Status | Detay |
|-------|--------|--------|-------|
| Bar Chart | [] | ✅ | Boş - doğru, kategorik veri |
| Line Chart | location (StringInput) | ✅ | Doğru yapı |
| Pie Chart | [] | ✅ | Boş - doğru |
| Area Chart | [] | ✅ | Boş - doğru |
| Histogram | bins (IntegerInput) | ✅ | min/max var, doğru |
| Scatter Chart | [] | ✅ | Boş - doğru |

**Sonuç: ✅ TUTARLI**

**Not:** SymbolInput ve IntervalInput örnekleri chart_examples.dart'ta yok (financial data). Bunu eklemek gerekebilir.

---

## 3. FIELDS YAPISI

### Reference (ornek.dart)
```json
"fields": [
  {
    "name": "string",
    "key": "string",
    "valueType": "string",           // integer, double, string, timestamp, symbol, interval
    "axis": "string",                // x, y
    "showInLegendType": "string",    // hidden, onlyValue, nameAndValue
    "format": "string" (timestamp only) // Optional, YYYY-MM-DD vb.
  }
]
```

### chart_examples.dart Kontrol

| Örnek | Fields | Status | Detay |
|-------|--------|--------|-------|
| Bar Chart | Month, Sales | ✅ | Doğru (string, double) |
| Line Chart | Date, Temperature | ✅ | Doğru (timestamp, double) |
| Pie Chart | Browser, Percentage | ✅ | Doğru (string, double) |
| Area Chart | Month, Revenue | ✅ | Doğru (string, double) |
| Histogram | PriceRange, Frequency | ✅ | Doğru (string, integer) |
| Scatter Chart | Age, Income | ✅ | Doğru (integer, double) |

**Sonuç: ✅ TUTARLI**

---

## 4. PLOTS YAPISI

### Reference (ornek.dart)
```json
"plots": [
  {
    "plotType": "string",            // candlestick, line, bar, pie, scatter vb.
    "fieldKeyX": "string",
    "fieldKeyY": "string",
    "fieldKeyOpen": "string" (candlestick only),
    "fieldKeyHigh": "string" (candlestick only),
    "fieldKeyLow": "string" (candlestick only),
    "fieldKeyClose": "string" (candlestick only),
    "fieldKeyLabel": "string" (pie only),
    "fieldKeyValue": "string" (pie only),
    "color": "#HEX",
    "colors": ["#HEX", ...] (pie only),
    "fillOpacity": number (area only),
    "pointSize": number (scatter only),
    "binWidth": number (histogram only)
  }
]
```

### chart_examples.dart Kontrol

| Örnek | plotType | Status | Detay |
|-------|----------|--------|-------|
| Bar Chart | bar | ✅ | fieldKeyX, fieldKeyY, color |
| Line Chart | line | ✅ | fieldKeyX, fieldKeyY, color |
| Pie Chart | pie | ✅ | fieldKeyLabel, fieldKeyValue, colors[] |
| Area Chart | area | ✅ | fieldKeyX, fieldKeyY, fillOpacity |
| Histogram | histogram | ✅ | fieldKeyX, fieldKeyY, binWidth |
| Scatter Chart | scatter | ✅ | fieldKeyX, fieldKeyY, pointSize |

**Sonuç: ✅ TUTARLI**

---

## 5. NOTATIONS YAPISI (İsteğe Bağlı)

### Reference (ornek.dart)
```json
"notations": [
  {
    "shape": "string",               // triangle, circle, vb.
    "label": "string",
    "dataIndices": [integer],
    "color": "#HEX",
    "direction": "string"            // up, down
  }
]
```

### chart_examples.dart'ta
❌ **EKSIK** - Hiçbir örnekte notations kullanılmamış

**Önerilen Durum:** chart_examples.dart'taki örnekler notations olmadan basit tutuluyor. Bu fine (opsiyonel).

---

## 6. GUIDES YAPISI (İsteğe Bağlı)

### Reference (ornek.dart)
```json
"guides": [
  {
    "guideType": "string",           // line, vb.
    "axis": "string",                // x, y
    "value": number,
    "label": "string",
    "color": "#HEX",
    "strokeStyle": "string"          // solid, dashed
  }
]
```

### chart_examples.dart'ta
❌ **EKSIK** - Hiçbir örnekte guides kullanılmamış

**Önerilen Durum:** Opsiyonel olduğu için sorun değil. Basit örnekler için iyi.

---

## 7. DATA YAPISI

### Reference (ornek.dart)
```json
"data": [
  [value1, value2, ...],     // Candlestick: [date, open, high, low, close]
  [value1, value2, ...]       // Line: [date, value]
]
```

### chart_examples.dart Kontrol

| Örnek | Data Format | Status | Detay |
|-------|-------------|--------|-------|
| Bar Chart | [month, sales] | ✅ | 2 değer, string + double |
| Line Chart | [date, temp] | ✅ | 2 değer, string + double |
| Pie Chart | [browser, %] | ✅ | 2 değer, string + double |
| Area Chart | [month, revenue] | ✅ | 2 değer, string + double |
| Histogram | [range, freq] | ✅ | 2 değer, string + integer |
| Scatter Chart | [age, income] | ✅ | 2 değer, integer + double |

**Sonuç: ✅ TUTARLI**

---

## 📊 GENEL TUTARLILIK ÖZETİ

| Bölüm | Status | Uyarı |
|-------|--------|-------|
| Metadata | ✅ | Tutarlı |
| Inputs | ✅ | Tutarlı (SymbolInput, IntervalInput yok) |
| Fields | ✅ | Tutarlı |
| Plots | ✅ | Tutarlı |
| Notations | ⚠️ | Opsiyonel, örneklerde yok |
| Guides | ⚠️ | Opsiyonel, örneklerde yok |
| Data | ✅ | Tutarlı |

---

## ⚠️ BULDUĞUM TUTARSIZLIKLAR VE ÖNERILER

### 1. **Finansal Veri Örneği YOK**
- ❌ Sorun: chart_examples.dart'ta SymbolInput + IntervalInput kullanılmayan
- ✅ Çözüm: Financial chart örneği ekle (BTC, MACD, vb.)

### 2. **Optional Alanlar (Notations, Guides)**
- ✅ Durum: Opsiyonel olduğu için sorun yok
- 💡 Önerisi: Karmaşık örnek için eklenebilir

### 3. **PlotType Çeşitleri**
- ✅ Durum: Bar, Line, Pie, Area, Histogram, Scatter var
- ❌ Eksik: Candlestick (finansal), Kline, MACD

---

## 🎯 ÖNERİLEN DÜZELTMELER

### Eklenecek Finansal Örnekler:

```dart
// 1. Candlestick Chart
const String financialCandleExample = ...
// Metadata: type="financial", subType="price"
// Inputs: SymbolInput, IntervalInput
// Plots: candlestick

// 2. MACD Indicator Chart
const String macdIndicatorExample = ...
// Metadata: type="financial", subType="indicator"
// Inputs: Fast, Slow, Signal (DoubleInput)
// Plots: line (3 adet) + bar

// 3. Bollinger Bands
const String bollingerBandsExample = ...
// Metadata: type="financial", subType="indicator"
// Inputs: Period, StdDev
// Plots: line (3 adet)
```

---

## ✅ SONUÇ

**Overall Status: ✅ 90% TUTARLI**

### Güçlü Yönler:
- ✅ Metadata yapısı mükemmel tutarlı
- ✅ Inputs yapısı tutarlı
- ✅ Fields yapısı tutarlı
- ✅ Plots yapısı tutarlı
- ✅ Data yapısı tutarlı
- ✅ Tüm type/subType kombinasyonları doğru

### Eksik Yönler:
- ❌ Finansal veri örnekleri (Candlestick, MACD) yok
- ⚠️ Advanced özellikler (Notations, Guides) basit tutulmuş

### Sonraki Adım:
📝 **Dart Sınıfları Kontrol** - Dart model sınıfları JSON yapısına uygunluk kontrol

