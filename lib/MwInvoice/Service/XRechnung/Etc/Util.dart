// HH:II
class XsdTime {
  final String value;

  XsdTime({
    required this.value,
  }) {
    assert(value.isNotEmpty);
    assert(value.split(':').length == 2);
    assert(RegExp(r'^\d{2}:\d{2}$').hasMatch(value));
  }

  static XsdTime? fromJson(String? json) {
    if (json != null) {
      return XsdTime(value: json);
    }
    return null;
  }

  @override
  String toString() {
    return value;
  }

  String toJson() {
    return value;
  }
}

// YYYY-MM-DD
class XsdDate {
  final String value;

  XsdDate({
    required this.value,
  }) {
    assert(value.isNotEmpty);
    assert(value.split('-').length == 3);
    assert(RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value));
  }

  static XsdDate? fromJson(String? json) {
    if (json != null) {
      return XsdDate(value: json);
    }
    return null;
  }

  @override
  String toString() {
    return value;
  }

  String toJson() {
    return value;
  }
}
