import 'package:flutter_test/flutter_test.dart';
import 'package:lecture_about_tests/data/todo_repository_refactored.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late TodoApiMock todoApiMock;
  late TodoRepository repository;

  setUp(() {
    todoApiMock = TodoApiMock();
    when(() => todoApiMock.saveTodo(any(), any()))
        .thenAnswer((_) async => Todo.unknown);

    when(() => todoApiMock.saveTodo(
            any(that: isA<String>()), any(that: isA<bool>())))
        .thenAnswer((_) async => Todo.unknown);

    repository = TodoRepository(todoApi: todoApiMock);
  });

  group('TodoRepository', () {
    test(
        'и его метод create должен выполнить обращение к TodoApi с правильными аргументами',
        () async {
      //  arrange
      const expectedTitle = 'Новая задача';
      const expectedIsCompleted = true;

      //  act
      await repository.create(
        title: expectedTitle,
        isCompleted: expectedIsCompleted,
      );

      //  assert
      final verification =
          verify(() => todoApiMock.saveTodo(captureAny(), captureAny()))
              .captured;

      expect(verification.first, expectedTitle);
      expect(verification.last, expectedIsCompleted);
    });
  });
}

class TodoApiMock extends Mock implements TodoApi {}
