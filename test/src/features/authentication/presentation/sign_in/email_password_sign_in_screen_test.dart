import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:only_sales/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = 'test@test.com';
  const testPassword = '1234';

  late MockAuthRepository authRepository;

  setUp(() => authRepository = MockAuthRepository());

  group(
    'signIn',
    () {
      testWidgets(
        '''
          Given formType is signIn
          When tap on the sign-in button
          And fields are empty
          Then signInWithEmailAndPassword is not called
        ''',
        (tester) async {
          final authRobot = AuthRobot(tester);
          await authRobot.pumpEmailAndPasswordSignInContents(
            authRepository: authRepository,
            formType: EmailPasswordSignInFormType.signIn,
          );
          await authRobot.tapEmailAndPasswordSubmitButton();
          verifyNever(
            () => authRepository.signInWithEmailAndPassword(
              any(),
              any(),
            ),
          );
        },
      );

      testWidgets(
        '''
          Given formType is signIn
          When enter valid email and password
          And tap on the sign-in button
          Then signInWithEmailAndPassword is called
          And onSignedIn callback is called
          And error alert is not shown
        ''',
        (tester) async {
          var didSignIn = false;
          final authRobot = AuthRobot(tester);
          when(() => authRepository.signInWithEmailAndPassword(
                testEmail,
                testPassword,
              )).thenAnswer((_) => Future.value());
          await authRobot.pumpEmailAndPasswordSignInContents(
            authRepository: authRepository,
            formType: EmailPasswordSignInFormType.signIn,
            onSignedIn: () => didSignIn = true,
          );
          await authRobot.enterEmail(testEmail);
          await authRobot.enterPassword(testPassword);
          await authRobot.tapEmailAndPasswordSubmitButton();
          verify(
            () => authRepository.signInWithEmailAndPassword(
              testEmail,
              testPassword,
            ),
          ).called(1);
          expect(didSignIn, true);
          authRobot.expectErrorAlertNotFound();
        },
      );
    },
  );
}
