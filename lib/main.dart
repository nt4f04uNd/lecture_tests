import 'package:flutter/material.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/todo.dart';
import 'package:lecture_about_tests/widgets/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoPage(title: 'Today Tasks'),
    );
  }
}

class TodoPage extends StatefulWidget {
  final String title;

  const TodoPage({super.key, required this.title});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = [];
  ScrollController scrollController = ScrollController();
  Todo? selectedTodo;

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
                key: Key('item_${todo.id}'),
                onCheckBoxTap: _handleCheckBoxTap,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void initState() {
    super.initState();
    todos = DI.todoRepository.fetchAll().toList();
    selectedTodo = todos.last;
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
