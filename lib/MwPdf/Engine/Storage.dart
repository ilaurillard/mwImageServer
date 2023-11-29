import 'package:mwcdn/MwMs/Model/ResourcesInterface.dart';
import 'package:mwcdn/MwMs/Model/TokenInterface.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';

class Storage {
  final FileStorage fileStorage;
  final ResourcesInterface? resources;
  final int bucketId;
  final TokenInterface token;

  Storage({
    required this.fileStorage,
    this.resources,
    this.bucketId = -1,
    required this.token,
  });
}
