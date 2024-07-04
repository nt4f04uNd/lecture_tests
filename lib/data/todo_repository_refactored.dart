import 'package:dio/dio.dart';
import 'package:lecture_about_tests/domain/todo_model.dart';

class TodoRepository {
  final TodoApi _todoApi;

  TodoRepository({
    required TodoApi todoApi,
  }) : _todoApi = todoApi;

  /// Создать новую задачу
  Future<void> create({required String title, bool isCompleted = false}) async {
    await _todoApi.saveTodo(title, isCompleted);
  }

  /// Получить из хранилища все задачи
  Future<Iterable<TodoModel>> fetchAll() {
    return _todoApi.getTodos();
  }
}

class TodoApi {
  final Dio _dio;

  TodoApi({required Dio dio}) : _dio = dio;

  Future<Iterable<TodoModel>> getTodos() async {
    final response = await _dio.get<List<dynamic>>('https://someapi.com/all');
    final json = response.data as List<dynamic>;

    return json.map((e) {
      final todoDto = e as Map<String, dynamic>;
      return TodoModel(
        id: todoDto['id'] as int,
        title: todoDto['title'] as String,
        isCompleted: todoDto['is_completed'] as bool,
      );
    }).toList();
  }

  Future<void> saveTodo(String title, bool isCompleted) async {
    await _dio.post<Map<String, dynamic>>('https://someapi.com/create', data: {
      'title': title,
      'is_completed': isCompleted,
    });
  }
}
