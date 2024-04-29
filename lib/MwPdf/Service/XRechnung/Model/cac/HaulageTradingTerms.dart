import '../cac/Information.dart';
import '../cac/Reference.dart';
import '../cac/ApplicableAddress.dart';

// A class for describing the terms of a trade agreement.
class HaulageTradingTerms {


  // Text describing the terms of a trade agreement.
  final List<Information> information;

  // A reference quoting the basis of the terms
  final Reference? reference;

  // The address at which these trading terms apply.
  final ApplicableAddress? applicableAddress;

  HaulageTradingTerms ({
    this.information = const [],
    this.reference,
    this.applicableAddress,
  });
}

