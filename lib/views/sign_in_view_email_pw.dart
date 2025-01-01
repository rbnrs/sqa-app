import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/themes/sqa_widget_service.dart';
import 'package:sqa/utils/helper.dart';

class SignInViewEmailPw extends StatefulWidget {
  const SignInViewEmailPw({super.key});

  @override
  State<SignInViewEmailPw> createState() => _SignInViewEmailPwState();
}

class _SignInViewEmailPwState extends State<SignInViewEmailPw> {
  final _formKey = GlobalKey<FormState>();
  String? _userEmail;
  String? _userPassword;

  bool _isValidMailAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createMailForm(),
    );
  }

  Widget _createMailForm() {
    double fullWidth = MediaQuery.of(context).size.width;
    double buttonHeight = 50;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: SqaSpacing.mediumHorizontalPadding,
            child: const Image(
              height: 160,
              image: AssetImage("assets/images/sqa_logo_no_margin.jpeg"),
            ),
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          Container(
            margin: SqaSpacing.mediumHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign in with E-Mail Address",
                ),
                const SizedBox(
                  height: SqaSpacing.mediumMargin,
                ),
                TextFormField(
                  validator: (value) {
                    return SqaHelper().emailValidator(value);
                  },
                  onChanged: (value) {
                    _userEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: SqaTheme.primaryColor,
                  decoration: const InputDecoration(
                      hintText: "Enter mail address",
                      prefixIcon: Icon(Icons.mail_outline)),
                ),
                const SizedBox(
                  height: SqaSpacing.mediumMargin,
                ),
                TextFormField(
                  validator: (value) {
                    return SqaHelper().passwordValidator(value);
                  },
                  onChanged: (value) {
                    _userEmail = value;
                  },
                  cursorColor: SqaTheme.primaryColor,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Enter password",
                      prefixIcon: Icon(Icons.lock_outline)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          Container(
            margin: SqaSpacing.mediumHorizontalPadding,
            width: fullWidth,
            height: buttonHeight,
            child: ElevatedButton(
                onPressed: () {
                  onPressedSignInWithMailAndPassword();
                },
                child: const Text(
                  "Login",
                )),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
        ],
      ),
    );
  }

  void onPressedSignInWithMailAndPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      UserCredential userCredentials = await auth.signInWithEmailAndPassword(
          email: _userEmail!, password: _userPassword!);
    } catch (e) {
      SqaWidgetService().showErrorSnackbar(context,
          "Login failed! Please check your email address and password");
    }
  }
}
