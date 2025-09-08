import 'dart:io';

import 'package:hive/hive.dart';
import 'package:test/test.dart';
import 'package:testeapp/src/domain/todo.dart';
import 'package:testeapp/src/pages/home/hive_home_model.dart';
import 'package:testeapp/src/pages/home/home_model.dart';
import 'package:testeapp/src/repositories/hive_repository.dart';

void main() {
  late HiveHomeModel homeModel;
  setUp(() async {
    Hive.init(Directory.systemTemp.path);
    homeModel = HiveHomeModel(repository: HiveRepository());
    await homeModel.open();
  });
  test('Persists completion changes', () async {
    final toggledTaskTitle = HomeModel.tasksInInitialState_[0].title;
    await homeModel.toggle(title: toggledTaskTitle);
    await homeModel.close();
    homeModel = HiveHomeModel(repository: HiveRepository());
    await homeModel.open();
    expect(
        homeModel.tasksStream,
        emits(anyElement(predicate(
            (Todo task) => task.title == toggledTaskTitle && task.isCompleted,
            "is titled '$toggledTaskTitle' and completed"))));
  });
  tearDown(() async {
    await homeModel.close();
    await Hive.close();
    await Hive.deleteFromDisk();
  });
}
