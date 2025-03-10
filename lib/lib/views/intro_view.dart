// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqa/themes/sqa_theme.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  bool hasError = false;
  String errorMsg = "";

  late Future _checkAppRequirementsFuture;

  @override
  initState() {
    super.initState();
    _checkAppRequirementsFuture = _checkAppRequirements()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _checkAppRequirementsFuture,
      builder: (context, snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/sqa_logo.jpeg'),
            ),
            Text(
              hasError ? errorMsg : "Warm Up in Progress...",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: SqaTheme.secondaryColor),
            ),
            const Spacer(),
            hasError ? Container() : const LinearProgressIndicator()
          ],
        );
      },
    ));
  }

  Future? _checkAppRequirements() async {
    hasError = false;
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showErrorMessage("Please enable location service");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorMessage(
            "Location permissions are denied. Please grant location permission");
      }
    }

    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushNamed('/login');
      } else {
        Navigator.of(context).pushNamed('/home');
      }
    });
  }

  void _showErrorMessage(String errorMessage) {
    errorMsg = errorMessage;
    hasError = true;
    setState(() {});
  }
}
