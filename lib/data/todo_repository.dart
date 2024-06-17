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
    _guard(todo.id);
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: true) : e)
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

  void removeById(int id) {
    _guard(id);
    _todos = _todos.where((e) => e.id != id).toSet();
  }

  void unCompleteTodo(Todo todo) {
    _guard(todo.id);
    _todos = _todos
        .map((e) => e == todo ? e.copyWith(isCompleted: false) : e)
        .toSet();
  }

  void update({
    required int id,
    required String title,
    bool? isCompleted,
  }) {
    _guard(id);
    _todos = _todos
        .map((e) => e.id == id
            ? e.copyWith(
                title: title,
                isCompleted: isCompleted ?? e.isCompleted,
              )
            : e)
        .toSet();
  }

  void _guard(int id) {
    if (_todos.none((e) => e.id == id)) {
      throw Exception('There are no todo with id = $id!');
    }
  }
}
