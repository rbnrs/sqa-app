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

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _checkAppRequirements(),
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

    Navigator.of(context).pushNamed('/home');

    debugPrint("Everthing okay");
  }

  void _showErrorMessage(String errorMessage) {
    errorMsg = errorMessage;
    hasError = true;
    setState(() {});
  }
}
