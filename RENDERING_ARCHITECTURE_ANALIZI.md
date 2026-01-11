# Rendering Architecture Analizi
**Tarih:** 2026-01-11  
**Focus:** Plot vs Painter mimarisi

---

## 📊 MEVCUT DURUM

### Plot Sınıfları (lib/models/plots/)
```
Base Plot (abstract)
├── LinePlot
├── BarPlot
├── AreaPlot
├── HistogramPlot
├── PiePlot
└── CandlestickPlot
```

**Sorun:** Her plot sınıfı `render()` methoduna sahip ama TÖM implementasyon boş:
```dart
@override
void render(Canvas canvas, Size size) {
  if (conditions != null && conditions!.isNotEmpty) {
    _applyConditions(canvas);  // TODO
  }
}
```

### Painter Sınıfları (lib/widgets/painters/)
```
ChartPainter (abstract base)
├── BarChartPainter
├── LineChartPainter
├── AreaChartPainter
├── HistogramPainter
├── PieChartPainter
└── CandlestickPainter
```

**Sorun:** Her painter kendi çizim mantığını içeriyor, plot'tan bağımsız:
```dart
// BarChartPainter içinde
final barWidth = size.width / (dataPoints.length * 2);
for (int i = 0; i < dataPoints.length; i++) {
  // Çizim mantığı burada
}
```

### Widget (_NMychartPainter)
```dart
class _NMychartPainter extends CustomPainter {
  void _drawPlots(Canvas canvas, Size size) {
    for (final plot in controller.data.plots) {
      _drawPlot(canvas, plot, visibleData, start);
    }
  }
  
  void _drawPlot(Canvas canvas, dynamic plot, ...) {
    switch (plot.type) {
      case 'line':
        _drawLine(...);
      case 'bar':
        _drawBars(...);
    }
  }
}
```

**Sorun:** Plot type'a göre manuel switch-case, painter'lara delegasyon yok!

---

## 🔴 PROBLEMLER

### 1. **Tekrarlayan Çizim Mantığı**
- Plot sınıflarında: Boş render()
- Painter'larda: Gerçek çizim
- Widget'ta: Switch-case ile manual routing
- **Sonuç:** Aynı mantık 3 yerde, maintenance zor

### 2. **Plot Type Mismatch**
```dart
// plot sınıfında: PlotType enum
PlotType get plotType => PlotType.line;

// painter'da: String type
switch (plot.type) {
  case 'line': ...
}
```
**Sorun:** Type bilgisi consistency'de sorun

### 3. **Dynamic Painter Seçimi Yok**
Şu an hard-coded:
```dart
switch (plot.type) {
  case 'line': _drawLine(...);
  case 'bar': _drawBars(...);
}
```

**Gerekli:** Plot tipine göre dynamic painter factory

### 4. **Plot-Painter Decoupling**
```
Plot (Data)        Painter (Rendering)
LinePlot      ×    LineChartPainter
BarPlot       ×    BarChartPainter
```
Aralarında doğrudan bağlantı yok, widget'ta yapılıyor

### 5. **Data Access**
Painter'lar:
- Canvas size alıyor
- DataPoints list alıyor (hard-coded)
- Field indexing karışık

Plot'lar:
- fieldKeyX, fieldKeyY bilgisine sahip
- Data yapısını bilemiyorlar

---

## 🎯 İDEAL MİMARİ

### Option 1: Plot → Painter Factory
```
Plot (Data + Metadata)
  ├── plotType: PlotType enum
  ├── fieldKeyX, fieldKeyY
  └── createPainter() → ChartPainter
        └── BarChartPainter
```

**Avantajlar:**
- ✅ Plot kendi painter'ını bilir
- ✅ Type-safe (enum)
- ✅ Decoupling

**Dezavantajlar:**
- Plot sınıfı UI bağımlı hale gelir

### Option 2: Painter Factory Registry
```
PlotPainterFactory
  ├── register(PlotType.bar → BarChartPainter)
  ├── register(PlotType.line → LineChartPainter)
  └── getPainter(plot) → ChartPainter
```

**Avantajlar:**
- ✅ Loose coupling
- ✅ UI independent
- ✅ Dynamic registration

**Dezavantajlar:**
- Factory pattern complexity

### Option 3: Plot Delegate Pattern
```
Plot
  ├── render() {
  │     delegate.paint(canvas, data)
  │   }
  └── delegate: PlotRenderDelegate
        └── BarPlotRenderDelegate
```

**Avantajlar:**
- ✅ Separation of concerns
- ✅ Plot = Data, Delegate = Rendering

---

## 📋 YAPILMASI GEREKEN

### 1. **PlotType Enum Standardizasyonu**
- ✅ Zaten var (lib/models/enums/)
- Her plot class'ında: `PlotType get plotType`

### 2. **PlotRenderDelegate Pattern**
```dart
abstract class PlotRenderDelegate {
  void paint(
    Canvas canvas,
    Size size,
    Plot plot,
    List<List<dynamic>> data,
    ChartField fieldX,
    ChartField fieldY,
  );
}
```

Subclasses:
- BarPlotRenderDelegate
- LineChartRenderDelegate
- vb.

### 3. **Plot-Delegate Factory**
```dart
class PlotRenderDelegateFactory {
  static PlotRenderDelegate createDelegate(PlotType type) {
    switch (type) {
      case PlotType.bar:
        return BarPlotRenderDelegate();
      case PlotType.line:
        return LineChartRenderDelegate();
      // ...
    }
  }
}
```

### 4. **Widget Integration**
```dart
// NMychart'ta
void _drawPlot(Canvas canvas, Plot plot, ...) {
  final delegate = PlotRenderDelegateFactory
    .createDelegate(plot.plotType);
  
  delegate.paint(canvas, size, plot, data, fieldX, fieldY);
}
```

### 5. **Plot.render() Refactor**
```dart
// Plot sınıfında
void render(
  Canvas canvas,
  Size size,
  List<List<dynamic>> data,
  ChartField fieldX,
  ChartField fieldY,
) {
  final delegate = PlotRenderDelegateFactory
    .createDelegate(plotType);
  
  if (conditions != null && conditions!.isNotEmpty) {
    // Apply conditions
  }
  
  delegate.paint(canvas, size, this, data, fieldX, fieldY);
}
```

---

## 🔧 İŞLEM PLANI (TODO)

1. **PlotRenderDelegate Abstract Class** oluştur
2. **Her plot type için delegate** implement et (6 tane)
3. **PlotRenderDelegateFactory** oluştur
4. **Plot.render()** refactor et (delegates'i kullan)
5. **Widget (_NMychartPainter)** simplify et
6. **Painter classes** opsiyonel hale getir (compatibility)
7. **Tests** yaz
8. **Errors** kontrol et

---

## 📊 KARŞILAŞTIRMA

### Şu anki (Sorunlu)
```
NMychart Widget
  └── _NMychartPainter
      └── switch (plot.type)
          ├── case 'line': _drawLine(...)
          ├── case 'bar': _drawBars(...)
          └── ...

Plot sınıfları (Boş)
Painter sınıfları (Unused)
```

### Yeni (Temiz)
```
NMychart Widget
  └── _NMychartPainter
      └── plot.render(canvas, size, data, fields)
          └── PlotRenderDelegateFactory
              └── LinePlotRenderDelegate.paint()
                  ├── Data access
                  ├── Coordinate calculation
                  └── Drawing

Plot sınıfları (Data + orchestration)
RenderDelegates (Actual drawing)
```

---

## 💡 FAYDALARI

✅ **Type Safety**
- String switch → PlotType enum

✅ **Maintainability**
- Çizim mantığı delegatede
- Plot sınıfı sadece data

✅ **Testability**
- Delegate'leri unit test edilebilir
- Mock'lanabilir

✅ **Extensibility**
- Yeni plot type → yeni delegate
- Eski kod değişmiyor

✅ **Performance**
- Painter reuse
- Condition check efficiency

---

## 📚 DOSYALAR OLUŞTURULACAK

```
lib/widgets/painters/delegates/
├── plot_render_delegate.dart        ← Abstract base
├── line_plot_render_delegate.dart
├── bar_plot_render_delegate.dart
├── area_plot_render_delegate.dart
├── histogram_plot_render_delegate.dart
├── pie_plot_render_delegate.dart
├── candlestick_plot_render_delegate.dart
└── plot_render_delegate_factory.dart ← Factory
```

---

## SONUÇ

Şu an mimari **3-layer rendering** kullanıyor (Data, Painter, Widget) ama **decoupled değil**.

**Solution:** **Delegate Pattern** ile clean separation:
- **Plot:** Data structure (JSON compatible)
- **RenderDelegate:** Rendering logic (canvas operations)
- **Widget:** Orchestration (layout, events)

Bu, professional charting library'lerin standard mimarisidir.

