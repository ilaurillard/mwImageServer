import '../cac/ID.dart';
import '../cac/Content.dart';

// A class to define a clause (a distinct article or provision) in a contract, treaty, will, or other formal or legal written document requiring compliance.
class Clause {


  // An identifier for this clause.
  final ID? iD;

  // The text of this clause.
  final List<Content> content;

  Clause ({
    this.iD,
    this.content = const [],
  });
}

