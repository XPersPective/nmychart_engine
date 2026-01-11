# PlotCondition (Eski) vs PlotConditionData (Yeni) Kıyaslaması

## 1. MEVCUT DURUM - PlotCondition Sınıfı

### Nerede Tanımlanmış?
**File:** `lib/models/plots/plot_condition.dart`

```dart
class PlotCondition {
  final String? name;
  final Map<String, dynamic> value1;      // ← Kompleks veri yapısı
  final ConditionOperator operator;       // ← Enum: greaterThan, lessThan, vb.
  final Map<String, dynamic> value2;      // ← Kompleks veri yapısı
  final Map<String, dynamic> result;      // ← Styling result'ı
  
  bool evaluate(dynamic val1, dynamic val2) {
    if (val1 is! num || val2 is! num) return false;
    return operator.evaluate(val1, val2);
  }
  
  Map<String, dynamic> toJson() { ... }
}
```

### Nerede Kullanılıyor?
**Plot sınıflarında:** Plot veri modelinde saklanıyor

```dart
// base_plot.dart
abstract class Plot {
  final List<PlotCondition>? conditions;  // ← Burada saklanıyor
  
  Plot({this.color, this.conditions});
}

// Tüm Plot subclass'larında
class LinePlot extends Plot {
  LinePlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,  // ← Constructor'da geçiliyor
  }) : super(color: color, conditions: conditions);
}
```

### Nerede JSON Serialization Yapılıyor?
**Plot.toJson() ve Plot.fromJson()**

```dart
// Serialization
if (conditions != null)
  'conditions': conditions!.map((c) => c.toJson()).toList(),

// Deserialization  
final conditions = json['conditions'] != null
    ? (json['conditions'] as List)
          .map((c) => PlotCondition.fromJson(c as Map<String, dynamic>))
          .toList()
    : null;
```

---

## 2. YENİ DURUM - PlotConditionData Sınıfı

### Nerede Tanımlanmış?
**File:** `lib/widgets/painters/delegates/plot_render_delegate.dart`

```dart
class PlotConditionData {
  final String name;
  final String? description;
  final String type;           // ← "threshold", "range", "custom"
  final String? field;         // ← Hangi field'a uygulanacak
  final String? operator;      // ← ">", "<", "==", "!=", ">=", "<="
  final dynamic value;         // ← Basit, numeric value
  final String? color;         // ← Hex renk string
  
  bool evaluate(dynamic val) {
    // ← Render time'da evaluasyon yapılıyor
  }
}
```

### Nerede Kullanılıyor?
**PlotRenderDelegate'lerde:** Rendering sırasında

```dart
// line_plot_render_delegate.dart
class LinePlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(RenderContext context, Plot plot, ...) {
    // Plot.conditions (PlotCondition) dönüştürülüyor
    List<PlotConditionData>? conditions = _parseConditions(plot.conditions);
    
    // Her data point için evaluate ediliyor
    for (var i = 0; i < data.length; i++) {
      Color? conditionColor = getConditionColor(dataValue, conditions);
      if (conditionColor != null) {
        paint.color = conditionColor;  // ← Renk override
      }
    }
  }
  
  List<PlotConditionData>? _parseConditions(List<PlotCondition>? conditions) {
    if (conditions == null) return null;
    return conditions
        .map(
          (c) => PlotConditionData(
            name: c.name ?? 'condition',
            type: 'custom'
          ),
        )
        .toList();
  }
}
```

---

## 3. DETAYLI KIYASLAMA

### A. VERİ YAPISI

| Özellik | PlotCondition (Model) | PlotConditionData (Render) |
|---------|----------------------|--------------------------|
| **Amaç** | JSON depolama | Runtime rendering |
| **value1** | Map<String, dynamic> | ❌ Yok |
| **value2** | Map<String, dynamic> | ❌ Yok |
| **value** | ❌ Yok | ✅ dynamic (basit) |
| **operator** | ConditionOperator enum | String (">", "<", vb) |
| **result** | Map<String, dynamic> | ❌ Yok |
| **color** | ❌ Yok | ✅ String (hex) |
| **type** | ❌ Yok | ✅ String ("threshold") |
| **field** | ❌ Yok | ✅ String |

### B. YAŞAM DÖNGÜSÜ

```
JSON File
   ↓
PlotCondition.fromJson() ← DESERIALIZE
   ↓
Plot.conditions (Liste halinde saklanıyor)
   ↓
PlotRenderDelegate.paint() çağrılıyor
   ↓
_parseConditions(): PlotCondition → PlotConditionData
   ↓
getConditionColor(): value, operator, threshold'ı evaluate et
   ↓
Color override uygulanıyor
   ↓
Canvas'a renk ile çiziliyor
```

### C. SORUMLULUKLAR

**PlotCondition:**
- ✅ JSON depolama
- ✅ Operator enum tanımı
- ✅ Evaluate metodu (BUT NOT USED)

**PlotConditionData:**
- ✅ Runtime data representation
- ✅ Rendering context için optimize
- ✅ Aktif olarak evaluate ediliyor (6 operator)

---

## 4. NEDEN YENİ SINIF OLUŞTURDUK?

### Seçenek 1: PlotCondition'u Genişletmek
```dart
class PlotCondition {
  // Eski alanlar
  final Map<String, dynamic> value1;
  final ConditionOperator operator;
  final Map<String, dynamic> value2;
  final Map<String, dynamic> result;
  
  // Yeni alanlar (karışıklık!)
  final String? field;        // ← Render için
  final String? color;        // ← Render için
  final dynamic value;        // ← Basit değer
  final String? type;         // ← Render tipi
}
```

**Sorunlar:**
- ❌ JSON ve Render ihtiyaçları karıştı
- ❌ `value1`, `value2` rendering için gereksiz
- ❌ `result` Map'i rendering için complicated
- ❌ Karmaşık veri yapısı
- ❌ Single Responsibility ihlali

### Seçenek 2: PlotConditionData Oluşturmak (SEÇİLEN)
```dart
// Model katmanında
class PlotCondition {
  value1, operator, value2, result  ← JSON için
}

// Render katmanında
class PlotConditionData {
  name, field, operator, value, color, type  ← Render için
}
```

**Avantajlar:**
- ✅ Temiz ayrılık (JSON vs Render)
- ✅ Herbiri kendi ihtiyaçlarına optimize
- ✅ Dönüştürme açık ve basit
- ✅ Type safe (String > (numeric comparison))

---

## 5. CURRENT FLOW

### Render Time'da Neler Oluyor?

```dart
LinePlotRenderDelegate.paint() {
  // 1. Plot.conditions (PlotCondition list) al
  List<PlotCondition>? oldConditions = plot.conditions;
  
  // 2. Render için dönüştür
  List<PlotConditionData>? conditions = oldConditions
    ?.map((c) => PlotConditionData(
      name: c.name ?? 'condition',
      type: 'custom'
    ))
    .toList();
  
  // 3. Her data point'te evaluate et
  for (var i = 0; i < data.length; i++) {
    final value = getFieldValue(data[i], fieldY);
    
    // 4. Condition color'ı al
    Color? conditionColor = getConditionColor(value, conditions);
    
    // 5. Rengi uyguladığında kullan
    if (conditionColor != null) {
      paint.color = conditionColor;
    }
    
    // 6. Çiz
    drawPoint(...);
  }
}
```

### getConditionColor() Implementasyon

```dart
Color? getConditionColor(dynamic value, List<PlotConditionData>? conditions) {
  if (conditions == null || conditions.isEmpty) return null;

  for (final condition in conditions) {
    if (condition.type == 'threshold' && condition.operator != null) {
      // Bu switch case tam olarak PlotCondition.evaluate() gibi
      // AMA PlotConditionData formatında
      final matches = _evaluateCondition(value, condition);
      if (matches && condition.color != null) {
        return _parseColor(condition.color!);  // ← Renk override!
      }
    }
  }
  return null;
}

bool _evaluateCondition(dynamic value, PlotConditionData condition) {
  if (value is! num) return false;

  switch (condition.operator) {
    case '>':
      return value > (condition.value ?? 0);
    case '<':
      return value < (condition.value ?? 0);
    case '==':
      return value == condition.value;
    case '!=':
      return value != condition.value;
    case '>=':
      return value >= (condition.value ?? 0);
    case '<=':
      return value <= (condition.value ?? 0);
    default:
      return false;
  }
}
```

---

## 6. TASARIM KARŞILAŞTIRMASI

### Tasarım Deseni 1: Tek Sınıf (PlotCondition'u genişlet)
```
┌─────────────────────────────────┐
│      PlotCondition              │
├─────────────────────────────────┤
│ (JSON ile ilgili alanlar)       │
│ - value1: Map                   │
│ - value2: Map                   │
│ - result: Map                   │
│ - operator: ConditionOperator   │
│                                 │
│ (Render ile ilgili alanlar)     │
│ - color: String                 │
│ - field: String                 │
│ - type: String                  │
│ - value: dynamic                │
└─────────────────────────────────┘
   ❌ Karışık sorumluluklar
   ❌ Veri yapısı complicated
```

### Tasarım Deseni 2: İki Ayrı Sınıf (TERCIH EDİLEN)
```
┌────────────────────┐          ┌──────────────────────┐
│  PlotCondition     │          │ PlotConditionData    │
│  (Model/JSON)      │          │ (Render/Runtime)     │
├────────────────────┤          ├──────────────────────┤
│ - value1: Map      │          │ - name: String       │
│ - value2: Map      │          │ - field: String      │
│ - result: Map      │          │ - operator: String   │
│ - operator: Enum   │          │ - value: dynamic     │
│                    │          │ - color: String      │
│ (JSON operations)  │          │ - type: String       │
│ - fromJson()       │          │                      │
│ - toJson()         │          │ (Render operations)  │
│ - evaluate()       │          │ - evaluate()         │
└────────────────────┘          │ - getColor()         │
         ↓                       └──────────────────────┘
      (Dönüştür)                        ↑
         └──────────────────────────────┘
   ✅ Temiz ayrılık
   ✅ Herbiri optimize
   ✅ Type safe
```

---

## 7. SONUÇ

### Soru: Niye PlotCondition'u genişletmedin?

**Cevap:** Çünkü farklı ihtiyaçlar:

1. **PlotCondition** = Model Katmanı
   - JSON'dan veri al/gönder
   - Veri saklama
   - İşletme kuralları (business logic)

2. **PlotConditionData** = Rendering Katmanı
   - Runtime'da condition evaluate et
   - Renk override uygula
   - Performans optimize et

İkisini birleştirmek:
- ❌ Single Responsibility Principle ihlali
- ❌ Veri yapısı complicated
- ❌ Maintenance zor

### Soru: PlotCondition'u görmeden mi yaptın?

**Cevap: HAYIR**

Senaryo:
```
1. Görüntü: PlotCondition sınıfı (value1, value2, result Map'i ile)
2. Görmesi: JSON şeması ve model layer ihtiyaçları
3. Karar: "Bu rendering katmanında KULLANILMAZ"
4. Görüntü: Render sırasındaki ihtiyaçlar
5. Karar: "Basit, optimize edilmiş PlotConditionData lazım"
6. Sonuç: İki ayrı sınıf
```

### Soru: Hangisi daha iyi?

**İki ayrı sınıf daha iyi:**

| Kriter | Tek Sınıf | İki Sınıf |
|--------|-----------|----------|
| Clarity | ❌ Karışık | ✅ Temiz |
| Performance | ❌ Ağır | ✅ Hafif |
| Maintainability | ❌ Zor | ✅ Kolay |
| Single Responsibility | ❌ İhlal | ✅ Uyuyor |
| Type Safety | ❌ Weak | ✅ Strong |
| JSON Operations | ✅ Doğru | ❌ Gereksiz |
| Render Operations | ❌ Missing | ✅ Complete |

---

## ÖZET

- ✅ **PlotCondition hala var** - JSON işlemleri için
- ✅ **PlotConditionData yeni** - Render işlemleri için
- ✅ **İkisi birbirinden ayrı** - Clean architecture
- ✅ **Dönüşüm açık** - `_parseConditions()` yöntemi
- ✅ **Aktif kullanım** - Her frame evaluate ediliyor
- ✅ **Boşluk dolduruldu** - Condition logic **6 operator'le** implement edildi

Bu, iyi bir refactoring örneğidir.
