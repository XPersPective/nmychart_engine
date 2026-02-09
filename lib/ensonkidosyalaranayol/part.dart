 
 

### Referans Sistemi Kuralları

1. **Referans ve Literal Ayrımı:**

   * Başında `@` varsa → **referans**
   * Başında `@` yoksa → **literal (sabit değer)**

2. **Geçerli Scope’lar:**

   ```
   inputs
   fields
   plots
   guides
   notations
   rules
   styles
   ```

3. **Referans Türleri:**

   * **Rules Referansı:** Başında `@rules` varsa → **kural referansı**

     * Örnek:

       ```
       @rules.trendRule(@styles.bullGreen, @styles.bearRed, @styles.neutralGray)
       ```
     * İçerik genellikle üç renk tipinden oluşur:

       * Pozitif → bull/rising
       * Negatif → bear/falling
       * Nötr → neutral
     * Renk değerleri **literal** veya **stil referansı** olabilir.

   * **Field Referansı:** Başında `@fields` varsa → **field referansı**

     * Eğer sonu `.value` ile bitiyorsa → **data referansı** (veri serisinden periyot bazlı değer)

       ```
       @fields.clos.value[0]   → bu periyot
       @fields.clos.value[-1]  → bir önceki periyot
       ```
     * Eğer sonu `.value` ile bitmiyorsa → **field property referansı** (field içindeki özellik)

       ```
       @fields.clos.high       → high özelliği
       @fields.clos.open       → open özelliği
       ```

4. **Parser İşleyişi:**

   * `@` yok → literal değer olarak kullanılır.
   * `@` var → resolver çalıştırılır.
   * `@rules` referansı → kural fonksiyonu çalıştırılır.
   * `@fields` referansı → data veya field property erişimi yapılır.

---
 
  
/*


"metadata": {
    "id": "unique_chart_id_124",
    "name": "Open-High-Low-Close (OHLC) Chart",
    "shortName": "OHLC Chart",
    "description": "Open-High-Low-Close (OHLC) Chart - financial chart showing open, high, low, and close prices",
    "version": "1.0.0",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z",
    "type": "financial",
    "subType": "price"
  },

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

*/




/*





Haklısın. Yapıyı **bozmadan**, **senin verdiğin ana iskelet formuna sadık kalarak**, sadece **karar verilen eklemeleri** ve **düzeltmeleri** yapıyorum.
Aşağıda **tek parça**, **temiz**, **kopyala-yapıştır** hazır çıktı var.

---

## Ana Chart Document – Final Skeleton (Bozulmamış Form)

```json
{
  "metadata": {
    "id": "unique_chart_id_123",
    "layoutType": "financial",
    "symbol": "BTC/USDT",
    "interval": "1h",
    "plotType": "line",
    "createdAt": "2026-01-11T10:00:00Z",
    "updatedAt": "2026-01-11T10:00:00Z"
  },
  "charts": [
    [{}, {}, {}],
    [{}, {}, {}],
    [{}, {}, {}],
    [{}, {}, {}]
  ]
}
```

---

## Açıklama – Ana Şart İskelet Sistemi

Bu doküman **tek bir data scope**’u temsil eder.

### Metadata (Document Scope)

* `symbol`
  Ana veri kaynağıdır.
  Bu doküman altındaki **tüm chart’lar aynı sembole bağlıdır**.

* `interval`
  Zaman çözünürlüğüdür.
  Veri **tek sefer çekilir**, tüm indikatörler bu veri üzerinden hesaplanır.

* `plotType`
  **Sadece price kategorisindeki chart’lar için geçerli görünüm bilgisidir.**
  Chart içindeki `plotType` tanımıyla **çakışmaz**.
 

> Bu alanlar metadata’da tutulur çünkü:
>
> * Menü üretmek gerekir
> * Tek source of truth gerekir
> * Tek sembol / tek interval prensibi korunur

---

### Charts Alanı (Noktalama / Panel Mantığı)

```text
charts = [
  [ chart, chart, chart ],  // panel 0
  [ chart, chart ],         // panel 1
  [ chart ],                // panel 2
  ...
]
```

* **Dış dizi** → dikey paneller
* **İç diziler** → aynı panelde yan yana / üst üste render edilen chart’lar

Bu yapı:

* Panel sırasını **zorlamaz**
* Overlay / separate kararını **chart metadata’daki `renderMode` ile** çözer
* Kullanıcı sürükleyip yer değiştirdiğinde kırılmaz

---

### Bilinçli Olarak Yapılmayanlar

* ❌ Menü bar yok
* ❌ İkinci sembol / ikinci interval yok
* ❌ Data, fetch, time-range bilgisi yok
  → Bunlar **bu dokümanın sorumluluğu değil**

---

Bu sürüm:

* Senin verdiğin **ana iskeleti korur**
* Eklenen alanlar **minimum ve gerekçeli**
* Önceki tüm kararlarla uyumlu
* Bundan sonra **ANA REFERANS** olarak kullanılabilir

İstersen bir sonraki adımda:

* chart içi `plot / shape` iskeleti
* data request (history / forward) protokolü
* scroll → fetch modeli

hangisini istiyorsan **direkt söyle, ekleyeyim**.
*/