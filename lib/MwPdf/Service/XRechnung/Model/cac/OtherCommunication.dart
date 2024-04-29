import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ChannelCode.dart';
import '../cbc/Channel.dart';
import '../cbc/Value.dart';

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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'channelCode': channelCode?.toJson(),
      'channel': channel?.toJson(),
      'value': value?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OtherCommunication? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OtherCommunication (
      channelCode: ChannelCode.fromJson(json['channelCode'] as Map<String, dynamic>?),
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>?),
      value: Value.fromJson(json['value'] as Map<String, dynamic>?),
    );
  }

  static OtherCommunication? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return OtherCommunication (
      channelCode: null,
      channel: null,
      value: null,
    );
  }

}

