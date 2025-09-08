import 'package:test/test.dart';

import 'in_memory_home_model.dart';

void main() {
  final homeModel = InMemoryHomeModel();
  test('Clears tasks when closed', () async {
    homeModel.close();
    expect(await homeModel.getTasksInCurrentState_(), isEmpty);
  });
  tearDown(homeModel.close);
}
