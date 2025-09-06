import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testeapp/src/utils/constants.dart';

class HiveRepository {
  final _box = Hive.box(Constants.localStorageHiveName);

  Map<String, dynamic>? readMap(String key) {
    final data = _box.get(key);
    if (data == null) {
      return null;
    }

    return jsonDecode(data) as Map<String, dynamic>;
  }

  List<dynamic>? readList(String key) {
    final data = _box.get(key);
    if (data == null) {
      return null;
    }

    return jsonDecode(data) as List<dynamic>;
  }

  String? readString(String key) {
    return _box.get(key);
  }

  bool? readBool(String key) {
    return _box.get(key);
  }

  /// O data pode ser um Map de: Map\<String, String\>\>, Map\<String, dynamic\>\>, etc...
  Future<void> writeMap(String key, Map data) async {
    final String value = jsonEncode(data);
    _box.put(key, value);
  }

  /// O data pode ser um List de: List\<String\>, List\<int\>, List\<Map\<String, dynamic\>\>, etc...
  Future<void> writeList(String key, List data) async {
    final String value = jsonEncode(data);
    await _box.put(key, value);
  }

  Future<void> writeString(String key, String value) async {
    await _box.put(key, value);
  }

  Future<void> writeBool(String key, bool value) async {
    await _box.put(key, value);
  }

  Future<void> removeKey(String key) async {
    await _box.delete(key);
  }
}
