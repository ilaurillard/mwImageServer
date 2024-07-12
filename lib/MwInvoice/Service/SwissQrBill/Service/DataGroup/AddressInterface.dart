import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';

abstract class AddressInterface
  extends SelfValidatableInterface
{
  String? getName();

  String? getCountry();

  String getFullAddress({
    bool forReceipt = false,
  });


}
