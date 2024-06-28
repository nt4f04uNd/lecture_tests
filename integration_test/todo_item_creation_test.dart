import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('OnTap по кнопке создания Todo', () {
    testWidgets('должен создавать новый элемент TodoItem в списке задач', (widgetTester) async {});
  });

  group('OnTap по иконке завершения', () {
    testWidgets('должен переводить модель Todo в завершенное состояние', (widgetTester) async {});
  });
}
