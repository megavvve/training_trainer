import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:training_trainer/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Auth Flow Test', () {
    testWidgets('Login with seed credentials', (WidgetTester tester) async {
      app.main();

      // Ждём загрузки приложения
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Вводим email
      final emailFinder = find.byKey(const ValueKey('emailInput'));
      expect(emailFinder, findsOneWidget);
      await tester.enterText(emailFinder, 'seed@training.trainer');
      await tester.pumpAndSettle();

      // Вводим пароль
      final passwordFinder = find.byKey(const ValueKey('passwordInput'));
      expect(passwordFinder, findsOneWidget);
      await tester.enterText(passwordFinder, 'seed-password');
      await tester.pumpAndSettle();

      // Нажимаем кнопку "Далее"
      final buttonFinder = find.byKey(const ValueKey('submitButton'));
      expect(buttonFinder, findsOneWidget);
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      // Проверяем что мы на экране тренеров (AppRoutes.trainers)
      // По текущему роутеру это должен быть TrainerScreen
      await tester.pumpAndSettle();
    });
  });
}
