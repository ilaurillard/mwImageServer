import '../ext/UBLExtension.dart';

// A container for all extensions present in the document.
class UBLExtensions {


  // A single extension for private use.
  final List<UBLExtension> uBLExtension;

  UBLExtensions ({
    required this.uBLExtension,
  }) {
    assert(uBLExtension.isNotEmpty);  }
}

