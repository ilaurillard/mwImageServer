import '../cac/ChannelCode.dart';
import '../cac/Channel.dart';
import '../cac/Value.dart';

// A class to describe a means of communication.
class OtherCommunication {


  // The method of communication, expressed as a code.
  final ChannelCode? channelCode;

  // The method of communication, expressed as text.
  final Channel? channel;

  // An identifying value (phone number, email address, etc.) for this channel of communication
  final Value? value;

  OtherCommunication ({
    this.channelCode,
    this.channel,
    this.value,
  });
}

