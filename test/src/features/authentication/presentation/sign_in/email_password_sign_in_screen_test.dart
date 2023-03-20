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
    },
  );
}
