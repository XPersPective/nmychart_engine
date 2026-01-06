enum ConditionOperator {
  greaterThan('>'),
  lessThan('<'),
  greaterOrEqual('>='),
  lessOrEqual('<='),
  equal('=='),
  notEqual('!=');

  final String symbol;
  const ConditionOperator(this.symbol);

  static ConditionOperator fromString(String value) {
    switch (value) {
      case '>':
        return ConditionOperator.greaterThan;
      case '<':
        return ConditionOperator.lessThan;
      case '>=':
        return ConditionOperator.greaterOrEqual;
      case '<=':
        return ConditionOperator.lessOrEqual;
      case '==':
        return ConditionOperator.equal;
      case '!=':
        return ConditionOperator.notEqual;
      default:
        return ConditionOperator.equal;
    }
  }

  bool evaluate(dynamic value1, dynamic value2) {
    if (value1 is! num || value2 is! num) return false;
    switch (this) {
      case greaterThan:
        return value1 > value2;
      case lessThan:
        return value1 < value2;
      case greaterOrEqual:
        return value1 >= value2;
      case lessOrEqual:
        return value1 <= value2;
      case equal:
        return value1 == value2;
      case notEqual:
        return value1 != value2;
    }
  }
}
