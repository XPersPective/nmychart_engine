enum TimeFormat {
  milliseconds,
  seconds,
  minutes,
  hours,
  days,
  weeks,
  months,
  years,
  iso8601,
}

extension TimeFormatExt on TimeFormat {
  String get stringValue {
    switch (this) {
      case TimeFormat.milliseconds:
        return 'milliseconds';
      case TimeFormat.seconds:
        return 'seconds';
      case TimeFormat.minutes:
        return 'minutes';
      case TimeFormat.hours:
        return 'hours';
      case TimeFormat.days:
        return 'days';
      case TimeFormat.weeks:
        return 'weeks';
      case TimeFormat.months:
        return 'months';
      case TimeFormat.years:
        return 'years';
      case TimeFormat.iso8601:
        return 'iso8601';
    }
  }

  static TimeFormat fromString(String value) {
    switch (value.toLowerCase()) {
      case 'milliseconds':
        return TimeFormat.milliseconds;
      case 'seconds':
        return TimeFormat.seconds;
      case 'minutes':
        return TimeFormat.minutes;
      case 'hours':
        return TimeFormat.hours;
      case 'days':
        return TimeFormat.days;
      case 'weeks':
        return TimeFormat.weeks;
      case 'months':
        return TimeFormat.months;
      case 'years':
        return TimeFormat.years;
      case 'iso8601':
        return TimeFormat.iso8601;
      default:
        return TimeFormat.milliseconds;
    }
  }

  /// Converts timestamp to formatted string
  String formatValue(int timestamp) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    switch (this) {
      case TimeFormat.milliseconds:
        return timestamp.toString();
      case TimeFormat.seconds:
        return (timestamp ~/ 1000).toString();
      case TimeFormat.minutes:
        return (timestamp ~/ 60000).toString();
      case TimeFormat.hours:
        return (timestamp ~/ 3600000).toString();
      case TimeFormat.days:
        return (timestamp ~/ 86400000).toString();
      case TimeFormat.weeks:
        return (timestamp ~/ 604800000).toString();
      case TimeFormat.months:
        return '${dt.year}-${dt.month.toString().padLeft(2, '0')}';
      case TimeFormat.years:
        return dt.year.toString();
      case TimeFormat.iso8601:
        return dt.toIso8601String();
    }
  }
}
