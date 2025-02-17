import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import '../../../core/images.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/validator.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import 'widget/intro_appbar.dart';
import 'widget/privacy_policy_checkbox.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: const IntroAppbar(actions: [], titleText: 'Sign up'),
        body: SingleChildScrollView(
          child: Form(
            key: authProvider.signupFormKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.3,
                  width: width,
                  child: Center(
                    child: Image.asset(Images.logo, height: height * 0.25),
                  ),
                ),
                SignTextField(
                  hintText: "Full Name",
                  isDate: false,
                  validator: (value) =>
                      InputValidators.validateEmpty("Name", value),
                  controller: authProvider.fullNameText,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                SignTextField(
                  isDate: false,
                  hintText: 'Phone Number',
                  controller: authProvider.phoneNumberText,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      InputValidators.validatePhoneNumber(value),
                ),
                SignTextField(
                  isDate: false,
                  hintText: 'Email',
                  controller: authProvider.emailText,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => InputValidators.validateEmail(value),
                  textInputAction: TextInputAction.next,
                ),
                PasswordTextField(
                  textInputAction: TextInputAction.done,
                  hintText: 'Enter Password',
                  keyboardType: TextInputType.visiblePassword,
                  controller: authProvider.passwordText,
                ),
                PrivacyPolicyCheckbox(),
                SizedBox(height: height * 0.02),
                Button().mainButton('Sign up', context, () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  authProvider.signup(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
