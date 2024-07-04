class TodoModel {
  static const TodoModel unknown =
      TodoModel(id: -1, title: '', isCompleted: false);

  final int id;
  final String title;
  final bool isCompleted;

  const TodoModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ isCompleted.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          isCompleted == other.isCompleted;

  TodoModel copyWith({String? title, bool? isCompleted}) => TodoModel(
        id: id,
        title: title ?? this.title,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  @override
  String toString() =>
      'Todo{id: $id, title: $title, isCompleted: $isCompleted}';
}
