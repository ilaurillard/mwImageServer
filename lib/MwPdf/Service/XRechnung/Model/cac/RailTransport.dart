import 'dart:convert';
import '../cbc/TrainID.dart';
import '../cbc/RailCarID.dart';

// A class defining details about a train wagon used as a means of transport.
class RailTransport {


  // An identifier for the train used as the means of transport.
  final TrainID trainID;

  // An identifier for the rail car on the train used as the means of transport.
  final RailCarID? railCarID;

  RailTransport ({
    required this.trainID,
    this.railCarID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'trainID': trainID.toJson(),
     'railCarID': railCarID?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

