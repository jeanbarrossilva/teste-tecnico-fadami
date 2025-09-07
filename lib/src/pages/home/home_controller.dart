import 'package:testeapp/src/domain/todo.dart';
import 'package:testeapp/src/pages/home/home_model.dart';

class HomeController {
  Stream<List<Todo>> get tasksStream => _model.tasksStream;
  Stream<String> get taskCompletionToTotalRatioStream =>
      _taskCompletionToTotalRatioStream;
  late Stream<String> _taskCompletionToTotalRatioStream;

  final HomeModel _model;

  HomeController({required HomeModel model}) : _model = model;

  Future<void> open() async {
    await _model.open();
    _taskCompletionToTotalRatioStream = tasksStream.map((tasks) =>
        "${tasks.where((task) => task.isCompleted).length}/${tasks.length}");
  }

  Future<void> toggle({required String id}) => _model.toggle(title: id);

  void close() => _model.close();
}
