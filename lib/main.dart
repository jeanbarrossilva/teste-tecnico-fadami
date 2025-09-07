import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:testeapp/src/app.dart';
import 'package:testeapp/src/pages/home/home_controller.dart';
import 'package:testeapp/src/pages/home/hive_home_model.dart';
import 'package:testeapp/src/repositories/hive_repository.dart';
import 'package:testeapp/src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Intl.defaultLocale = 'pt_BR';
  final homeController =
      HomeController(model: HiveHomeModel(repository: HiveRepository()));
  await homeController.open();
  runApp(App(homeController: homeController));
}
