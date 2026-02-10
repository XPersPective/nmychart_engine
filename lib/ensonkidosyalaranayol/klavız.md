## Grafik Seti İskelet Yapısı

Bu bölüm, istemcinin beklediği **grafik seti organizasyonunu** tanımlayan üst seviye iskelet yapıyı açıklar. Grafik seti, birden fazla chart group’tan oluşur ve yerleşim kuralları `layoutType` ile belirlenir.* 
```json
{
  "metadata": {
    "id": "unique_chart_id_123",
    "createdAt": 1676985600000,
    "updatedAt": 1676998900000,
    "symbol": "BTC/USDT",
    "interval": "1h",
    "plotType": "line",
    "layoutType": "financial",
    "axisConfig": {
      "baseAxis": "x",  
      "baseAxisType": "date", 
      "valueAxisType": "double",
    },
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
* `createdAt`: Grafik setinin milliseconds cinsinden sistem saati olarak oluşturulma zamanı.
* `updatedAt`: Grafik setinin milliseconds cinsinden sistem saati olarak son güncellenme zamanı.
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

`axisConfig` Eksen yapılandırması, grafik setindeki tüm chart'ların kullanacağı **ortak eksen referanslarını** tanımlar. Bu yapı, tüm chart group'ların aynı temel eksen sistemini paylaşmasını sağlar.

* `baseAxis`: Temel eksenin yönünü belirtir (`x` veya `y`). Genellikle zaman ekseni için `x` kullanılır 
Eksen tipleri field tipleridir. (`date`, `integer`, `double`, `string`, `boolean`)

* `baseAxisType`: Temel eksenin veri tipini tanımlar .
* `valueAxisType`: Değer ekseninin veri tipini tanımlar

**Önemli Not:** Bu yapı, grafik seti seviyesinde tanımlanır ve tüm chart'lar bu eksen konfigürasyonunu miras alır. Bireysel chart'lar kendi eksen ayarlarını override edemez.

### `charts`

**Chart group listesi**dir.

* `charts[0]`: **Primary chart group**’tur. Ekrandaki ana ve büyük görsel alanı temsil eder.
* `charts[1..n]`: **Secondary chart group**’lardır. Ana chart group’un altında daha küçük alanlar olarak gösterilir.

Her `charts[i]` elemanı **bir chart group**’u temsil eder ve kendi içinde bir liste içerir:

* İlk eleman: Chart group’un **base chart**’ı.
* Devam eden elemanlar: Bu base chart üzerine bindirilen **overlay chart**’lardır.

## Kurallar

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


## 3. Metadata Structure

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
     "axisConfig": {
      "baseAxis": "x",  
      "baseAxisType": "date", 
      "valueAxisType": "double",
    },
    "author": "anonymous",
    "version": "1.0.0",
    "createdAt": 1676985600000,
    "updatedAt": 1676998700000
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
İlk oluşturulma zamanı(milliseconds cinsinden sistem saati).

`updatedAt`
Son güncelleme zamanı(milliseconds cinsinden sistem saati).


## Değer Atama Kuralları

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
       @rules.trendRule(@styles.bullGreen.color, @styles.bearRed.color, @styles.neutralGray.color)
       ```
     * İçerik genellikle üç renk tipinden oluşur:

       * Pozitif → bull/rising
       * Negatif → bear/falling
       * Nötr → neutral
     * Renk değerleri **literal** veya **stil referan değeri** olabilir.

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

Tamam, medya dosyasına yapıştırılacak şekilde, font/format değiştirmeden ve senin verdiğin yapıya uyacak şekilde **Rules (Kurallar)** bölümünü ekleyelim. Kod blokları ve metinler MD uyumlu, sade fontlu olacak.

**Not:** İnputlar ve fieldler referans değerler alamaz. Tüm değerleri literal (sabit) olmalıdır.
Sadece **notations** lar style "id" leri alır.

## Rules (Kurallar)

Kurallar, veri ve field değerlerini karşılaştırmak ve duruma göre işaretlemek için kullanılır. Her kural **pozitif, negatif ve nötr** sonuçları içerir ve karşılaştırmalar **double türünde** yapılır.

### Kural Yapısı

* `id` → kuralın benzersiz kimliği
* `positive` → koşul pozitif olduğunda geçerli ifade
* `negative` → koşul negatif olduğunda geçerli ifade
* `neutral` → koşul nötr olduğunda geçerli ifade

**Örnek JSON:**

```json
"rules": [
  {
    "id": "trendRule",
    "positive": "@fields.clos.value > @fields.open.value",
    "negative": "@fields.clos.value <= @fields.open.value",
    "neutral": "@fields.clos.value == @fields.open.value"
  }
]
```

* `@fields.clos.value` ve `@fields.open.value` → veri referanslarıdır.
* Literal değerler de kullanılabilir:

```json
"positive": 1.0,
"negative": 0.0,
"neutral": 0.5
```

### Kurala Erişim

Kurallara referans sistemi ile erişilebilir. Erişim formatı:

```
@rules.<ruleId>(<pozitif sonucu>, <negatif sonucu>, <nötr sonucu>)
```

* `@rules` → kural scope’u
* `<ruleId>` → çağrılacak kuralın ID’si
* Parametreler → kural çalıştığında dönecek değerler, sırayla **pozitif**, **negatif**, **nötr** duruma karşılık gelir.

**Örnek Erişim:**

```json
"trendColor": "@rules.trendRule(@styles.bullGreen.color, @styles.bearRed.color, @styles.neutralGray.color)"
```

Bu çağrı, `trendRule` kuralının sonucunu doğrudan verir. Durum pozitifse `bullGreen.color`, negatifse `bearRed.color`, nötrse `neutralGray.color` döner.


## Styles (Stiller)

`styles` alanı, chart içinde **kullanılacak renk ve görsel stil tanımlarını** içerir. Her stil, bir **ID** ve ilgili görsel özellikleri (ör. renk) ile tanımlanır. Bu stiller, chart’ın farklı alanlarında veya kurallarda (`rules`) referansla kullanılabilir.

**Örnek JSON:**

```json
"styles": [
  { "id": "bullGreen", "color": "#00FF00" },
  { "id": "bearRed", "color": "#FF0000" },
  { "id": "neutralGray", "color": "#888888" }, 
  { "id": "signalEntry",  "text": "Signal Entry", "color": "#00C853", "icon": "arrow_up"
    }
]
```

**Açıklama:**

* `bullGreen` → pozitif trend veya yükseliş için kullanılacak stil
* `bearRed` → negatif trend veya düşüş için kullanılacak stil
* `neutralGray` → nötr durumlar için kullanılacak stil
* Kurallar veya plotlar bu stillere `@styles.<id>.<özellik>` formatında referans verebilir:

```json
"trendColor": "@rules.trendRule(@styles.bullGreen.color, @styles.bearRed.color ,@styles.neutralGray.color)"
```

* Bu alan, chart’ta kullanılacak tüm hazır görsel stillerin merkezi tanımıdır ve herhangi bir chart yapısında tekrar tekrar kullanılabilir.

## Legend Grafik Bilgi Öğeleri

Lejant, grafiğin üzerinde gösterilen **bilgi öğelerini** içeren bir listedir. Bu öğeler, grafiğe dair anlık veya statik bilgileri sunar; örneğin sembol, zaman aralığı, fiyat veya yüzdesel değişim gibi.

Her bilgi öğesi sadece iki özellik içerir:

* `text` → gösterilecek metin
* `color` → metnin rengi

Öğeler hem **sabit referans** hem de **dinamik ve kurallı değer** alabilir. Yani:

* Stil veya başka bir veri kaynağına bağlı renkler kullanılabilir.
* Kurallara göre renk değişimi uygulanabilir (örneğin trend pozitifse yeşil, negatifse kırmızı).

Lejant, bu öğeleri bir liste halinde sunar ve her öğe grafiğe dair tek bir bilgiyi temsil eder.

---

### Örnek JSON

```json
"legend": [
  { 
    "text": "@inputs.symbol.value", 
    "color": "@styles.neutralGray.color"
  },
  { 
    "text": "@inputs.interval.value", 
    "color": "#3FA7D6"
  },
  { 
    "text": "@fields.close.value",
    "color": "@rules.trendRule(@styles.bullGreen.color, @styles.bearRed.color, @styles.neutralGray.color)"
  },

]
```

**Açıklama:**

* `symbol` referans ile `interval` sabit renkleri ile gösteriliyor.
* `close` ise kurallı ve dinamik bir değer, pozitif/negatif/nötr durumlara göre renk alıyor.

Tamam, dediğini anladım. Önceki açıklamayı **minimum ve maksimum değerler için nal olabilme durumunu** ekleyerek güncelledim. Sadece `integer` ve `double` tipleri için geçerli, diğer tipler için min/max yoktur. JSON’da min/max alanları boş bırakılabilir veya null (`null`) atanabilir.

---

## Input Tanımı

Bu yapı, hesaplama motoru veya grafik modüllerinde kullanılacak **girdi değerlerini** temsil eder. Her input benzersizdir, tipini ve değerini içerir ve başka modüllerden erişilebilir. Hesaplamalarda kullanılan tüm değerler bu inputlar üzerinden sağlanır.

### Ortak Alanlar

Tüm inputlar ortak olarak şu alanları içerir:

* **`id`** → Benzersiz kimlik.
* **`name`** → Açıklayıcı isim.
* **`type`** → Input tipi (`string`, `integer`, `double`, `boolean`, `symbol`, `interval`, `date`).
* **`value`** → Başlangıç veya varsayılan değer.

---

### Tiplere Özel Alanlar ve Açıklamaları

1. **String**

   * Serbest metin veya açıklayıcı değerler.
   * Ek alan yok.

2. **Symbol**

   * Finansal sembol tipi.
   * Ek alanlar:

     * **`base`** → Ana varlık.
     * **`quote`** → Karşı varlık.

3. **Interval**

   * Zaman aralıklı veri periyotları.
   * Alabileceği değerler:
     `"1m"`, `"3m"`, `"5m"`, `"15m"`, `"30m"`, `"1h"`, `"2h"`, `"4h"`, `"6h"`, `"8h"`, `"12h"`, `"1d"`, `"3d"`, `"1w"`, `"1M"`

4. **Integer**

   * Tam sayısal değerler.

     * **`min`** → Minimum değer sınırı, **null veya değer atanabilir**.
     * **`max`** → Maksimum değer sınırı, **null veya değer atanabilir**.

5. **Double**

   * Ondalıklı sayılar.

     * **`min`** → Minimum değer sınırı, **null veya değer atanabilir**.
     * **`max`** → Maksimum değer sınırı, **null veya değer atanabilir**.

6. **Boolean**
   * True/false değerleri.

7. **Date**

   * Tarih veya tarih-saat değerleri.
   * Milliseconds cinsinden sistem saati olarak çalışır.

**Not:** Integer ve double tiplerinde **min ve max alanları JSON’da `null` atanarak boş bırakılabilir**, bu durumda sistem bu sınırları dikkate almaz.

---

### JSON Örneği

```json
[
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
    "min": null,
    "max": null
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
    "id": "date",
    "name": "Start time",
    "type": "date",
    "value": 1676985600000,
  }
]
```

Bu yapı ile:

* `integer` ve `double` tiplerinde **min ve max null olabilir**, yani sınır yok demektir.
* `symbol` → base ve quote ile finansal çifti tanımlar.
* `interval` → tüm geçerli periyotları destekler.
* `date` → milliseconds cinsinden sistem saati olarak çalışır.

## Field Tanımı

Fieldlar data içindeki her bir elemanın bilgisini tanımlar. Her alanın tipi ve hangi eksende görüneceği burada tanımlanır.  

* `id`: Alanın benzersiz kimliği
* `name`: Alanın kullanıcıya gösterilecek adı
* `type`: Verinin tipi (`integer`, `double`, `string`, `boolean`, `date`)
* `axis`: Grafikte görüneceği eksen (`x` veya `y`)

Her veri alanı bu yapıya uygun olmalıdır ve sıralama önemlidir. X ekseni genellikle tarih/zaman, Y ekseni ise fiyat veya göstergeler için kullanılır.

```json
[
  {
    "id": "date",
    "name": "Close Time",
    "type": "date",
    "axis": "x"
  },
  {
    "id": "close",
    "name": "Close",
    "type": "integer",
    "axis": "y"
  },
  {
    "id": "close",
    "name": "Close",
    "type": "double",
    "axis": "y"
  },
  {
    "id": "signal",
    "name": "Signal",
    "type": "string",
    "axis": "y"
  },
  {
    "id": "istrend",
    "name": "IsTrend",
    "type": "boolean",
    "axis": "y"
  }
]
```

Field’lar üzerinden data içindeki değerler alınır.
`@fields.<fieldId>.value` → Data serisinden ilgili dönemin değeri.

`@fields.<fieldId>.value[-1]` →Data serisinden önceki periyodun değeri.

`@fields.<fieldId>.<property>` → Eğer field propertysine erişim (örn: Name, axis) ona erişim.  

**Örnek:** 
* `@fields.close.value` → Kapanış fiyatını(Close) verir
* `@fields.close.value[-1]` → Önceki periyodun kapanış fiyatını(Close) verir
* `@fields.close.name` → `Close` çıktısı verir

## Plot Yapısı

**Plot**, bir veri kümesinin belirli bir **dataForm** ve **shape (type)** ile, tanımlı eksenler üzerinde **nasıl çizileceğini** belirleyen yapılandırma nesnesidir.

```json
{
  "plots": [
    {
      "id": "plot_id0",
      "type": "line",
      "dataForm": "scalar",
      "axisConfig": {
        "baseAxis": "x",
        "baseAxisType": "date",
        "valueAxisType": "double"
      },
      "x": "@fields.date.value",
      "y": "@fields.ma.value",
      "color": "#1890FF"
    },
    {
      "id": "plot_id1",
      "type": "area",
      "dataForm": "signedScalar",
      "axisConfig": {
        "baseAxis": "x",
        "baseAxisType": "date",
        "valueAxisType": "double"
      },
      "x": "@fields.date.value",
      "y": "@fields.ma.value",
      "color": "#1890FF"
    },
    {
      "id": "plot_id2",
      "type": "candlestick",
      "dataForm": "ohlc",
      "axisConfig": {
        "baseAxis": "x",
        "baseAxisType": "date",
        "valueAxisType": "double"
      },
      "x": "@fields.date.value",
      "open": "@fields.open.value",
      "high": "@fields.high.value",
      "low": "@fields.low.value",
      "close": "@fields.close.value",
      "color": "@rules.candlestick(@styles.bullGreen.color,@styles.bearRed.color,@styles.neutralGray.color)"
    },
    {
      "id": "plot_id3",
      "type": "bar",
      "dataForm": "scalar",
      "axisConfig": {
        "baseAxis": "x",
        "baseAxisType": "date",
        "valueAxisType": "double"
      },
      "x": "@fields.date.value",
      "y": "@fields.month.value",
      "color": "#1890FF"
    },
    {
      "id": "plot_id_band",
      "type": "band",
      "dataForm": "band",
      "axisConfig": {
        "baseAxis": "x",
        "baseAxisType": "date",
        "valueAxisType": "double"
      },
      "x": "@fields.date.value",
      "upper": "@fields.bb_upper.value",
      "lower": "@fields.bb_lower.value",
      "upperColor": "@styles.upper.color",
      "lowerColor": "@styles.lower.color",
      "fillColor": "@styles.fill.color"
    }
  ]
}
```

### Plot Alanları

* **id**: Plot kimliği
* **type**: Plot çizim tipi
* **dataForm**: Verinin yapısal formu
* **axisConfig**: Eksen davranışı
* **x / y**: Field binding (veri yolu)
* **color**: Plot rengi (sabit veya rule)

### Plot Tipleri 

`line`, `area`, `bar`, `candlestick`, `histogram`, `band`

### Data Formları

* **scalar** → `line`, `area`, `bar`
* **signedScalar** → `line`, `area`, `bar`, `histogram`
* **ohlc** → `candlestick`, `bar`, `line`
* **band** → `band`,`area`

### Axis Config

* **baseAxis**: Eksen yönü (`x` | `y`)
* Axis tipleri doğrudan **field tiplerini yansıtır** (`integer`, `double`, `string`, `boolean`, `date`)

### Color

`color`, sabit değer veya rule ifadesi olarak tanımlanır.

## Guide Yapısı

**Guide**, grafikte mevcut bir eksene bağlı, sabit değer veya değer aralığını gösteren referans çizgileridir.

```json
{
  "guides": [
    {
      "id": "guide_id_line",
      "type": "line",
      "axis": "y",
      "valueType": "double",
      "title": "Support",
      "value": 30.0,
      "color": "#52C41A",
      "strokeStyle": "dashed"
    },
    {
      "id": "guide_id_band",
      "type": "band",
      "axis": "y",
      "valueType": "double",
      "upperValue": 80.0,
      "lowerValue": 30.0,
      "upperTitle": "Resistance",
      "lowerTitle": "Support",
      "upperColor": "@styles.upper.color",
      "lowerColor": "@styles.lower.color",
      "fillColor": "@styles.fill.color",
      "strokeStyle": "dashed"
    }
  ]
}
``` 

### Guide Tipleri

* **line**: Tek bir sabit değeri gösterir
* **band**: İki değer (upper–lower) arasında alan gösterir
 
### Alan Açıklamaları

* **id**: Guide kimliği
* **type**: Guide tipi (`line` | `band`)
* **axis**: Bağlandığı eksen (`x` | `y`)
* **valueType**: Guide değer tipi(field tipi)
* **value**: Guide için değer
* **upperValue / lowerValue**: Band guide için üst ve alt değerler
* **upperTitle / lowerTitle**: Band etiketleri
 
### Value Type Kuralı

* `valueType`, bağlı olduğu eksenin **final field tipiyle aynı olmak zorundadır**
* Uyuşmazlık durumunda **hata oluşur**

Desteklenen tipler:
`integer`, `double`, `string`, `boolean`, `date`

## Notation

```json
{
  "notations": [
    {
      "id": "notation_id",
      "axis": "y",
      "valueType": "double",
      "title": "Signal Entry",
      "value": 30.0,
      "style": "@rules.candlestick(@styles.bullGreen,@styles.bearRed,@styles.neutralGray)"
    }
  ]
}
```

**Notation**, şart değerlendirmesini `style` içindeki rule’lara bırakarak, koşul sonucuna göre (ör. sinyal girişi, çıkışı veya olay) uygun **stil ailesi** ile grafikte **ikon/işaret** üreten anlamsal temsildir.

---

### Alan Açıklamaları

* **id**: Notation kimliği
* **axis**: Notation’ın bağlandığı eksen (`x` | `y`)
* **valueType**: Notation’da kullanılan değerin tipi; bağlı olduğu eksenin **final value type’ı ile birebir aynı olmak zorundadır**, aksi durumda hata oluşur
* **value**: Notation’ın eksen üzerinde işaretleneceği referans değer
* **title**: Notation ile birlikte gösterilecek anlamsal etiket (örn. Support, Signal Entry)
* **style**: Şart değerlendirmesini yapan ve görsel çıktıyı üreten **style / rule referansı**
 
### Style Üzerinden Görsel Üretim

Notation görsel üretmez.
Görsel çıktı **tamamen style** tarafından belirlenir.

Style aşağıdaki öğeleri kapsar:

* renk
* ikon (shape)
* metin
* stroke / fill davranışı 

### Desteklenen Shape (Style İçinde)

Style alanında kullanılabilen ikon/işaret tipleri:

* `triangle`
* `circle`
* `diamond`
* `square`
* `star`
* `arrow`
* `cross`
* `hexagon`

Bu shape’ler:

* sinyal girişi / çıkışı
* kırılım
* uyarı
* olay işaretleri

gibi anlamsal durumların görselleştirilmesinde kullanılır.
 
### Net Kurallar (Final)

* Şart **notation’da tanımlanmaz**, **style / rule içinde değerlendirilir**
* Notation yalnızca **hangi stil ailesinin kullanılacağını** belirtir
* Renk, ikon (shape), metin ve yön **style tarafından üretilir**
* `valueType`, eksen ve field tipleriyle **tam uyumlu olmak zorundadır**
* Notation **plot veya guide değildir**, veri çizmez, **anlam işaretler**
