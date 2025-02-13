import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/utils/helper.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: OutlinedButton(
            onPressed: () async {
              await SqaHelper().signGoogleOut();
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
            child: const Text("Logout")),
      ),
    );
  }
}
