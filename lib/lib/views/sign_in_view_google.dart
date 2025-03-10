import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';

class SignInViewGoogle extends StatefulWidget {
  const SignInViewGoogle({super.key});

  @override
  State<SignInViewGoogle> createState() => _SignInViewGoogleState();
}

class _SignInViewGoogleState extends State<SignInViewGoogle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createMailForm(),
    );
  }

  Widget _createMailForm() {
    return Column(
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
      ],
    );
  }
}
