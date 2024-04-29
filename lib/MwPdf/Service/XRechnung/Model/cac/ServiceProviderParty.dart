import '../cac/ID.dart';
import '../cac/ServiceTypeCode.dart';
import '../cac/ServiceType.dart';
import '../cac/Party.dart';
import '../cac/SellerContact.dart';

// A class to describe a party contracting to provide services, such as transportation, finance, etc.
class ServiceProviderParty {


  // The party providing the service.
  final Party party;

  // An identifier for this service provider.
  final ID? iD;

  // The type of service provided, expressed as a code.
  final ServiceTypeCode? serviceTypeCode;

  // The type of service provided, expressed as text.
  final List<ServiceType> serviceType;

  // The contact for the service provider.
  final SellerContact? sellerContact;

  ServiceProviderParty ({
    required this.party,
    this.iD,
    this.serviceTypeCode,
    this.serviceType = const [],
    this.sellerContact,
  });
}

