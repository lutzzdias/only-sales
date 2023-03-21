import 'package:flutter_test/flutter_test.dart';

import '../../robot.dart';

void main() {
  testWidgets('Sign in and sign out flow', (tester) async {
    final robot = Robot(tester);
    await robot.pumpMyApp();
    robot.expectFindAllProductCards();
  });
}
