import 'package:flutter/material.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

class TodoPage extends StatefulWidget {
  final String title;

  const TodoPage({super.key, required this.title});

  @override
  State<TodoPage> createState() => TodoPageState();
}

@visibleForTesting
class TodoPageState extends State<TodoPage> {
  List<Todo> todos = [];
  ScrollController scrollController = ScrollController();
  Todo? selectedTodo;

  @override
  void initState() {
    super.initState();
    todos = DI.todoRepository.fetchAll().toList();
    selectedTodo = todos.last;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        key: const Key('long_list'),
        controller: scrollController,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return GestureDetector(
            onTap: () => setState(() => selectedTodo = todo),
            child: ListTile(
              selected: _isSelected(todo),
              selectedTileColor: theme.primaryColor,
              selectedColor: theme.scaffoldBackgroundColor,
              tileColor: todo.isCompleted ? theme.disabledColor : null,
              title: TodoItem(
                item: todo,
                key: ValueKey('item_${todo.id}'),
                onCheckBoxTap: _handleCheckBoxTap,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('todo_creation'),
        onPressed: _createTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _createTask() {
    setState(() {
      selectedTodo = DI.todoRepository.create();
      todos = DI.todoRepository.fetchAll().toList();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });
    });
  }

  void _handleCheckBoxTap(Todo todo) {
    if (todo.isCompleted) {
      DI.todoRepository.unCompleteTodo(todo);
    } else {
      DI.todoRepository.completeTodo(todo);
    }

    setState(() {
      todos = DI.todoRepository.fetchAll().toList();
      selectedTodo = todo;
    });
  }

  bool _isSelected(Todo todo) => selectedTodo?.id == todo.id;
}
