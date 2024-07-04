import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

void main() {
  setUp(() async {
    await loadAppFonts();
  });

  group('TodoPage widget', () {
    testWidgets('должен правильно рендерить список моделей Todo',
        (widgetTester) async {
      //  arrange
      final todoPageWidget = TodoPage(
        title: 'Todo List',
        todoRepository: DI.todoRepository,
      );

      //  act
      await widgetTester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: todoPageWidget,
        ),
      ));

      //  assert
      final actualFinder = find.byType(TodoPage);
      await expectLater(
        actualFinder,
        matchesGoldenFile('templates/todo_page.png'),
      );
    });
  });
}
