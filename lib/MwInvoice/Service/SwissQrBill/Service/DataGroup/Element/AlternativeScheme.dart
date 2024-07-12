import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class AlternativeScheme
    implements QrCodeableInterface // SelfValidatableInterface
{
  // use SelfValidatableTrait;

  // /**
  //  * Parameter character chain of the alternative scheme
  //  */
  final String parameter;

  AlternativeScheme({
    required this.parameter,
  });

  @override
  List<String> getQrCodeData() {
    return [
      parameter,
    ];
  }

//
// private function __construct(string $parameter)
// {
//     $this->parameter = $parameter;
// }
//
// public static function create(string $parameter): self
// {
//     return new self($parameter);
// }
//
// public function getParameter(): string
// {
//     return $this->parameter;
// }
//
// public function getQrCodeData(): array
// {
//     return [
//         $this->getParameter()
//     ];
// }
//
// public static function loadValidatorMetadata(ClassMetadata $metadata): void
// {
//     $metadata->addPropertyConstraints('parameter', [
//         new Assert\NotBlank(),
//         new Assert\Length([
//             'max' => 100
//         ])
//     ]);
// }
}
