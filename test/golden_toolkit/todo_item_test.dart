import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await loadAppFonts();
  });

  group('TodoItem widget', () {
    testWidgets('должен правильно рендериться для завершенной модели Todo',
        (widgetTester) async {
      //  arrange
      const completedTodo = Todo(
        id: 1,
        title: 'It' 's completed task',
        isCompleted: true,
      );
      final todoItemWidget = TodoItem(
        item: completedTodo,
        onCheckBoxTap: (_) {},
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoItemWidget,
        ),
      ));

      //  assert
      final actualFinder = find.byType(Row);
      expectLater(
        actualFinder,
        matchesGoldenFile('templates/todo_completed_item.png'),
      );
    });
  });
}
