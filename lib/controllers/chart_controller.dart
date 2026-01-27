import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/models.dart';

/// Grafik durum kontrolcüsü
class ChartController extends ChangeNotifier {
  double _translationX = 0.0;
  double _scale = 1.0;
  ChartData _data;
  Size _canvasSize = Size.zero;

  late Rect _viewport;

  ChartController(this._data) {
    _calculateViewport();
  }

  double get translationX => _translationX;
  double get scale => _scale;
  ChartData get data => _data;
  Size get canvasSize => _canvasSize;
  Rect get viewport => _viewport;

  void _calculateViewport() {
    if (_data.data.isEmpty) {
      _viewport = Rect.zero;
      return;
    }

    final timeField = _data.getTimeField();
    if (timeField == null) {
      _viewport = Rect.zero;
      return;
    }

    // Find timeField position in data array by matching key
    int timeFieldIndex = -1;
    for (int i = 0; i < _data.fields.length; i++) {
      if (_data.fields[i].key == timeField.key) {
        timeFieldIndex = i;
        break;
      }
    }

    if (timeFieldIndex == -1) {
      _viewport = Rect.zero;
      return;
    }

    double minTime = double.infinity;
    double maxTime = -double.infinity;
    double minValue = double.infinity;
    double maxValue = -double.infinity;

    for (int pointIndex = 0; pointIndex < _data.data.length; pointIndex++) {
      final point = _data.data[pointIndex];
      
      // Use data point index as time value (works for any time field type)
      final time = pointIndex.toDouble();
      minTime = math.min(minTime, time);
      maxTime = math.max(maxTime, time);

      for (int i = 0; i < _data.fields.length; i++) {
        final field = _data.fields[i];
        // valueType is double or integer for numeric plotting
        if (field.axis == 'y' &&
            (field.valueType == ValueType.double ||
                field.valueType == ValueType.integer)) {
          if (point.length > i) {
            try {
              final value = (point[i] as num).toDouble();
              minValue = math.min(minValue, value);
              maxValue = math.max(maxValue, value);
            } catch (e) {
              // Skip non-numeric values
              continue;
            }
          }
        }
      }
    }

    // Validasyon kontrolleri
    if (minTime.isInfinite ||
        maxTime.isInfinite ||
        minValue.isInfinite ||
        maxValue.isInfinite) {
      _viewport = Rect.zero;
      return;
    }

    final valueRange = maxValue - minValue;
    final padding = valueRange == 0 ? 0.5 : valueRange * 0.1;
    final timePadding = (maxTime - minTime) * 0.02;

    _viewport = Rect.fromLTRB(
      minTime - timePadding,
      minValue - padding,
      maxTime + timePadding,
      maxValue + padding,
    );
  }

  Offset worldToScreen(Offset world) {
    if (_viewport.width <= 0 || _viewport.height <= 0 || _canvasSize.isEmpty) {
      return Offset.zero;
    }

    final normalizedX = (world.dx - _viewport.left) / _viewport.width;
    final normalizedY = (world.dy - _viewport.top) / _viewport.height;

    return Offset(
      normalizedX * _canvasSize.width * _scale + _translationX,
      _canvasSize.height - (normalizedY * _canvasSize.height),
    );
  }

  Offset screenToWorld(Offset screen) {
    if (_viewport.width == 0 || _viewport.height == 0 || _scale == 0) {
      return Offset.zero;
    }

    final normalizedX =
        (screen.dx - _translationX) / (_canvasSize.width * _scale);
    final normalizedY = (_canvasSize.height - screen.dy) / _canvasSize.height;

    return Offset(
      normalizedX * _viewport.width + _viewport.left,
      normalizedY * _viewport.height + _viewport.top,
    );
  }

  void pan(double deltaX) {
    _translationX += deltaX;

    // Pan sınırlaması: grafiğin başı ve sonu biraz görünsün
    // Kaydırma sınırı: canvas genişliğinin %20'si kenardan görünsün
    final minAllowedPan =
        -_canvasSize.width * (_scale - 1) + (_canvasSize.width * 0.2);
    final maxAllowedPan =
        _canvasSize.width * (_scale - 1) - (_canvasSize.width * 0.2);

    _translationX = _translationX.clamp(minAllowedPan, maxAllowedPan);
    notifyListeners();
  }

  void zoom(double delta, Offset focalPoint) {
    final prevScale = _scale;
    _scale = (_scale * delta).clamp(0.1, 10.0);

    if (_scale != prevScale) {
      final scaleFactor = _scale / prevScale;
      _translationX =
          focalPoint.dx - (focalPoint.dx - _translationX) * scaleFactor;
      notifyListeners();
    }
  }

  void updateCanvasSize(Size size) {
    if (_canvasSize != size) {
      _canvasSize = size;
      notifyListeners();
    }
  }

  void updateData(ChartData newData) {
    _data = newData;
    _calculateViewport();
    notifyListeners();
  }

  Range getVisibleRange() {
    if (_data.data.isEmpty || _viewport.width == 0) return Range(0, 0);

    final timeField = _data.getTimeField();
    if (timeField == null) return Range(0, _data.data.length);

    // Find timeField position in data array by matching key
    int timeFieldIndex = -1;
    for (int i = 0; i < _data.fields.length; i++) {
      if (_data.fields[i].key == timeField.key) {
        timeFieldIndex = i;
        break;
      }
    }

    if (timeFieldIndex == -1) return Range(0, _data.data.length);

    final leftWorld = screenToWorld(Offset(0, 0)).dx;
    final rightWorld = screenToWorld(Offset(_canvasSize.width, 0)).dx;

    int startIndex = 0;
    int endIndex = _data.data.length;

    // Find start index
    for (int i = 0; i < _data.data.length; i++) {
      final time = (_data.data[i][timeFieldIndex] as num).toDouble();
      if (time >= leftWorld) {
        startIndex = math.max(0, i - 2);
        break;
      }
    }

    // Find end index
    for (int i = startIndex; i < _data.data.length; i++) {
      final time = (_data.data[i][timeFieldIndex] as num).toDouble();
      if (time > rightWorld) {
        endIndex = math.min(_data.data.length, i + 2);
        break;
      }
    }

    // Sınırları kontrol et
    startIndex = startIndex.clamp(0, _data.data.length);
    endIndex = endIndex.clamp(startIndex, _data.data.length);

    return Range(startIndex, endIndex);
  }
}

class Range {
  final int start;
  final int end;
  Range(this.start, this.end);
}
