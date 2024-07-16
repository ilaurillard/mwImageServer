import 'package:mwcdn/MwInvoice/Service/StringModifier.dart';

class QrPaymentReferenceGenerator // implements SelfValidatableInterface
{
  // use SelfValidatableTrait;

  late final String customerIdentificationNumber;
  late final String referenceNumber;

  QrPaymentReferenceGenerator({
    required String customerIdentificationNumber,
    required String referenceNumber,
  }) {
    this.customerIdentificationNumber = StringModifier.stripWhitespace(
      customerIdentificationNumber,
    );
    this.referenceNumber = StringModifier.stripWhitespace(
      referenceNumber,
    );
  }

// public static function generate(?string $customerIdentificationNumber, string $referenceNumber): string
// {
//     $qrPaymentReferenceGenerator = new self($customerIdentificationNumber, $referenceNumber);
//
//     return $qrPaymentReferenceGenerator->doGenerate();
// }

// public function __construct(?string $customerIdentificationNumber, string $referenceNumber)
// {
//     if (null !== $customerIdentificationNumber) {
//         $this->customerIdentificationNumber = StringModifier::stripWhitespace($customerIdentificationNumber);
//     }
//     $this->referenceNumber = StringModifier::stripWhitespace($referenceNumber);
// }
//
  String doGenerate() {
//     if (!$this->isValid()) {
//         throw new InvalidQrPaymentReferenceException(
//             'The provided data is not valid to generate a qr payment reference number.'
//         );
//     }
//
    String completeReferenceNumber = customerIdentificationNumber;

    int len = completeReferenceNumber.length;
    completeReferenceNumber += referenceNumber.padLeft(
      26 - len,
      '0',
    );
    completeReferenceNumber += modulo10(
      completeReferenceNumber,
    ).toString();

    return completeReferenceNumber;
  }

//
// public static function loadValidatorMetadata(ClassMetadata $metadata): void
// {
//     $metadata->addPropertyConstraints('customerIdentificationNumber', [
//         // Only numbers are allowed (including leading zeros)
//         new Assert\Regex([
//             'pattern' => '/^\d*$/',
//             'match' => true
//         ]),
//         new Assert\Length([
//             'max' => 11
//         ]),
//     ]);
//
//     $metadata->addPropertyConstraints('referenceNumber', [
//         // Only numbers are allowed (including leading zeros)
//         new Assert\Regex([
//             'pattern' => '/^\d*$/',
//             'match' => true
//         ]),
//         new Assert\NotBlank()
//     ]);
//
//     $metadata->addConstraint(new Assert\Callback('validateFullReference'));
// }
//
// public function validateFullReference(ExecutionContextInterface $context): void
// {
//     $strlenCustomerIdentificationNumber = $this->customerIdentificationNumber ? strlen($this->customerIdentificationNumber) : 0;
//
//     if ($strlenCustomerIdentificationNumber + strlen($this->referenceNumber) > 26) {
//         $context->buildViolation('The length of customer identification number + reference number may not exceed 26 characters in total.')
//             ->addViolation();
//     }
// }
//
  int modulo10(String number) {
    List<int> table = [0, 9, 4, 6, 8, 2, 7, 1, 3, 5];
    int next = 0;
    int strlen = number.length;
    for (int i = 0; i < strlen; i++) {
      next = table[(next + int.parse(number[i])) % 10];
    }
    return (10 - next) % 10;
  }
}
