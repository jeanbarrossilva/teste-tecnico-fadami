import 'package:testeapp/src/domain/todo.dart';
import 'package:testeapp/src/pages/home/home_model.dart';
import 'package:testeapp/src/repositories/hive_repository.dart';

base class HiveHomeModel extends HomeModel {
  @override
  Future<bool> get isStale_ => _repository.isEmpty;

  final HiveRepository _repository;

  static final _key = 'tasks';

  HiveHomeModel({required HiveRepository repository})
      : _repository = repository;

  @override
  Future<void> persist_({required List<Todo> tasks}) => _repository.writeList(
      _key, List.unmodifiable(tasks.map((task) => task.toJson())));

  @override
  Future<void> onToggle_({required String title}) async {
    final jsons =
        List.unmodifiable((await getTasksInCurrentState_()).map((task) {
      if (task.title != title) return task;
      return task.toggled.toJson();
    }));
    await _repository.writeList(_key, jsons);
  }

  @override
  Future<List<Todo>> getTasksInCurrentState_() async {
    final jsons =
        (await _repository.readList(_key))?.cast<Map<String, dynamic>>() ?? [];
    return List.unmodifiable(jsons.map(Todo.fromJson));
  }

  @override
  Future<void> onDidClose_() => _repository.close();
}
