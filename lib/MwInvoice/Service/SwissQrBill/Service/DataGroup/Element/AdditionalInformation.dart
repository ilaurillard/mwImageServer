import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class AdditionalInformation
    implements QrCodeableInterface // SelfValidatableInterface
{
  // use SelfValidatableTrait;

  static const String TRAILER_EPD = 'EPD';

  /// Unstructured information can be used to indicate the payment purpose
  /// or for additional textual information about payments with a structured reference.
  final String message;

  /// Bill information contains coded information for automated booking of the payment.
  /// The data is not forwarded with the payment.
  final String billInformation;

  AdditionalInformation({
    required this.message,
    required this.billInformation,
  }); // private function __construct(
  //     ?string $message,
  //     ?string $billInformation
  // ) {
  //     $this->message = $message;
  //     $this->billInformation = $billInformation;
  // }

  // public static function create(
  //     ?string $message,
  //     ?string $billInformation = null
  // ): self {
  //     return new self($message, $billInformation);
  // }
  //
  // public function getMessage(): ?string
  // {
  //     return $this->message;
  // }
  //
  // public function getBillInformation(): ?string
  // {
  //     return $this->billInformation;
  // }

  String getFormattedString() {
    String string = message;
    if (billInformation.isNotEmpty) {
      string += '\n$billInformation';
    }

    return string;
  }

  @override
  List<String> getQrCodeData() {
    List<String> qrCodeData = [message, AdditionalInformation.TRAILER_EPD];

    if (billInformation.isNotEmpty) {
      qrCodeData.add(billInformation);
    }

    return qrCodeData;
  }

// public static function loadValidatorMetadata(ClassMetadata $metadata): void
// {
//     $metadata->addPropertyConstraints('message', [
//         new Assert\Length([
//             'max' => 140
//         ])
//     ]);
//
//     $metadata->addPropertyConstraints('billInformation', [
//         new Assert\Length([
//             'max' => 140
//         ])
//     ]);
// }
}
