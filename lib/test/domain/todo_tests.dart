import 'package:test/test.dart';
import 'package:testeapp/src/domain/todo.dart';

void main() {
  group('Map-to-to-do conversion', () {
    test("Throws when 'title' is not present", () {
      expect(() => Todo.fromMap({}), throwsA(isA<MissingMapKeyError>()));
    });
    test("Without 'isCompleted'", () {
      expect(Todo.fromMap({'title': 'A'}), equals(Todo(title: 'A')));
    });
    test("With 'isCompleted'", () {
      expect(Todo.fromMap({'title': 'A', 'isCompleted': true}),
          equals(Todo(title: 'A', isCompleted: true)));
    });
  });
  group('Completion toggling', () {
    test('Completes', () {
      final task = Todo(title: 'A');
      task.toggle();
      expect(task.isCompleted, equals(true));
    });
    test('Undoes completion', () {
      final task = Todo(title: 'A', isCompleted: true);
      task.toggle();
      expect(task.isCompleted, equals(false));
    });
  });
}
