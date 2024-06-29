import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

void main() {
  setUp(() async {
    await loadAppFonts();
  });

  group('TodoPage widget', () {
    testGoldens(
        'должен правильно рендерить список моделей Todo для разных типов устройств',
        (widgetTester) async {
      //  arrange

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
          widget: const TodoPage(title: 'Todo List'),
          name: 'Todo List with default state',
        )
        ..addScenario(
          widget: const TodoPage(title: 'Todo List'),
          name: 'TodoList with first completed task',
          onCreate: (scenarioWidgetKey) async {
            final finder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byKey(const ValueKey('item_icon_1')),
            );

            expect(finder, findsOneWidget);
            await widgetTester.tap(finder);
          },
        );

      await widgetTester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(
        widgetTester,
        'todo_page_multiple_scenarios',
      );
    });
  });
}
