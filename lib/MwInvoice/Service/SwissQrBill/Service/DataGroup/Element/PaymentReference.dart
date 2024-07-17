import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/Constraint/Iso11649.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/Reference/QrPaymentReferenceGenerator.dart';
import 'package:mwcdn/MwInvoice/Service/StringModifier.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

final class PaymentReference
    implements
        // GroupSequenceProviderInterface,
        QrCodeableInterface,
        SelfValidatableInterface {
  // use SelfValidatableTrait;

  static const String TYPE_QR = 'QRR';
  static const String TYPE_SCOR = 'SCOR';
  static const String TYPE_NON = 'NON';

  /// Reference type
  final String type;

  /// Structured reference number
  /// Either a QR reference or a Creditor Reference (ISO 11649)
  late final String reference;

  PaymentReference({
    required this.type,
    required String reference,
  }) {
    this.reference = StringModifier.noWhitespace(
      reference,
    );
  }

  String getFormattedReference() {
    switch (type) {
      case PaymentReference.TYPE_QR:
        return StringModifier.strrev(StringModifier.chunkSplit(
                StringModifier.strrev(reference), 5, ' '))
            .trim();
      case PaymentReference.TYPE_SCOR:
        return StringModifier.chunkSplit(reference, 4, ' ').trim();
      default:
        return '';
    }
  }

  @override
  List<String> getQrCodeData() {
    return [
      type,
      reference,
    ];
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (type != PaymentReference.TYPE_NON &&
        type != PaymentReference.TYPE_QR &&
        type != PaymentReference.TYPE_SCOR) {
      errors.add('Invalid type');
    }

    if (type == PaymentReference.TYPE_NON) {
      if (reference.isNotEmpty) {
        errors.add('Invalid reference');
      }
    } else if (type == PaymentReference.TYPE_SCOR) {
      if (reference.isEmpty) {
        errors.add('Invalid reference');
      }

      if (!Iso11649().validateRfReference(reference)) {
        errors.add('Invalid reference');
      }
    } else {
      // QR
      if (reference.isEmpty) {
        errors.add('Invalid reference');
      }
      if (reference.length != 27) {
        errors.add('Invalid reference');
      }
      if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(reference)) {
        errors.add('Invalid reference');
      }
    }

    return errors;
  }

  static PaymentReference fromJson(
    Dict json,
  ) {
    Dict ref = json['reference'] as Dict? ?? {};
    return PaymentReference(
      type: json['type'] as String? ?? '',
      reference: QrPaymentReferenceGenerator(
        customerIdentificationNumber: ref['customerIdentificationNumber'] as String? ?? '',
        referenceNumber: ref['referenceNumber'] as String? ?? '',
      ).doGenerate(),
    );
  }
}
