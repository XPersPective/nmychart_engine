enum NotationShape {
  triangle,
  circle,
  diamond,
  square,
  star,
  arrow,
  cross,
  hexagon,
}

extension NotationShapeExt on NotationShape {
  String get stringValue {
    switch (this) {
      case NotationShape.triangle:
        return 'triangle';
      case NotationShape.circle:
        return 'circle';
      case NotationShape.diamond:
        return 'diamond';
      case NotationShape.square:
        return 'square';
      case NotationShape.star:
        return 'star';
      case NotationShape.arrow:
        return 'arrow';
      case NotationShape.cross:
        return 'cross';
      case NotationShape.hexagon:
        return 'hexagon';
    }
  }

  static NotationShape fromString(String value) {
    switch (value.toLowerCase()) {
      case 'triangle':
        return NotationShape.triangle;
      case 'circle':
        return NotationShape.circle;
      case 'diamond':
        return NotationShape.diamond;
      case 'square':
        return NotationShape.square;
      case 'star':
        return NotationShape.star;
      case 'arrow':
        return NotationShape.arrow;
      case 'cross':
        return NotationShape.cross;
      case 'hexagon':
        return NotationShape.hexagon;
      default:
        return NotationShape.circle;
    }
  }
}
