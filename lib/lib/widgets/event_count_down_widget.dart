import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_theme.dart';

class EventCountDownWidget extends StatefulWidget {
  final int countdown; // Countdown in seconds
  final Function onComplete;
  final bool? lightMode;
  final double? fontSize;

  const EventCountDownWidget({
    super.key,
    required this.countdown,
    this.lightMode,
    required this.onComplete,
    this.fontSize,
  });

  @override
  State<EventCountDownWidget> createState() => _EventCountDownWidgetState();
}

class _EventCountDownWidgetState extends State<EventCountDownWidget> {
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

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final days = (seconds ~/ (24 * 3600)).toString().padLeft(2, '0');
    final hours = ((seconds % (24 * 3600)) ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return 'D $days H $hours M $minutes S $secs';
  }

  @override
  Widget build(BuildContext context) {
    final days = (_remainingTime ~/ (24 * 3600)).toString().padLeft(2, '0');
    final hours =
        ((_remainingTime % (24 * 3600)) ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_remainingTime % 3600) ~/ 60).toString().padLeft(2, '0');
    final secs = (_remainingTime % 60).toString().padLeft(2, '0');

    return Row(
      children: [
        Column(
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Card(
                color: widget.lightMode != null && widget.lightMode == true
                    ? Colors.white
                    : SqaTheme.secondaryColor,
                child: Center(
                  child: Text(
                    days,
                    style: widget.lightMode != null && widget.lightMode == true
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: SqaTheme.secondaryColor)
                        : null,
                  ),
                ),
              ),
            ),
            const Text("Days")
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Card(
                color: widget.lightMode != null && widget.lightMode == true
                    ? Colors.white
                    : SqaTheme.secondaryColor,
                child: Center(
                  child: Text(
                    hours,
                    style: widget.lightMode != null && widget.lightMode == true
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: SqaTheme.secondaryColor)
                        : null,
                  ),
                ),
              ),
            ),
            const Text("Hours")
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Card(
                color: widget.lightMode != null && widget.lightMode == true
                    ? Colors.white
                    : SqaTheme.secondaryColor,
                child: Center(
                  child: Text(
                    minutes,
                    style: widget.lightMode != null && widget.lightMode == true
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: SqaTheme.secondaryColor)
                        : null,
                  ),
                ),
              ),
            ),
            const Text("Minutes")
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 60,
              width: 50,
              child: Card(
                color: widget.lightMode != null && widget.lightMode == true
                    ? Colors.white
                    : SqaTheme.secondaryColor,
                child: Center(
                  child: Text(
                    secs,
                    style: widget.lightMode != null && widget.lightMode == true
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: SqaTheme.secondaryColor)
                        : null,
                  ),
                ),
              ),
            ),
            const Text("Seconds")
          ],
        ),
      ],
    );
    return Text(
      formatTime(_remainingTime),
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: SqaTheme.subFontColor,
            fontSize: widget.fontSize,
          ),
    );
  }
}
