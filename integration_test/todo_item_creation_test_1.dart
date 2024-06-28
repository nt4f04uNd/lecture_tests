import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/environment.dart';
import 'package:lecture_about_tests/widgets/app.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('OnTap по кнопке создания Todo', () {
    testWidgets('должен создавать новый элемент TodoItem в списке задач', (widgetTester) async {
      //  arrange
      final todos = DI.todoRepository.fetchAll();
      await widgetTester.pumpWidget(
        const MyApp(
          environment: Environment.test,
        ),
      );

      //  act
      final fab = find.byKey(const ValueKey('todo_creation'));
      const createdTodosCount = 5;
      for (var i = 0; i <= createdTodosCount; i++) {
        //  создаем таску
        await widgetTester.tap(fab);
        await widgetTester.pumpAndSettle();
      }
      final lastTodoId = todos.last.id + createdTodosCount + 1;

      final listFinder = find.byType(Scrollable);
      final key = ValueKey('item_$lastTodoId');
      final byKeyFinder = find.byKey(key);

      //  scroll to new created todo_item element
      await widgetTester.scrollUntilVisible(
        byKeyFinder,
        100.0,
        scrollable: listFinder,
      );

      //  assert
      expect(byKeyFinder, findsOneWidget);
    });
  });

  group('OnTap по иконке завершения', () {
    testWidgets('должен переводить модель Todo в завершенное состояние', (widgetTester) async {
      //  arrange
      final todoList = DI.todoRepository.fetchAll();
      await widgetTester.pumpWidget(
        const MyApp(
          environment: Environment.test,
        ),
      );

      //  act
      const completedTodosCount = 5;
      final totalCount = todoList.length;

      for (var i = 0; i < completedTodosCount; i++) {
        //  комплитим таску
        final itemIconFinder = find.byKey(ValueKey('item_icon_${i + 1}'));
        await widgetTester.tap(itemIconFinder);
        await widgetTester.pumpAndSettle();
      }

      //  assert
      final items = widgetTester.allWidgets.whereType<TodoItem>();
      expect(items.length, totalCount);

      final pageState = widgetTester.allStates.whereType<TodoPageState>().first;
      expect(pageState.todos.where((e) => e.isCompleted).length, completedTodosCount);
    });
  });
}
