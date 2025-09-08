import 'package:test/test.dart';
import 'package:testeapp/src/domain/todo.dart';

void main() {
  group('JSON-to-to-do conversion', () {
    test("Throws when 'title' is not present", () {
      expect(() => Todo.fromJson({}), throwsA(isA<MissingMapKeyError>()));
    });
    test("Without 'isCompleted'", () {
      final expected = Todo(title: 'A');
      expect(Todo.fromJson({'title': 'A'}), equals(expected));
    });
    test("With 'isCompleted'", () {
      final expected = Todo(title: 'A', isCompleted: true);
      expect(
          Todo.fromJson({'title': 'A', 'isCompleted': true}), equals(expected));
    });
  });
  group('Completion toggling', () {
    test('Completes', () {
      expect(Todo(title: 'A').toggled.isCompleted, equals(true));
    });
    test('Undoes completion', () {
      expect(Todo(title: 'A', isCompleted: true).toggled.isCompleted,
          equals(false));
    });
  });
}
