import 'enums/enums.dart';

/// Chart Notation Model
/// Visual markers/annotations on chart
class ChartNotation {
  final NotationShape shape;
  final String label;
  final List<int> dataIndices;
  final String color;
  final Direction direction;

  ChartNotation({
    required this.shape,
    required this.label,
    required this.dataIndices,
    required this.color,
    required this.direction,
  });

  /// Create from JSON
  factory ChartNotation.fromJson(Map<String, dynamic> json) {
    return ChartNotation(
      shape: _parseShape(json['shape'] as String? ?? 'triangle'),
      label: json['label'] as String? ?? '',
      dataIndices: (json['dataIndices'] as List?)?.cast<int>() ?? [],
      color: json['color'] as String? ?? '#000000',
      direction: _parseDirection(json['direction'] as String? ?? 'up'),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() => {
    'shape': _shapeToString(shape),
    'label': label,
    'dataIndices': dataIndices,
    'color': color,
    'direction': _directionToString(direction),
  };

  static NotationShape _parseShape(String shapeStr) {
    switch (shapeStr.toLowerCase()) {
      case 'triangle':
        return NotationShape.triangle;
      case 'circle':
        return NotationShape.circle;
      case 'square':
        return NotationShape.square;
      case 'diamond':
        return NotationShape.diamond;
      case 'cross':
        return NotationShape.cross;
      case 'star':
        return NotationShape.star;
      default:
        return NotationShape.triangle;
    }
  }

  static String _shapeToString(NotationShape shape) {
    switch (shape) {
      case NotationShape.triangle:
        return 'triangle';
      case NotationShape.circle:
        return 'circle';
      case NotationShape.square:
        return 'square';
      case NotationShape.diamond:
        return 'diamond';
      case NotationShape.cross:
        return 'cross';
      case NotationShape.star:
        return 'star';
      case NotationShape.arrow:
        return 'arrow';
      case NotationShape.hexagon:
        return 'hexagon';
    }
  }

  static Direction _parseDirection(String dirStr) {
    switch (dirStr.toLowerCase()) {
      case 'up':
        return Direction.up;
      case 'down':
        return Direction.down;
      case 'left':
        return Direction.left;
      case 'right':
        return Direction.right;
      default:
        return Direction.up;
    }
  }

  static String _directionToString(Direction dir) {
    switch (dir) {
      case Direction.up:
        return 'up';
      case Direction.down:
        return 'down';
      case Direction.left:
        return 'left';
      case Direction.right:
        return 'right';
      case Direction.upLeft:
        return 'upLeft';
      case Direction.upRight:
        return 'upRight';
      case Direction.downLeft:
        return 'downLeft';
      case Direction.downRight:
        return 'downRight';
    }
  }
}
