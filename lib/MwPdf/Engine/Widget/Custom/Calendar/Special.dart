class Special {
  Map<String, String> items = {};

  Special();

  void add(String label, String icon) {
    items[label] = icon;
  }
}