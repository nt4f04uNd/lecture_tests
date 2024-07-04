import 'package:flutter/material.dart';
import 'package:lecture_about_tests/di.dart';
import 'package:lecture_about_tests/domain/environment.dart';
import 'package:lecture_about_tests/widgets/todo_page.dart';

class MyApp extends StatelessWidget {
  final Environment environment;

  const MyApp({super.key, this.environment = Environment.production});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        home: TodoPage(
          title: 'Today Tasks',
          todoRepository: DI.todoRepository,
        ),
      );
}
