import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:only_sales/src/features/authentication/domain/app_user.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets(
    'Cancel logout',
    (tester) async {
      final authRobot = AuthRobot(tester);
      await authRobot.pumpAccountScreen();
      await authRobot.tapLogoutButton();
      authRobot.expectLogoutDialogFound();
      await authRobot.tapCancelButton();
      authRobot.expectLogoutDialogNotFound();
    },
  );
  testWidgets(
    'Confirm logout, success',
    (tester) async {
      final authRobot = AuthRobot(tester);
      await authRobot.pumpAccountScreen();
      await authRobot.tapLogoutButton();
      authRobot.expectLogoutDialogFound();
      await authRobot.tapDialogLogoutButton();
      authRobot.expectLogoutDialogNotFound();
      authRobot.expectErrorAlertNotFound();
    },
  );

  testWidgets(
    'Confirm logout, failure',
    (tester) async {
      final authRobot = AuthRobot(tester);
      final exception = Exception('Connection failed');
      final authRepository = MockAuthRepository();
      when(authRepository.authStateChanges).thenAnswer(
        (_) => Stream.value(
          const AppUser(
            uid: '123',
            email: 'test@test.com',
          ),
        ),
      );
      when(authRepository.signOut).thenThrow(exception);
      await authRobot.pumpAccountScreen(authRepository: authRepository);
      await authRobot.tapLogoutButton();
      authRobot.expectLogoutDialogFound();
      await authRobot.tapDialogLogoutButton();
      authRobot.expectErrorAlertFound();
    },
  );
}
