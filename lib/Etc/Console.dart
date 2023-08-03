class Console {
  static void info(String text) {
    //print('\x1B[36m$text\x1B[0m');
    print(text);
  }

  static void warning(String text) {
    print('\x1B[33m$text\x1B[0m');
  }

  static void error(String text) {
    print('\x1B[31m$text\x1B[0m');
  }

  static void notice(String text) {
    print('\x1B[37m$text\x1B[0m');
  }
}
