import '../cac/TrainID.dart';
import '../cac/RailCarID.dart';

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
}

