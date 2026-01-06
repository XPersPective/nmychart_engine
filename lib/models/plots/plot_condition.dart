import '../enums/enums.dart';

/// Plot Condition Model
/// Defines conditional styling/behavior for plots
class PlotCondition {
  final Map<String, dynamic> value1;
  final ConditionOperator operator;
  final Map<String, dynamic> value2;
  final Map<String, dynamic> result;

  PlotCondition({
    required this.value1,
    required this.operator,
    required this.value2,
    required this.result,
  });

  factory PlotCondition.fromJson(Map<String, dynamic> json) {
    return PlotCondition(
      value1: json['value1'] as Map<String, dynamic>? ?? {},
      operator: _parseOperator(json['operator'] as String? ?? ''),
      value2: json['value2'] as Map<String, dynamic>? ?? {},
      result: json['result'] as Map<String, dynamic>? ?? {},
    );
  }

  static ConditionOperator _parseOperator(String op) {
    switch (op.toLowerCase()) {
      case 'greater_than':
      case '>':
        return ConditionOperator.greaterThan;
      case 'less_than':
      case '<':
        return ConditionOperator.lessThan;
      case 'equal':
      case '==':
        return ConditionOperator.equal;
      case 'not_equal':
      case '!=':
        return ConditionOperator.notEqual;
      case 'greater_or_equal':
      case '>=':
        return ConditionOperator.greaterOrEqual;
      case 'less_or_equal':
      case '<=':
        return ConditionOperator.lessOrEqual;
      default:
        return ConditionOperator.equal;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'value1': value1,
      'operator': _operatorToString(operator),
      'value2': value2,
      'result': result,
    };
  }

  static String _operatorToString(ConditionOperator op) {
    switch (op) {
      case ConditionOperator.greaterThan:
        return 'greater_than';
      case ConditionOperator.lessThan:
        return 'less_than';
      case ConditionOperator.equal:
        return 'equal';
      case ConditionOperator.notEqual:
        return 'not_equal';
      case ConditionOperator.greaterOrEqual:
        return 'greater_or_equal';
      case ConditionOperator.lessOrEqual:
        return 'less_or_equal';
    }
  }

  /// Evaluates condition against data
  bool evaluate(dynamic val1, dynamic val2) {
    if (val1 is! num || val2 is! num) return false;
    return operator.evaluate(val1, val2);
  }
}
