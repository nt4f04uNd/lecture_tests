import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  setUp(() async {
    await loadAppFonts();
  });

  group('TodoItem widget', () {
    testGoldens('должен правильно рендерить разные состояния',
        (widgetTester) async {
      //  arrange
      const completedTask =
          Todo(id: -1, title: 'CompletedTask', isCompleted: true);
      const uncompletedTask =
          Todo(id: -1, title: 'UncompletedTask', isCompleted: false);

      //  act
      final builder = DeviceBuilder()
        ..overrideDevicesForAllScenarios(
          devices: [
            Device.phone,
            Device.iphone11,
            Device.tabletPortrait,
            const Device(size: Size(768, 1024), name: 'iPad mini'),
          ],
        )
        ..addScenario(
          widget: TodoItemWidget(
            item: completedTask,
            onCheckBoxTap: (_) {},
          ),
          name: 'Todo Item for completed Task',
        )
        ..addScenario(
          widget: TodoItemWidget(
            item: uncompletedTask,
            onCheckBoxTap: (_) {},
          ),
          name: 'Todo Item for uncompleted Task',
        );

      await widgetTester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(
        widgetTester,
        'todo_item_multiple_scenarios',
      );
    });
  });
}
