import '../ext/ID.dart';
import '../ext/Name.dart';
import '../ext/ExtensionAgencyID.dart';
import '../ext/ExtensionAgencyName.dart';
import '../ext/ExtensionVersionID.dart';
import '../ext/ExtensionAgencyURI.dart';
import '../ext/ExtensionURI.dart';
import '../ext/ExtensionReasonCode.dart';
import '../ext/ExtensionReason.dart';

// A single extension for private use.
class UBLExtension {


  // The definition of the extension content.
  final extensionContent; // missing type ExtensionContent

  // An identifier for the Extension assigned by the creator of the extension.
  final ID? iD;

  // A name for the Extension assigned by the creator of the extension.
  final Name? name;

  // An agency that maintains one or more Extensions.
  final ExtensionAgencyID? extensionAgencyID;

  // The name of the agency that maintains the Extension.
  final ExtensionAgencyName? extensionAgencyName;

  // The version of the Extension.
  final ExtensionVersionID? extensionVersionID;

  // A URI for the Agency that maintains the Extension.
  final ExtensionAgencyURI? extensionAgencyURI;

  // A URI for the Extension.
  final ExtensionURI? extensionURI;

  // A code for reason the Extension is being included.
  final ExtensionReasonCode? extensionReasonCode;

  // A description of the reason for the Extension.
  final ExtensionReason? extensionReason;

  UBLExtension ({
    required this.extensionContent,
    this.iD,
    this.name,
    this.extensionAgencyID,
    this.extensionAgencyName,
    this.extensionVersionID,
    this.extensionAgencyURI,
    this.extensionURI,
    this.extensionReasonCode,
    this.extensionReason,
  });
}

