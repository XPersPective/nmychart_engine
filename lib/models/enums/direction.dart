enum Direction { up, down, left, right, upLeft, upRight, downLeft, downRight }

extension DirectionExt on Direction {
  String get stringValue {
    switch (this) {
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

  static Direction fromString(String value) {
    switch (value.toLowerCase()) {
      case 'up':
        return Direction.up;
      case 'down':
        return Direction.down;
      case 'left':
        return Direction.left;
      case 'right':
        return Direction.right;
      case 'upleft':
        return Direction.upLeft;
      case 'upright':
        return Direction.upRight;
      case 'downleft':
        return Direction.downLeft;
      case 'downright':
        return Direction.downRight;
      default:
        return Direction.up;
    }
  }
}
