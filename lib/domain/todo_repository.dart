import 'package:collection/collection.dart';
import 'package:lecture_about_tests/domain/todo.dart';

class TodoRepository {
  Set<Todo> _todos = {
    Todo(id: 1, title: 'Task 1', isCompleted: false),
    Todo(id: 2, title: 'Task 2', isCompleted: false),
    Todo(id: 3, title: 'Task 3', isCompleted: false),
    Todo(id: 4, title: 'Task 4', isCompleted: false),
    Todo(id: 5, title: 'Task 5', isCompleted: false),
  };

  void completeTodo(Todo todo) {
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: true) : e)
        .toSet();
  }

  void unCompleteTodo(Todo todo) {
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: false) : e)
        .toSet();
  }

  Todo create({bool isCompleted = false}) {
    final id =
        _todos.toList().sorted((a, b) => a.id.compareTo(b.id)).last.id + 1;

    final todo = Todo(id: id, title: 'Task $id', isCompleted: isCompleted);
    _todos.add(todo);

    return todo;
  }

  Iterable<Todo> fetchAll() => _todos.sorted((a, b) => a.id.compareTo(b.id));
}
