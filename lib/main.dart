import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:testeapp/src/app.dart';
import 'package:testeapp/src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(Constants.localStorageHiveName);

  Intl.defaultLocale = 'pt_BR';

  runApp(const App());
}
