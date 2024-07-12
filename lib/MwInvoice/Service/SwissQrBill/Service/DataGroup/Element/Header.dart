// <?php declare(strict_types=1);
//
// namespace Sprain\SwissQrBill\DataGroup\Element;
//
// use Sprain\SwissQrBill\DataGroup\QrCodeableInterface;
// use Sprain\SwissQrBill\Validator\SelfValidatableInterface;
// use Sprain\SwissQrBill\Validator\SelfValidatableTrait;
// use Symfony\Component\Validator\Constraints as Assert;
// use Symfony\Component\Validator\Mapping\ClassMetadata;

import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';

import '../QrCodeableInterface.dart';

final class Header implements QrCodeableInterface, SelfValidatableInterface {

  static const String QRTYPE_SPC = 'SPC';
  static const String VERSION_0200 = '0200';
  static const int CODING_LATIN = 1;

  /// Unambiguous indicator for the Swiss QR code.
  final String qrType;

  /// Version of the specifications (Implementation Guidelines) in use on
  /// the date on which the Swiss QR code was created.
  /// The first two positions indicate the main version, the following the
  /// two positions the sub-version ("0200" for version 2.0).
  final String version;

  /// Character set code
  final int coding;

  Header({
    required this.qrType,
    required this.version,
    required this.coding,
  });

  @override
  List<String> getQrCodeData() {
    return [
      qrType,
      version,
      coding.toString(),
    ];
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (qrType.isEmpty) {
      errors.add('Missing qrType');
    }
    if (!RegExp(r'^[a-zA-Z0-9]{3}$').hasMatch(qrType)) {
      errors.add('Invalid qrType');
    }

    if (version.isEmpty) {
      errors.add('Missing version');
    }
    if (!RegExp(r'^\d{4}$').hasMatch(version)) {
      errors.add('Invalid version');
    }

    if (coding < 1) {
      errors.add('Missing coding');
    }
    if (!RegExp(r'^\d$').hasMatch(coding.toString())) {
      errors.add('Invalid coding');
    }

    return errors;
  }

}
