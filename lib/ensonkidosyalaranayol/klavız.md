## Grafik Seti İskelet Yapısı

Bu bölüm, istemcinin beklediği **grafik seti organizasyonunu** tanımlayan üst seviye iskelet yapıyı açıklar. Grafik seti, birden fazla chart group’tan oluşur ve yerleşim kuralları `layoutType` ile belirlenir.
```json
{
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
    [{}, {}, {}],
    [{}, {}, {}],
    [{}, {}, {}],
    [{}, {}, {}]
  ]
}
```

Bu JSON, istemcinin beklediği **grafik seti organizasyonunu tanımlayan iskelet yapıdır**.
Yapı, bir grafik setinin **chart group’lar** halinde nasıl düzenlendiğini gösterir. Grafik seti iki ana bölümden oluşur: `metadata` ve `charts`.

### `metadata`

Grafik setine ait üst seviye tanımlayıcı bilgileri içerir.

* `id`: Grafik seti için benzersiz kimlik.
* `createdAt`: Grafik setinin oluşturulma zamanı.
* `updatedAt`: Grafik setinin son güncellenme zamanı.
* `symbol`: Grafiğin bağlı olduğu finansal varlığı belirtir (örn: `BTC/USDT`).
* `interval`: Verinin zaman çözünürlüğünü, her barın kapsadığı süreyi tanımlar (örn: `1h`, `1d`).
* `plotType`: Price chart’ın görsel çizim tipini belirtir (örn: `line`, `candlestick`).
* `layoutType`: Yerleşim tipi. Grafik setinin istemci tarafından hangi yerleşim kurallarına göre render edileceğini belirtir.
`layoutType` değerleri: financial stacked, grid

#### `layoutType` değerleri

**financial**
Primary chart group üstte büyük alan olarak render edilir. Secondary chart group’lar altında dikey paneller halinde yer alır. Zaman ekseni ortaktır.

**stacked**
Tüm chart group’lar eşit genişlikte olacak şekilde dikey olarak alt alta dizilir. Ana–alt ayrımı yoktur.

**grid**
Chart group’lar satır–sütun ızgarası içinde render edilir. Her chart group eşit veya tanımlı oranlarda alan kaplar.


### `charts`

**Chart group listesi**dir.

* `charts[0]`: **Primary chart group**’tur. Ekrandaki ana ve büyük görsel alanı temsil eder.
* `charts[1..n]`: **Secondary chart group**’lardır. Ana chart group’un altında daha küçük alanlar olarak gösterilir.

Her `charts[i]` elemanı **bir chart group**’u temsil eder ve kendi içinde bir liste içerir:

* İlk eleman: Chart group’un **base chart**’ı.
* Devam eden elemanlar: Bu base chart üzerine bindirilen **overlay chart**’lardır.

### Kurallar

* Her chart group’ta **tek bir base chart zorunludur**.
* Overlay chart’lar yalnızca **aynı chart group içindeki base chart** üzerine bindirilir.
* Primary ve secondary chart group’lar **aynı yapısal kuralları** paylaşır.

## Chart İskelet Yapısı

Bu bölüm, grafik seti içinde yer alan **tek bir chart nesnesinin** (base chart veya overlay chart) iç yapısını tanımlar. Tüm chart’lar, bulundukları chart group’tan bağımsız olarak bu sözleşmeye uyar.

```json
{
  "metadata": {},
  "legend": [{}, {}, {}],
  "inputs": [{}, {}, {}],
  "fields": [{}, {}, {}],
  "data": [[], [], []],
  "plots": [{}, {}, {}],
  "guides": [{}, {}, {}],
  "notations": [{}, {}, {}],
  "rules": [{}, {}, {}],
  "styles": [{}, {}, {}]
}
```

### Alan Açıklamaları

* `metadata`:
  Chart’ın kimlik, isim, versiyon ve açıklama gibi üst seviye bilgilerini içerir.

* `legend`:
  Chart’a ait lejant bilgilerini içerir. Seri adları, semboller ve anlık değer gösterimleri burada yer alır.

* `inputs`:
  Chart’ın hesaplanması için gerekli olan parametreleri ve kullanıcı girdilerini içerir.

* `fields`:
  Ham veri içindeki alanların isimlerini ve konumlarını tanımlar. Chart’ın veriyi nasıl okuyacağını belirler.

* `data`:
  Chart tarafından kullanılan ham veri setlerini içerir.

* `plots`:
  Verinin nasıl çizileceğini tanımlar. Grafik tipleri ve render edilecek plot yapıları burada yer alır.

* `guides`:
  Eksenler, grid çizgileri ve referans çizgileri gibi yönlendirici görsel öğeleri içerir.

* `notations`:
  Etiketler, işaretler ve açıklama notasyonlarını tanımlar.

* `rules`:
  Koşullu davranışları tanımlar. Renk değişimleri, sinyal üretimi ve duruma bağlı mantıksal/görsel kurallar burada yer alır.

* `styles`:
  Chart’a ait görsel stil tanımlarını içerir. Renkler, çizgi tipleri ve kalınlıklar referansla kullanılabilir.


### 3. Metadata Structure

Metadata, bir chart’ın **kimliğini, sınıfını ve yönetsel bilgisini** tanımlar.
Render, veri, kural veya hesaplama içermez.

```json

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
    "updatedAt": "2026-01-11T10:00:00Z"
  }

```

**Alan Tanımları**

`id`
Chart için sistem genelinde **benzersiz kimlik**. Referanslama için kullanılır.

`name`
Chart’ın **tam ve okunabilir adı**. UI ve dokümantasyonda gösterilir.

`shortName`
Kısa ad / kısaltma. Menü ve dar alanlarda kullanılır.

`description`
Chart’ın neyi temsil ettiğini açıklayan kısa tanım.

`type`
Chart’ın **üst seviye sınıfıdır**.
Sabit kümeden seçilir.

Olası `type` değerleri (örnek küme):

* `financial`
* `statistical`

`category`
Type altında **alt kullanım alanını** belirtir.

Olası `category` değerleri (örnek küme):

* `price`
* `volume`
* `indicator`
* `oscillator`
* `volatility`
* `market-cap`
* `ratio`
* `order-flow`

**`renderMode`**
Chart’ın **hangi render bağlamında çizileceğini** belirtir.
Bu alan, **yerleşimi (layoutType)** değil, **çizim bağlamını** tanımlar.

* `overlay`
  Chart, aynı chart group içinde **başka bir base chart’ın (genellikle price)** üzerine çizilir.
  Ayrı panel oluşturmaz.

* `separate`
  Chart, **kendi render alanını** gerektirir ve ayrı bir chart group’ta gösterilir.

`provider`
Chart tanımını **kim sağladı** bilgisidir.
Sadece kaynak belirtir, yazarı temsil etmez.

Geçerli değerler:

* `system`
* `user`

`visibility`
Chart’ın erişim seviyesidir.

Geçerli değerler:

* `public`
* `private`

`author`
Chart’ı tanımlayan **yazar bilgisi**.
Atıf amaçlıdır, iş kuralı üretmez.
Yazar yoksa `anonymous` kullanılır.

`version`
Chart tanımının **semantik sürümü**.

`createdAt`
İlk oluşturulma zamanı (ISO-8601).

`updatedAt`
Son güncelleme zamanı (ISO-8601).
