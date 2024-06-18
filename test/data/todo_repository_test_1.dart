import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'TodoRepository и его метод fetchAll должен вернуть таски в упорядоченном порядке',
      () {});

  test(
      'TodoRepository и его метод create должен создать новую задачу со следующим Id в списке ',
      () {});

  test(
      'TodoRepository и его метод create после создания задачи должен поместить ее в хранилище ',
      () {});

  test(
      'TodoRepository и его метод removeById после удаления задачи должен удалить ее из хранилища ',
      () {});

  test(
      'TodoRepository и его метод removeById при указании несуществующей задачи должен упасть с исключением',
      () {});

  test(
      'TodoRepository и его метод completeTodo должен перевести задачу в состояние Completed',
      () {});

  test(
      'TodoRepository и его метод completeTodo при указании несуществующей задачи должен упасть с исключением',
      () {});

  test(
      'TodoRepository и его метод unCompleteTodo должен восстановить задачу в незавершенное состояние',
      () {});

  test(
      'TodoRepository и его метод unCompleteTodo при указании несуществующей задачи должен упасть с исключением',
      () {});
}
