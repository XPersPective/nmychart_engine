# Yeni Plot Type Ekleme Rehberi

## Mevcut Durum: 2 Dosya Sistem (Modern)

Yeni bir plot type eklemek için **SADECE 2 DOSYA** yazman gerekir:

### 1️⃣ Plot Veri Modeli (Model Katmanı)
**File:** `lib/models/plots/custom_plot.dart`

```dart
import '../enums/enums.dart';
import 'plot_condition.dart';
import 'base_plot.dart';

class CustomPlot extends Plot {
  final String? fieldKeyX;
  final String? fieldKeyY;
  
  CustomPlot({
    this.fieldKeyX,
    this.fieldKeyY,
    String? color,
    List<PlotCondition>? conditions,
  }) : super(color: color, conditions: conditions);

  @override
  PlotType get plotType => PlotType.custom;

  @override
  Map<String, dynamic> toJson() => {
    'plotType': plotType.stringValue,
    if (fieldKeyX != null) 'fieldKeyX': fieldKeyX,
    if (fieldKeyY != null) 'fieldKeyY': fieldKeyY,
    if (color != null) 'color': color,
    if (conditions != null)
      'conditions': conditions!.map((c) => c.toJson()).toList(),
  };
}
```

**Ne yapıyor?**
- Plot verilerini saklar
- JSON serialize/deserialize yapar
- PlotType'ı tanımlar

---

### 2️⃣ Render Delegate (Rendering Katmanı)
**File:** `lib/widgets/painters/delegates/custom_plot_render_delegate.dart`

```dart
import 'package:flutter/material.dart';
import 'plot_render_delegate.dart';
import '../../../models/models.dart';

class CustomPlotRenderDelegate extends PlotRenderDelegate {
  @override
  void paint(
    RenderContext context,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField? fieldY,
  ) {
    if (data.isEmpty || fieldY == null) return;
    if (plot is! CustomPlot) return;

    // Grid çiz (otomatik olarak base class'tan gelir)
    drawGrid(context);
    drawAxes(context);

    // Kendi rendering logic'ini yaz
    final fieldKeyX = plot.fieldKeyX;
    final fieldKeyY = plot.fieldKeyY;
    
    if (fieldKeyX == null || fieldKeyY == null) return;

    final xFieldIndex = _findFieldIndex(context.fields, fieldKeyX);
    final yFieldIndex = _findFieldIndex(context.fields, fieldKeyY);
    
    if (xFieldIndex == null || yFieldIndex == null) return;

    final baseColor = _parseColor(plot.color ?? '#1890FF');

    // Burada kendi custom çizim logic'ini yaz
    for (int i = 0; i < data.length; i++) {
      final row = data[i];
      if (row.length <= yFieldIndex) continue;

      final yValue = row[yFieldIndex];
      if (yValue is! num) continue;

      // Condition color override desteği (OTOMATIK)
      final conditionColor = plot.conditions != null
          ? getConditionColor(yValue, _parseConditions(plot.conditions))
          : null;

      final color = conditionColor ?? baseColor;
      
      // Çizim yap
      // context.canvas.drawCircle(...), context.canvas.drawLine(...) vb
    }

    // Guides ve notations desteği (otomatik)
    drawGuides(context, null);
    drawNotations(context, null, data);
  }

  int? _findFieldIndex(List<ChartField>? fields, String key) {
    if (fields == null) return null;
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].key == key) return i;
    }
    return null;
  }

  Color _parseColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.blue;
    }
  }

  List<PlotConditionData>? _parseConditions(List<PlotCondition>? conditions) {
    if (conditions == null) return null;
    return conditions
        .map(
          (c) => PlotConditionData(
            name: c.name ?? 'condition',
            type: 'threshold',
            operator: c.operator.symbol,
            value: _extractNumericValue(c.value1),
            color: _extractColor(c.result),
          ),
        )
        .toList();
  }

  dynamic _extractNumericValue(Map<String, dynamic> valueMap) {
    if (valueMap.isEmpty) return null;
    for (final key in ['value', 'val', 'number', 'amount', 'threshold']) {
      if (valueMap.containsKey(key) && valueMap[key] is num) {
        return valueMap[key];
      }
    }
    for (final value in valueMap.values) {
      if (value is num) return value;
    }
    return null;
  }

  String? _extractColor(Map<String, dynamic> resultMap) {
    if (resultMap.isEmpty) return null;
    for (final key in ['color', 'fill', 'stroke']) {
      if (resultMap.containsKey(key) && resultMap[key] is String) {
        return resultMap[key] as String;
      }
    }
    return null;
  }
}
```

**Ne yapıyor?**
- Plot tipini Canvas'a çizer
- Condition support (otomatik)
- Grid/Axes desteği (otomatik)
- Guide/Notation desteği (otomatik)

---

## 3️⃣ Ekstra Dosyalar (Değişiklikler)

### `lib/models/enums/plot_type.dart` - PlotType enum'a ekle
```dart
enum PlotType {
  line('line', isMainChart: true),
  bar('bar', isMainChart: true),
  area('area', isMainChart: true),
  histogram('histogram', isMainChart: true),
  pie('pie', isMainChart: true),
  candlestick('candlestick', isMainChart: true),
  custom('custom', isMainChart: true),  // ← EKLE
  
  // ... rest of code
}
```

### `lib/models/plots/base_plot.dart` - fromJson'a ekle
```dart
static Plot fromJson(Map<String, dynamic> json) {
  final plotTypeStr = json['plotType'] as String? ?? 'line';
  final plotType = _parseType(plotTypeStr);
  // ...
  
  switch (plotType) {
    case PlotType.custom:
      return CustomPlot.fromJson(json);  // ← EKLE
    // ... rest
  }
}
```

### `lib/widgets/painters/delegates/plot_render_delegate_factory.dart` - Factory'e ekle
```dart
class PlotRenderDelegateFactory {
  static PlotRenderDelegate createDelegate(Plot plot) {
    switch (plot.runtimeType) {
      case LinePlot:
        return LinePlotRenderDelegate();
      case BarPlot:
        return BarPlotRenderDelegate();
      // ... rest
      case CustomPlot:  // ← EKLE
        return CustomPlotRenderDelegate();
      default:
        return LinePlotRenderDelegate();
    }
  }
}
```

---

## Eski Sistem (3 Dosya - DEPRECATED)

```
❌ ARTIK KULLANILMIYOR:

1. CustomPlot (Plot sınıfı)
2. CustomPainter extends ChartPainter
3. CustomPlotRenderDelegate

← NMychart widget sadece delegate'leri çağrıyor!
← Painter sınıfları legacy, silinebilir
```

---

## Yeni Sistem (2 Dosya - MODERN)

```
✅ ŞU AN KULLANILAN:

1. CustomPlot (Plot sınıfı) - DATA MODEL
   └── Veri saklar
   └── JSON serialize

2. CustomPlotRenderDelegate (Rendering) - CANVAS
   ├── drawGrid() ← otomatik (base class'tan)
   ├── drawAxes() ← otomatik
   ├── paint() ← custom logic
   ├── getConditionColor() ← otomatik (6 operator)
   ├── drawGuides() ← otomatik
   └── drawNotations() ← otomatik
```

---

## Mimari Karşılaştırma

### ESKİ (Painter Pattern)
```
ChartData
  └── plots: List<Plot>
         └── LinePlot, BarPlot, etc.

NMychart Widget
  └── CustomPaint(_NMychartPainter)
      └── paint(Canvas, Size)
          └── switch (plot.type)
              ├── LinePlot → LineChartPainter.paint()
              ├── BarPlot → BarChartPainter.paint()
              └── etc.

❌ Sorunlar:
- Plot veri modeli ile Painter karışmış
- Her plot type için Painter yazmalı
- Kodun %70'i duplicate
- Condition logic hiçbir yerde implement edilmedi
```

### YENİ (Delegate Pattern)
```
ChartData
  └── plots: List<Plot>
         └── LinePlot, BarPlot, etc.

NMychart Widget
  └── CustomPaint(_NMychartPainter)
      └── paint(Canvas, Size)
          └── for plot in plots
              └── delegate = PlotRenderDelegateFactory.createDelegate(plot)
                  └── delegate.paint(context, plot, data...)
                      ├── drawGrid() ✅
                      ├── drawAxes() ✅
                      ├── getConditionColor() ✅ (6 operator)
                      ├── Type-specific paint logic
                      ├── drawGuides() ✅
                      └── drawNotations() ✅

✅ Avantajlar:
- Plot veri modelinden ayrı
- Rendering logic merkezileştirildi
- Base class'ta ortak logic (grid, axes, guides, notations)
- Condition system fully implemented
- Yeni plot type = 2 dosya (plot + delegate)
- 0 duplicate code
```

---

## Özet

| İşlem | Gerekli Dosya |
|-------|---------------|
| **Yeni Plot Type Ekleme** | 2 dosya (Plot + Delegate) |
| **Enum güncellemesi** | +1 (PlotType) |
| **Factory güncellemesi** | +1 (createDelegate switch case) |
| **JSON deserialize** | +1 (base_plot.dart switch case) |
| **Painter sınıfı** | ❌ GEREKSIZ (legacy) |

**Total: 2 ana dosya + 3 config dosyası**

Eski sistem: 3 dosya (Plot + Painter + Delegate)  
Yeni sistem: 2 dosya (Plot + Delegate) + configs

**Bir sorum var mı?** 😊
