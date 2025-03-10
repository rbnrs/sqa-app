import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/themes/sqa_widget_service.dart';
import 'package:sqa/widgets/count_down_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyConfirmCode = GlobalKey<FormState>();

  String _selectedCountryCode = "+49";
  String _telephoneNumber = "";
  String _smsCode = "";
  String _verifyId = "";
  bool _verificationCodeInput = false;
  final int _timeoutInSeconds = 45;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _verificationCodeInput
          ? _createVerificationCodeInput()
          : _createPhoneNumberInput(),
    );
  }

  Widget _createVerificationCodeInput() {
    double fullWidth = MediaQuery.of(context).size.width;
    double buttonHeight = 50;

    return Form(
      key: _formKeyConfirmCode,
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
                  "SMS Verification Code",
                ),
                const SizedBox(
                  height: SqaSpacing.mediumMargin,
                ),
                TextFormField(
                  onChanged: (value) {
                    _smsCode = value;
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: SqaTheme.primaryColor,
                  maxLength: 6,
                  decoration: const InputDecoration(
                      hintText: "Enter verification Code"),
                ),
                const SizedBox(
                  height: SqaSpacing.mediumMargin,
                ),
                Row(
                  children: [
                    const Spacer(),
                    CountDownWidget(
                      countdown: _timeoutInSeconds,
                      onComplete: () {
                        //_verificationCodeInput = false;
                        setState(() {});
                      },
                    )
                  ],
                )
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
                  onVerifyButtonPressed();
                },
                child: const Text(
                  "Verify",
                )),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
        ],
      ),
    );
  }

  Widget _createPhoneNumberInput() {
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
                  "Sign in with Phone Number",
                ),
                const SizedBox(
                  height: SqaSpacing.mediumMargin,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField(
                        onChanged: (val) {
                          _selectedCountryCode = val!;
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select a event type";
                          }

                          return null;
                        },
                        borderRadius: BorderRadius.circular(5),
                        dropdownColor: SqaTheme.backgroundColor,
                        value: _selectedCountryCode,
                        items: const [
                          DropdownMenuItem(
                            value: "+49",
                            child: Text("DE +49"),
                          ),
                          DropdownMenuItem(
                            value: "+41",
                            child: Text("CH +41"),
                          ),
                          DropdownMenuItem(
                            value: "+43",
                            child: Text("AT +43"),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: SqaSpacing.mediumMargin,
                    ),
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Please enter a phone number";
                          }

                          if (value.startsWith("0")) {
                            return "Please remove leading zero";
                          }

                          return null;
                        },
                        onChanged: (value) {
                          _telephoneNumber = value;
                        },
                        keyboardType: TextInputType.phone,
                        cursorColor: SqaTheme.primaryColor,
                        decoration: const InputDecoration(
                            hintText: "Enter phone number"),
                      ),
                    )
                  ],
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
                  onVerificationCodeButtonPressed();
                },
                child: const Text(
                  "Send verification Code",
                )),
          ),
          const SizedBox(
            height: SqaSpacing.mediumMargin,
          ),
        ],
      ),
    );
  }

  void onVerificationCodeButtonPressed() {
    FirebaseAuth auth = FirebaseAuth.instance;
    String telephoneNumber;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    telephoneNumber = "$_selectedCountryCode$_telephoneNumber";

    auth.verifyPhoneNumber(
        phoneNumber: telephoneNumber,
        verificationCompleted: (phoneCredentials) {},
        timeout: Duration(seconds: _timeoutInSeconds),
        verificationFailed: (exception) {
          _verificationCodeInput = false;
          SqaWidgetService().showErrorSnackbar(context,
              "Phone Verification failed! Please enter a valid phone number");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verifyId = verificationId;
          _showSMSCodeInput();
        },
        
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  void _showSMSCodeInput() {
    _verificationCodeInput = true;
  }

  void onVerifyButtonPressed() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verifyId, smsCode: _smsCode);
    UserCredential userCredentials =
        await auth.signInWithCredential(credential);

    int i = 0;
  }
}
