import 'package:flutter_test/flutter_test.dart';

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
    'Confirm logout success',
    (tester) async {
      final authRobot = AuthRobot(tester);
      await authRobot.pumpAccountScreen();
      await authRobot.tapLogoutButton();
      authRobot.expectLogoutDialogFound();
      await authRobot.tapDialogLogoutButton();
      authRobot.expectLogoutDialogNotFound();
    },
  );
}
