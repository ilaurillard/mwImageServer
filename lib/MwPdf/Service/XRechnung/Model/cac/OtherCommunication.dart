// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ChannelCode.dart';
import '../cbc/Channel.dart';
import '../cbc/Value.dart';

// A class to describe a means of communication.
class OtherCommunication {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The method of communication, expressed as a code.
  final ChannelCode? channelCode;

  // The method of communication, expressed as text.
  final Channel? channel;

  // An identifying value (phone number, email address, etc.) for this channel of communication
  final Value? value;

  OtherCommunication ({
    this.uBLExtensions,
    this.channelCode,
    this.channel,
    this.value,
  });

  static OtherCommunication? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OtherCommunication (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      channelCode: ChannelCode.fromJson(json['channelCode'] as Map<String, dynamic>?),
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>?),
      value: Value.fromJson(json['value'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'channelCode': channelCode?.toJson(),
      'channel': channel?.toJson(),
      'value': value?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OtherCommunication? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OtherCommunication (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      channelCode: ChannelCode.fromXml(xml.findElements('cbc:ChannelCode').singleOrNull),
      channel: Channel.fromXml(xml.findElements('cbc:Channel').singleOrNull),
      value: Value.fromXml(xml.findElements('cbc:Value').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      channelCode?.toXml(),
      channel?.toXml(),
      value?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OtherCommunication',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

