# Değişiklik Açıklaması - JSON Şeması Düzeltme

## Problem
Kendi kafama göre JSON örneklerine gereksiz alanlar eklemiştim. Senin şemandan farklı hale gelmişti.

---

## Üç Ana Hata

### 1. **`index` Alanı - Niye Kaldırdığımız?**

```json
// ❌ YANLIŞ (benim yaptığım)
"fields": [
  {"key": "date", "index": 0},     // ← Redundant!
  {"key": "open", "index": 1},     // ← Redundant!
  {"key": "high", "index": 2},     // ← Redundant!
]

// ✅ DOĞRU (senin şemanın)
"fields": [
  {"key": "date"},      // Sıra otomatik = index 0
  {"key": "open"},      // Sıra otomatik = index 1
  {"key": "high"},      // Sıra otomatik = index 2
]
```

**Mantık**: 
- Data array'de veri zaten sırayla duruyordu: `[timestamp, open, high, low, close]`
- Fields array'de de aynı sırayla `[date, open, high, low, close]` yazıyoruz
- Index'i hem data hem fields'a yazmak **DUPLICATE** bilgi = kötü tasarım
- Eğer field sırasını değiştirirsek, index'i de güncellemeli oluruz (hata riski)

---

### 2. **`type` ve `valueType` - İkisinin Farkı?**

```json
// ❌ YANLIŞ (benim yaptığım)
{
  "key": "open",
  "type": "number",         // ← Bunu kaldırdık
  "valueType": "double"     // ← Bunu tutuyoruz
}

// ✅ DOĞRU (senin şemanın)
{
  "key": "open",
  "valueType": "double"     // ← Tek bir alan
}
```

**Niye bu karışıklık yaptım?** Aynı bilgiyi iki defa gösterdim:
- `type` (ChartFieldType enum): string, number, date, boolean, timestamp, double, integer
- `valueType` (ValueType enum): integer, double, string, boolean, timestamp

Bunlar DUPLICATE! Sadece `valueType` kullanmalıyız.

---

### 3. **`format` Alanı - Neden Sadece Timestamp'da?**

```json
// ❌ YANLIŞ (benim yaptığım)
{
  "key": "open",
  "valueType": "double",
  "format": ".2f"           // ← Double'da format ne işe yarar?
}

// ✅ DOĞRU (senin şemanın)
{
  "key": "open",
  "valueType": "double"     // ← Format olmadan
}

{
  "key": "timestamp",
  "valueType": "timestamp",
  "format": "milliseconds"  // ← Format SADECE timestamp için
}
```

**Mantık**:
- **Timestamp** → `format` gerekli: "milliseconds", "seconds", "iso8601", vs.
- **Double, integer, string** → Format bilgisinin JSON'da ne işi var? 
- UI/rendering'de gerekirse orada ayarlarız, JSON'da olması gereksiz

---

## Değişen Dosyalar

### `lib/models/chart_field.dart`
```dart
// BEFORE: ChartFieldType enum (8 değer) + index field + format her zaman
// AFTER: Sadece ValueType enum (5 değer) + format sadece timestamp'da
class ChartField {
  final String name;
  final String key;
  final ValueType valueType;      // ← Sadece bu!
  final String axis;
  final bool showInLegend;
  final String? format;            // ← Assertion: sadece timestamp'da olur
  
  // NO index field!
}
```

### `lib/json_examples.dart`
3 örnek JSON güncellendi:
- `completeChartJson` - Tüm features ile
- `lineChartJson` - Basit line chart
- `candlestickChartJson` - OHLC örneği

Hepsi artık senin şemaya **tam olarak** uyuyor.

---

## Sonuç

| Alan | Niye Kaldırıldı | Mantık |
|------|-----------------|--------|
| `index` | Redundant | Array sırası otomatik |
| `type` | Duplicate | `valueType` yeterli |
| `format` (double'da) | Gereksiz | Format sadece timestamp'da |

✅ **Şimdi JSON şemanız 100% clean ve senin dokümantasyonunla eşleşiyor!**
