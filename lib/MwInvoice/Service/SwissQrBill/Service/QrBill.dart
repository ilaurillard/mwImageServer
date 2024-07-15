import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/AddressInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/AdditionalInformation.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/Address.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/AlternativeScheme.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/CombinedAddress.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/Header.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/PaymentAmountInformation.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/PaymentReference.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/Element/StructuredAddress.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/EmptyElement/EmptyAdditionalInformation.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/EmptyElement/EmptyAddress.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/EmptyElement/EmptyLine.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/QrCode/QrCode.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/Reference/QrPaymentReferenceGenerator.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/String/StringModifier.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

import 'DataGroup/Element/CreditorInformation.dart';

final class QrBill implements SelfValidatableInterface {
  // use SelfValidatableTrait;

  late final Header header;

  CreditorInformation? creditorInformation;
  AddressInterface? creditor;
  PaymentAmountInformation? paymentAmountInformation;
  AddressInterface? ultimateDebtor;
  PaymentReference? paymentReference;
  AdditionalInformation? additionalInformation;

  Map<String, String> unsupportedCharacterReplacements = {};

  List<AlternativeScheme> alternativeSchemes = [];

  QrBill({
    Header? header,
  }) {
    this.header = header ??
        Header(
          qrType: Header.QRTYPE_SPC,
          version: Header.VERSION_0200,
          coding: Header.CODING_LATIN,
        );
  }

  QrCode getQrCode(
    String? fileFormat,
  ) {
    if (errors().isNotEmpty) {
      throw Exception(
        'The provided data is not valid to generate a qr code. Use errors() to find details.',
      );
    }

    return QrCode.create(
        data: getQrCodeContent(),
        fileFormat: fileFormat,
        unsupportedCharacterReplacements: unsupportedCharacterReplacements);
  }

  String getQrCodeContent() {
    List<dynamic> elements = [
      header,
      creditorInformation,
      creditor,
      EmptyAddress(),
      paymentAmountInformation,
      ultimateDebtor ?? EmptyAddress(),
      paymentReference,
      additionalInformation ?? EmptyAdditionalInformation(),
      getPossibleEmptyLine(),
      alternativeSchemes
    ];

    List<dynamic> qrCodeStringElements =
        _extractQrCodeDataFromElements(elements);

    // print(qrCodeStringElements);

    return qrCodeStringElements.join('\n');
  }

  EmptyLine? getPossibleEmptyLine() {
    if (alternativeSchemes.isNotEmpty) {
      if (null == additionalInformation?.billInformation.isEmpty) {
        return EmptyLine();
      }
    }
    return null;
  }

  List<dynamic> _extractQrCodeDataFromElements(
    List<dynamic> elements,
  ) {
    List<dynamic> qrCodeElements = [];

    List<dynamic> temp = [];
    List<dynamic> temp2 = [];
    for (dynamic e in elements) {
      if (e is QrCodeableInterface) {
        temp.add(
          e.getQrCodeData(),
        );
      } else if (e is List) {
        temp.add(_extractQrCodeDataFromElements(e));
      }
    }

    for (dynamic t in temp) {
      if (t is List) {
        for (dynamic m in t) {
          temp2.add(m);
        }
      } else {
        throw Error();
      }
    }

    for (dynamic s in temp2) {
      if (s is String) {
        s = StringModifier.replaceLineBreaksAndTabsWithSpaces(s);
        s = StringModifier.replaceMultipleSpacesWithOne(s);
        s = s.trim();
        qrCodeElements.add(s);
      } else {
        // qrCodeElements.add(s);
        throw Error();
      }
    }

    return qrCodeElements;
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    errors.addAll(
      header.errors() ?? [],
    );

    if (creditorInformation == null) {
      errors.add('Missing creditorInformation');
    }
    errors.addAll(
      creditorInformation?.errors() ?? [],
    );

    if (creditor == null) {
      errors.add('Missing creditor');
    }
    errors.addAll(
      creditor?.errors() ?? [],
    );

    if (paymentAmountInformation == null) {
      errors.add('Missing paymentAmountInformation');
    }
    errors.addAll(
      paymentAmountInformation?.errors() ?? [],
    );

    errors.addAll(
      ultimateDebtor?.errors() ?? [],
    );

    if (paymentReference == null) {
      errors.add('Missing paymentReference');
    }
    errors.addAll(
      paymentReference?.errors() ?? [],
    );

    // TODO ValidCreditorInformationPaymentReferenceCombination

    if (alternativeSchemes.length > 2) {
      errors.add('Missing alternativeSchemes');
    }
    // TODO validate alternativeSchemes

    return errors;
  }

  static QrBill fromJson(Dict json) {
    QrBill bill = QrBill();

    bill.creditor = Address.fromJson(
      json['creditor'] as Dict? ?? {},
    );

    Dict ud = json['ultimateDebtor'] as Dict? ?? {};
    bill.ultimateDebtor = ud.isEmpty ? null : Address.fromJson(ud);

    bill.creditorInformation = CreditorInformation.fromJson(
      json['creditorInformation'] as Dict? ?? {},
    );

    bill.paymentAmountInformation = PaymentAmountInformation.fromJson(
      json['paymentAmountInformation'] as Dict? ?? {},
    );

    bill.paymentReference = PaymentReference.fromJson(
      json['paymentReference'] as Dict? ?? {},
    );

    return bill;
  }

  static QrBill example() {
    QrBill bill = QrBill();

    bill.creditor = CombinedAddress(
      name: 'Robert Schneider AG',
      addressLine1: 'Rue du Lac 1268',
      addressLine2: '2501 Biel',
      country: 'CH',
    );

    bill.creditorInformation = CreditorInformation(
      iban: 'CH4431999123000889012',
    );

    bill.ultimateDebtor = StructuredAddress(
      name: 'Pia-Maria Rutschmann-Schnyder',
      street: 'Grosse Marktgasse',
      buildingNumber: '28',
      postalCode: '9400',
      city: 'Rorschach',
      country: 'CH',
    );

    bill.paymentAmountInformation = PaymentAmountInformation(
      currency: 'CHF',
      amount: 2500.25,
    );

    bill.paymentReference = PaymentReference(
      type: PaymentReference.TYPE_QR,
      reference: QrPaymentReferenceGenerator(
        customerIdentificationNumber: '210000',
        referenceNumber: '313947143000901',
      ).doGenerate(),
    );

    return bill;
  }
}
