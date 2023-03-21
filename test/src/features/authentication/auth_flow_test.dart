import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  testWidgets('Sign in and sign out flow', (tester) async {
    // Sign in
    final robot = Robot(tester);
    await robot.pumpMyApp();
    robot.expectFindAllProductCards();
    await robot.openPopupMenu();
    await robot.auth.openEmailPasswordSignInScreen();
    await robot.auth.signInWithEmailAndPassword();
    robot.expectFindAllProductCards();

    // Sign out
    await robot.openPopupMenu();
    await robot.auth.openAccountScreen();
    await robot.auth.tapLogoutButton();
    await robot.auth.tapDialogLogoutButton();
    robot.expectFindAllProductCards();
  });
}
