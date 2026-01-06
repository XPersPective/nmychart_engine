import 'package:flutter/material.dart';

/// Handles gesture interactions for charts (pan, zoom, etc)
class ChartGestureHandler {
  Offset? _lastFocalPoint;
  double _scale = 1.0;

  /// Handle scale/zoom gesture
  void onScaleUpdate(ScaleUpdateDetails details) {
    _scale = details.scale;
  }

  /// Handle pan gesture
  void onPanUpdate(DragUpdateDetails details) {
    _lastFocalPoint = details.globalPosition;
  }

  /// Reset gesture state
  void reset() {
    _lastFocalPoint = null;
    _scale = 1.0;
  }

  /// Get current scale factor
  double get scale => _scale;

  /// Get last focal point
  Offset? get lastFocalPoint => _lastFocalPoint;
}
