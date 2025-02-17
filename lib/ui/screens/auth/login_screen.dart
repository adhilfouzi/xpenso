import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/validator.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import 'emailverification.dart';
import 'widget/intro_appbar.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: const IntroAppbar(
          actions: [],
          titleText: 'Log in',
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.3,
                      width: width,
                      child: Center(
                        child: Image.asset(Images.logo, height: height * 0.25),
                      ),
                    ),
                    SignTextField(
                      textInputAction: TextInputAction.next,
                      controller: authProvider.emailTextEditingController,
                      isDate: false,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          InputValidators.validateEmail(value),
                    ),
                    SizedBox(height: height * 0.02),
                    PasswordTextField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      controller: authProvider.passwordTextEditingController,
                    ),
                    SizedBox(height: height * 0.02),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const EmailVerificationScreen(),
                          ),
                        );
                      },
                      child: const Text("Forget password"),
                    ),
                    SizedBox(height: height * 0.02),
                    Button().mainButton('Log in', context, () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      authProvider.signIn(context);
                    }),
                    SizedBox(height: height * 0.025),
                    const Text('or'),
                    SizedBox(height: height * 0.025),
                    Button().googleSignInButton(
                      context,
                      false,
                      () {
                        authProvider.googleSignIn(context);
                      },
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t have an account? '),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
