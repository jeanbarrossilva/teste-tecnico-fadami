import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:testeapp/src/utils/constants.dart';

class HiveRepository {
  Future<bool> get isEmpty async => (await _box).isEmpty;

  Future<Box<dynamic>> get _box async {
    if (!Hive.isBoxOpen(_boxName)) await Hive.openBox(_boxName);
    return Hive.box(_boxName);
  }

  static final _boxName = Constants.localStorageHiveName;

  Future<List<dynamic>?> readList(String key) async {
    final data = (await _box).get(key);
    if (data == null) {
      return null;
    }

    return jsonDecode(data) as List<dynamic>;
  }

  /// O data pode ser um List de: List\<String\>, List\<int\>, List\<Map\<String, dynamic\>\>, etc...
  Future<void> writeList(String key, List data) async {
    final String value = jsonEncode(data);
    await (await _box).put(key, value);
  }

  Future<void> close() async => (await _box).close();
}
