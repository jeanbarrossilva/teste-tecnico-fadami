import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:testeapp/src/domain/todo.dart';

abstract base class HomeModel {
  Stream<List<Todo>> get tasksStream {
    assertIsOpen();
    return _tasksStream;
  }

  var _isOpen = false;
  final _tasksSubject = BehaviorSubject<List<Todo>>();
  late Stream<List<Todo>> _tasksStream;

  Future<bool> get isStale_;

  static final List<Todo> tasksInInitialState_ =
      List.from(_modifiableTasksInInitialState, growable: false);

  static final List<Todo> _modifiableTasksInInitialState = List.from([
    "Habilitar a interação com o checkbox",
    "Implementar ListView na lista de tarefas",
    "Na classe Todo, implementar metodo para inverter o status atual da tarefa",
    "Na classe Todo, implementar o factory fromMap() para instanciar o objeto a partir de um Map<String, dynamic>",
    "Customizar item que esteja concluído",
    "Adicionar um contador de tarefas. Ex.: 3/10",
    "Abstrair a tarefa para um Widget reutilizável no arquivo /src/widgets/task.dart",
    "Utilize a classe HiveRepository para salvar o estado da lista de tarefas no dispositivo",
    "Ao reiniciar o app o estado da lista salvo deve ser retomado",
    "Instalar e configurar o GetX no projeto",
    "Refatorar o app.dart, home_page.dart e task.dart para usar GetX",
  ].map((title) => Todo(title: title)));

  Future<void> open() async {
    if (_isOpen) return;
    await _persistIfStale();
    _tasksStream = _tasksSubject.shareReplay();
    _tasksSubject.add(List.unmodifiable(await getTasksInCurrentState_()));
    _isOpen = true;
  }

  Future<void> close() async {
    if (!_isOpen) return;
    await _tasksSubject.close();
    await onDidClose_();
    _isOpen = false;
  }

  Future<void> onDidClose_();

  Future<void> toggle({required String title}) async {
    assertIsOpen();
    await onToggle_(title: title);
    _tasksSubject.add(List.unmodifiable(await getTasksInCurrentState_()));
  }

  Future<void> persist_({required List<Todo> tasks});

  Future<List<Todo>> getTasksInCurrentState_();

  Future<void> onToggle_({required String title});

  Future<void> _persistIfStale() async {
    // Since the addition of a to-do is not an implemented feature, the hardcoded to-dos should only
    // be persisted when they have not been yet (e.g., the first time the app is launched) or their
    // completion state is modified. This model not being stale denotes that such to-dos have
    // already been persisted; therefore, persistence can be skipped.
    if (!(await isStale_)) return;

    await persist_(tasks: _modifiableTasksInInitialState);
  }

  void assertIsOpen() {
    if (_isOpen) return;
    throw StateError(
        "Cannot perform an operation while the model is closed. Did you forget to call open()?");
  }
}
