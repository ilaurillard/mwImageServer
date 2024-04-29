import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/PlacardNotation.dart';
import '../cbc/PlacardEndorsement.dart';
import '../cbc/EmergencyProceduresCode.dart';
import '../cbc/Extension.dart';

// A class to describe a secondary hazard associated with a hazardous item.
class SecondaryHazard {


  // An identifier for this secondary hazard.
  final ID? iD;

  // Text of the placard notation corresponding to the hazard class of this secondary hazard. Can also be the hazard identification number of the orange placard (upper part) required on the means of transport.
  final PlacardNotation? placardNotation;

  // Text of the placard endorsement for this secondary hazard that is to be shown on the shipping papers for a hazardous item. Can also be used for the number of the orange placard (lower part) required on the means of transport.
  final PlacardEndorsement? placardEndorsement;

  // A code signifying the emergency procedures for this secondary hazard.
  final EmergencyProceduresCode? emergencyProceduresCode;

  // Additional information about the hazardous substance, which can be used (for example) to specify the type of regulatory requirements that apply to this secondary hazard.
  final List<Extension> extension;

  SecondaryHazard ({
    this.iD,
    this.placardNotation,
    this.placardEndorsement,
    this.emergencyProceduresCode,
    this.extension = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'placardNotation': placardNotation?.toJson(),
     'placardEndorsement': placardEndorsement?.toJson(),
     'emergencyProceduresCode': emergencyProceduresCode?.toJson(),
     'extension': extension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  SecondaryHazard fromJson(Map<String, dynamic> json) {
    return SecondaryHazard (
    );
  }

}

