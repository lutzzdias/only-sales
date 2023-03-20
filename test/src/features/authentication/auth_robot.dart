import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:only_sales/src/features/authentication/presentation/account/account_screen.dart';

class AuthRobot {
  AuthRobot(this.tester);
  final WidgetTester tester;

  Future<void> pumpAccountScreen() async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    final logoutButton = find.text('Logout');
    expect(logoutButton, findsOneWidget);
    await tester.tap(logoutButton);
    await tester.pump();
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');
    expect(cancelButton, findsOneWidget);
    await tester.tap(cancelButton);
    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsOneWidget);
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');
    expect(dialogTitle, findsNothing);
  }
}
