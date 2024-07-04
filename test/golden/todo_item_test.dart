import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  group('TodoItem widget', () {
    testWidgets('должен правильно рендериться для завершенной модели Todo',
        (widgetTester) async {
      //  arrange
      const completedTodo = Todo(
        id: 1,
        title: 'It' 's completed task',
        isCompleted: true,
      );
      final todoItemWidget = TodoItemWidget(
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
      final actualFinder = find.byType(TodoItemWidget);
      await expectLater(
        actualFinder,
        matchesGoldenFile('templates/todo_completed_item.png'),
      );
    });
  });
}
