import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_theme.dart';

class CountDownWidget extends StatefulWidget {
  final int countdown;
  final Function onComplete;
  const CountDownWidget({
    super.key,
    required this.countdown,
    required this.onComplete,
  });

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  late Timer _timer;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();

    _remainingTime = widget.countdown;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingTime <= 0) {
          _timer.cancel();
          widget.onComplete();
        }

        setState(() {
          _remainingTime--;
        });
      },
    );
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTime(_remainingTime),
      style: Theme.of(context)
          .textTheme
          .labelLarge!
          .copyWith(color: SqaTheme.subFontColor),
    );
  }
}
