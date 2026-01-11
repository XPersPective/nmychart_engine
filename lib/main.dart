import 'package:flutter/material.dart';
import 'widgets/chart/nmychart.dart';
import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedExample = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      title: 'NMyChart Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NMyChart - 13 Complete Examples'),
          elevation: 0,
        ),
        body: Row(
          children: [
            SizedBox(
              width: 280,
              child: ListView(
                children: [
                  _buildExampleTile(0, '📈 Line - Stock Price'),
                  _buildExampleTile(1, '🌡️ Line - Temperature'),
                  _buildExampleTile(2, '📊 Bar - Monthly Sales'),
                  _buildExampleTile(3, '📦 Bar - Product Comparison'),
                  _buildExampleTile(4, '📈 Area - Revenue Growth'),
                  _buildExampleTile(5, '📱 Area - Website Traffic'),
                  _buildExampleTile(6, '📊 Histogram - Price Dist'),
                  _buildExampleTile(7, '👥 Histogram - Age Dist'),
                  _buildExampleTile(8, '🥧 Pie - Market Share'),
                  _buildExampleTile(9, '🌐 Pie - Browser Usage'),
                  _buildExampleTile(10, '🕯️ Candlestick - OHLC'),
                  _buildExampleTile(11, '₿ Candlestick - Bitcoin'),
                  _buildExampleTile(12, '📊 Mixed - Line + Area'),
                ],
              ),
            ),
            Expanded(child: NMychart(data: _getExampleData(_selectedExample))),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleTile(int index, String title) {
    return ListTile(
      selected: _selectedExample == index,
      selectedTileColor: Colors.blue.withOpacity(0.3),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: _selectedExample == index
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
      onTap: () => setState(() => _selectedExample = index),
    );
  }

  static ChartData _getExampleData(int index) {
    switch (index) {
      case 0:
        return _lineStockPrice();
      case 1:
        return _lineTemperature();
      case 2:
        return _barMonthlySales();
      case 3:
        return _barProductComparison();
      case 4:
        return _areaRevenueGrowth();
      case 5:
        return _areaWebsiteTraffic();
      case 6:
        return _histogramPriceDistribution();
      case 7:
        return _histogramAgeDistribution();
      case 8:
        return _pieMarketShare();
      case 9:
        return _pieBrowserUsage();
      case 10:
        return _candlestickOHLC();
      case 11:
        return _candlestickCryptoPrice();
      case 12:
        return _mixedLineArea();
      default:
        return _lineStockPrice();
    }
  }

  // ==================== FINANCIAL ====================

  static ChartData _lineStockPrice() {
    return ChartData.fromJson({
      "metadata": {
        "id": "sma_v1_0_0",
        "name": "Simple Moving Average",
        "shortName": "SMA",
        "description": "SMA Indicator",
        "version": "1.0.0",
        "createdAt": "2026-01-11T10:00:00Z",
        "updatedAt": "2026-01-11T10:00:00Z",
        "type": "financial",
        "sourceType": "indicator",
      },

      "inputs": [
        {
          'name': 'Period',
          'key': 'period',
          'valueType': 'integer',
          "value": 14,
          'min': 2,
          'max': 100,
          'showInLegendType': "onlyValue",
        },
        {
          'name': 'Smoothing',
          'key': 'smoothing',
          'valueType': 'double',
          "value": 0.5,
          'min': 0.0,
          'max': 1.0,
          'showInLegendType': "nameAndValue",
        },
      ],
      'plots': [
        {
          'plotType': 'line',
          'fieldKeyX': 'date',
          'fieldKeyY': 'price',
          'color': '#1890FF',
        },
      ],
      'fields': [
        {
          'name': 'Date',
          'key': 'date',
          'valueType': 'string',
          'axis': 'x',
          'showInLegendType': "OnlyValue",
        },
        {
          'name': 'Sma',
          'key': 'sma',
          'valueType': 'double',
          'axis': 'y',
          'showInLegendType': "NameAndValue",
        },
      ],

      'notations': [],
      'guides': [],
      'data': [
        ['2024-01-01', 150.5],
        ['2024-01-08', 152.3],
        ['2024-01-15', 151.8],
        ['2024-01-22', 155.2],
        ['2024-01-29', 157.1],
        ['2024-02-05', 156.5],
        ['2024-02-12', 158.9],
        ['2024-02-19', 160.2],
      ],
    });
  }

  // ==================== WEATHER ====================

  static ChartData _lineTemperature() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'line-temperature',
        'name': 'Daily Temperature',
        'description': 'Temperature fluctuation over a week',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'weather',
        'location': 'Istanbul',
        'unit': 'celsius',
      },
      'plots': [
        {
          'plotType': 'line',
          'fieldKeyX': 'day',
          'fieldKeyY': 'temperature',
          'color': '#FF4D4F',
        },
      ],
      'fields': [
        {
          'name': 'Day',
          'key': 'day',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Temperature C',
          'key': 'temperature',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Monday', 18.5],
        ['Tuesday', 19.2],
        ['Wednesday', 20.1],
        ['Thursday', 21.5],
        ['Friday', 22.3],
        ['Saturday', 23.1],
        ['Sunday', 21.8],
      ],
    });
  }

  // ==================== BUSINESS ====================

  static ChartData _barMonthlySales() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'bar-monthly-sales',
        'name': 'Monthly Sales Revenue',
        'description': 'Company revenue by month Q1 2024',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'business',
        'dataType': 'sales',
        'currency': 'USD',
      },
      'plots': [
        {
          'plotType': 'bar',
          'fieldKeyX': 'month',
          'fieldKeyY': 'sales',
          'color': '#52C41A',
        },
      ],
      'fields': [
        {
          'name': 'Month',
          'key': 'month',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Sales USD',
          'key': 'sales',
          'valueType': 'integer',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['January', 25000],
        ['February', 28000],
        ['March', 32000],
        ['April', 29000],
        ['May', 35000],
        ['June', 38000],
      ],
    });
  }

  // ==================== INVENTORY ====================

  static ChartData _barProductComparison() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'bar-product-comparison',
        'name': 'Product Sales Units',
        'description': 'Units sold by product category',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {'type': 'inventory', 'dataType': 'product-sales'},
      'plots': [
        {
          'plotType': 'bar',
          'fieldKeyX': 'product',
          'fieldKeyY': 'units',
          'color': '#FA8C16',
        },
      ],
      'fields': [
        {
          'name': 'Product',
          'key': 'product',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Units Sold',
          'key': 'units',
          'valueType': 'integer',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Laptop', 450],
        ['Smartphone', 820],
        ['Tablet', 340],
        ['Monitor', 290],
        ['Keyboard', 560],
      ],
    });
  }

  // ==================== FINANCIAL ====================

  static ChartData _areaRevenueGrowth() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'area-revenue-growth',
        'name': 'Quarterly Revenue Growth',
        'description': 'Cumulative revenue by quarter',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'financial',
        'pair': 'COMPANY/INTERNAL',
        'exchange': 'Internal',
        'interval': 'Q',
      },
      'plots': [
        {
          'plotType': 'area',
          'fieldKeyX': 'quarter',
          'fieldKeyY': 'revenue',
          'color': '#722ED1',
        },
      ],
      'fields': [
        {
          'name': 'Quarter',
          'key': 'quarter',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Revenue Million',
          'key': 'revenue',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Q1 2023', 45.2],
        ['Q2 2023', 52.8],
        ['Q3 2023', 68.5],
        ['Q4 2023', 85.3],
        ['Q1 2024', 92.1],
      ],
    });
  }

  // ==================== ANALYTICS ====================

  static ChartData _areaWebsiteTraffic() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'area-website-traffic',
        'name': 'Website Daily Visitors',
        'description': 'Daily unique visitors last 7 days',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {'type': 'analytics', 'source': 'website'},
      'plots': [
        {
          'plotType': 'area',
          'fieldKeyX': 'date',
          'fieldKeyY': 'visitors',
          'color': '#13C2C2',
        },
      ],
      'fields': [
        {
          'name': 'Date',
          'key': 'date',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Visitors',
          'key': 'visitors',
          'valueType': 'integer',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Day 1', 1200],
        ['Day 2', 1900],
        ['Day 3', 1600],
        ['Day 4', 2100],
        ['Day 5', 2800],
        ['Day 6', 2400],
        ['Day 7', 3100],
      ],
    });
  }

  // ==================== ANALYSIS ====================

  static ChartData _histogramPriceDistribution() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'histogram-price-dist',
        'name': 'Product Price Distribution',
        'description': 'Price distribution histogram of products',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {'type': 'analysis', 'datasetName': 'product-prices'},
      'plots': [
        {'plotType': 'histogram', 'fieldKey': 'price', 'color': '#EB2F96'},
      ],
      'fields': [
        {
          'name': 'Price USD',
          'key': 'price',
          'valueType': 'double',
          'axis': 'x',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        [15.5],
        [22.3],
        [18.9],
        [25.1],
        [32.4],
        [19.8],
        [28.6],
        [21.2],
        [26.5],
        [30.1],
        [17.3],
        [29.4],
        [24.8],
        [31.2],
        [20.5],
        [27.1],
      ],
    });
  }

  // ==================== DEMOGRAPHICS ====================

  static ChartData _histogramAgeDistribution() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'histogram-age-dist',
        'name': 'Customer Age Distribution',
        'description': 'Age distribution of customer base',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {'type': 'demographics', 'dataset': 'customer-age'},
      'plots': [
        {'plotType': 'histogram', 'fieldKey': 'age', 'color': '#1890FF'},
      ],
      'fields': [
        {
          'name': 'Age years',
          'key': 'age',
          'valueType': 'integer',
          'axis': 'x',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        [22],
        [25],
        [28],
        [31],
        [35],
        [38],
        [42],
        [45],
        [48],
        [52],
        [23],
        [26],
        [29],
        [32],
        [36],
        [39],
        [43],
        [46],
        [50],
        [55],
      ],
    });
  }

  // ==================== BUSINESS ====================

  static ChartData _pieMarketShare() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'pie-market-share',
        'name': 'Smartphone Market Share',
        'description': 'Global smartphone market share 2024',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'business',
        'market': 'smartphone',
        'region': 'global',
      },
      'plots': [
        {
          'plotType': 'pie',
          'fieldKeyValue': 'share',
          'fieldKeyLabel': 'company',
          'colors': ['#FF4D4F', '#FAAD14', '#52C41A', '#1890FF', '#722ED1'],
        },
      ],
      'fields': [
        {
          'name': 'Company',
          'key': 'company',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': true,
        },
        {
          'name': 'Market Share Percent',
          'key': 'share',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Apple', 35.2],
        ['Samsung', 28.5],
        ['Xiaomi', 18.3],
        ['OPPO', 12.0],
        ['Others', 6.0],
      ],
    });
  }

  // ==================== WEB ANALYTICS ====================

  static ChartData _pieBrowserUsage() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'pie-browser-usage',
        'name': 'Browser Market Usage',
        'description': 'Global browser market share Jan 2024',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {'type': 'webAnalytics', 'dataset': 'browser-market'},
      'plots': [
        {
          'plotType': 'pie',
          'fieldKeyValue': 'percentage',
          'fieldKeyLabel': 'browser',
          'colors': ['#1890FF', '#52C41A', '#FA8C16', '#FF4D4F'],
        },
      ],
      'fields': [
        {
          'name': 'Browser',
          'key': 'browser',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': true,
        },
        {
          'name': 'Usage Percent',
          'key': 'percentage',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['Chrome', 65.5],
        ['Firefox', 15.2],
        ['Safari', 12.8],
        ['Edge', 6.5],
      ],
    });
  }

  // ==================== FINANCIAL ====================

  static ChartData _candlestickOHLC() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'candlestick-ohlc',
        'name': 'Stock OHLC Candlestick',
        'description': 'Open High Low Close candlestick chart',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'financial',
        'pair': 'STOCK/USD',
        'exchange': 'NYSE',
        'interval': '1h',
        'dateFormat': 'YYYY-MM-DD HH:mm',
      },
      'plots': [
        {
          'plotType': 'candlestick',
          'fieldKeyOpen': 'open',
          'fieldKeyHigh': 'high',
          'fieldKeyLow': 'low',
          'fieldKeyClose': 'close',
          'upColor': '#FF4D4F',
          'downColor': '#52C41A',
        },
      ],
      'fields': [
        {
          'name': 'Open USD',
          'key': 'open',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'High USD',
          'key': 'high',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'Low USD',
          'key': 'low',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'Close USD',
          'key': 'close',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        [100.0, 105.0, 99.0, 102.0],
        [102.0, 107.0, 101.0, 104.0],
        [104.0, 108.0, 103.0, 106.0],
        [106.0, 110.0, 105.0, 108.0],
        [108.0, 112.0, 107.0, 110.0],
        [110.0, 114.0, 109.0, 111.0],
      ],
    });
  }

  // ==================== CRYPTO ====================

  static ChartData _candlestickCryptoPrice() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'candlestick-crypto',
        'name': 'Bitcoin Price OHLC',
        'description': 'Bitcoin OHLC price data candlestick',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'financial',
        'pair': 'BTC/USDT',
        'exchange': 'Binance',
        'interval': '1h',
        'dateFormat': 'YYYY-MM-DD HH:mm',
      },
      'plots': [
        {
          'plotType': 'candlestick',
          'fieldKeyOpen': 'open',
          'fieldKeyHigh': 'high',
          'fieldKeyLow': 'low',
          'fieldKeyClose': 'close',
          'upColor': '#52C41A',
          'downColor': '#FF4D4F',
        },
      ],
      'fields': [
        {
          'name': 'Open USD',
          'key': 'open',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'High USD',
          'key': 'high',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'Low USD',
          'key': 'low',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
        {
          'name': 'Close USD',
          'key': 'close',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': false,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        [42500.0, 43200.0, 42000.0, 42800.0],
        [42800.0, 43500.0, 42500.0, 43100.0],
        [43100.0, 44000.0, 43000.0, 43600.0],
        [43600.0, 44500.0, 43400.0, 44200.0],
        [44200.0, 45000.0, 43900.0, 44800.0],
        [44800.0, 45500.0, 44500.0, 45200.0],
      ],
    });
  }

  // ==================== BUSINESS ====================

  static ChartData _mixedLineArea() {
    return ChartData.fromJson({
      'metadata': {
        'id': 'mixed-line-area',
        'name': 'Sales vs Profit Comparison',
        'description': 'Line and Area plots combined comparison',
        'version': '1.0.0',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      },
      'dataSource': {
        'type': 'business',
        'dataType': 'sales-profit',
        'currency': 'USD',
      },
      'plots': [
        {
          'plotType': 'line',
          'fieldKeyX': 'month',
          'fieldKeyY': 'sales',
          'color': '#1890FF',
        },
        {
          'plotType': 'area',
          'fieldKeyX': 'month',
          'fieldKeyY': 'profit',
          'color': '#52C41A',
        },
      ],
      'fields': [
        {
          'name': 'Month',
          'key': 'month',
          'valueType': 'string',
          'axis': 'x',
          'showInLegend': false,
        },
        {
          'name': 'Sales Thousand',
          'key': 'sales',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': true,
        },
        {
          'name': 'Profit Thousand',
          'key': 'profit',
          'valueType': 'double',
          'axis': 'y',
          'showInLegend': true,
        },
      ],
      'inputs': [],
      'notations': [],
      'guides': [],
      'data': [
        ['January', 45.2, 12.5],
        ['February', 52.8, 15.2],
        ['March', 68.5, 22.1],
        ['April', 85.3, 28.5],
        ['May', 92.1, 32.3],
        ['June', 105.5, 38.2],
      ],
    });
  }
}
