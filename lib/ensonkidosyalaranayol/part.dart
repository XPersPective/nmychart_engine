 
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
      "fillColor": "@styles.fill.color"
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
* **valueType**: Guide değer tipi
* **value**: Guide için değer
* **upperValue / lowerValue**: Band guide için üst ve alt değerler
* **upperTitle / lowerTitle**: Band etiketleri
 
### Value Type Kuralı

* `valueType`, bağlı olduğu eksenin **final field tipiyle aynı olmak zorundadır**
* Uyuşmazlık durumunda **hata oluşur**

Desteklenen tipler:
`integer`, `double`, `string`, `boolean`, `date`
 
## Renk ve Stil

* **color**: Line rengi
* **upperColor / lowerColor / fillColor**: Band renkleri
* **strokeStyle**: Çizgi stili (`solid`, `dashed`)
 