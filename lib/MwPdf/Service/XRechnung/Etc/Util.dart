// HH:II
class XsdTime {
  final String value;

  XsdTime({
    required this.value,
  }) {
    assert(value.isNotEmpty);
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
