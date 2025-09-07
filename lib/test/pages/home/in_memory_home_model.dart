import 'package:testeapp/src/domain/todo.dart';
import 'package:testeapp/src/pages/home/home_model.dart';

base class InMemoryHomeModel extends HomeModel {
  @override
  Future<bool> get isStale_ async => _tasks.isEmpty;

  var _tasks = List<Todo>.empty();

  @override
  Future<void> persist_({required List<Todo> tasks}) async => _tasks = tasks;

  @override
  Future<void> onToggle_({required String title}) async {
    for (final (index, task) in _tasks.indexed) {
      if (task.title != title) continue;
      _tasks[index] = task.toggled;
      break;
    }
  }

  @override
  Future<List<Todo>> getTasksInCurrentState_() async => _tasks;

  @override
  Future<void> onDidClose_() async => _tasks = List.empty();
}
