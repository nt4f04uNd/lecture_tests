import 'package:flutter/material.dart';
import 'package:lecture_about_tests/domain/todo.dart';

typedef CheckBoxTapCallback = void Function(Todo);

class TodoItem extends StatelessWidget {
  final Todo item;
  final CheckBoxTapCallback onCheckBoxTap;

  const TodoItem({
    required this.item,
    required this.onCheckBoxTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.title,
            style: item.isCompleted
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
        ),
        GestureDetector(
          onTap: () => onCheckBoxTap(item),
          child: Icon(item.isCompleted
              ? Icons.check_box
              : Icons.check_box_outline_blank),
        )
      ],
    );
  }
}
