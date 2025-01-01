import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_widget_service.dart';
import 'package:sqa/utils/font_awesome_icons.dart';
import 'package:sqa/utils/helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double buttonHeight = 50;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
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
          Text(
            "Join the Game, Own the Court",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Container(
            margin: SqaSpacing.mediumHorizontalPadding,
            width: fullWidth,
            height: buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () async {
                SqaWidgetService().showLoadingDialog(context, "");

                bool isAuth = await SqaHelper().signInWithGoogle();
                if (isAuth) {
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  SqaWidgetService().showErrorSnackbar(
                      context, "Google Sign in failed. Please try again");
                }
              },
              icon: const Icon(FontAwesomeIcons.google),
              label: const Text(
                "Sign in",
              ),
            ),
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          /*
          Container(
            margin: SqaSpacing.mediumHorizontalPadding,
            width: fullWidth,
            height: buttonHeight,
            child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: const Text(
                  "Sign up",
                )),
          ),
          const SizedBox(
            height: SqaSpacing.largeMargin,
          ),
          */
        ],
      ),
    );
  }
}
