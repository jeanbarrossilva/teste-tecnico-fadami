import 'package:test/test.dart';
import 'package:testeapp/src/domain/todo.dart';
import 'package:testeapp/src/pages/home/home_model.dart';

import 'in_memory_home_model.dart';

void main() {
  late HomeModel homeModel;
  setUp(() async {
    homeModel = InMemoryHomeModel();
    await homeModel.open();
  });
  group("Openness assertion", () {
    test('Throws when obtaining stream while closed', () async {
      await homeModel.close();
      expect(() => homeModel.tasksStream, throwsStateError);
    });
    test('Throws when toggling task while closed', () async {
      await homeModel.close();
      expect(
          () =>
              homeModel.toggle(title: HomeModel.tasksInInitialState_[0].title),
          throwsStateError);
    });
  });
  test('Streams to-dos in initial state',
      () => expect(homeModel.tasksStream, emitsInOrder([isList])));
  test('Streams to-dos when one of them gets toggled', () async {
    final toggledTaskTitle = HomeModel.tasksInInitialState_[0].title;
    await homeModel.toggle(title: toggledTaskTitle);
    expect(
        homeModel.tasksStream,
        emits(anyElement(predicate(
            (Todo task) => task.title == toggledTaskTitle && task.isCompleted,
            "is titled '$toggledTaskTitle' and completed"))));
  });
  test('Streamed list of to-dos is immutable', () {
    expect(() async => (await homeModel.tasksStream.first).clear(),
        throwsUnsupportedError);
  });
  test('Finishes stream when closed', () {
    homeModel.close();
    expect(homeModel.tasksStream, emitsInOrder([isList, emitsDone]));
  });
  tearDown(() => homeModel.close());
}
