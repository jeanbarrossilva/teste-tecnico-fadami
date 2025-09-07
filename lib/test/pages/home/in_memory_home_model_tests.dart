import 'package:test/test.dart';
import 'package:testeapp/test/pages/home/in_memory_home_model.dart';

void main() {
  final homeModel = InMemoryHomeModel();
  test('Clears tasks upon when closed', () async {
    homeModel.close();
    expect(await homeModel.getTasksInCurrentState_(), isEmpty);
  });
  tearDown(homeModel.close);
}
