import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

class SqaHelper {
  String leftTimeForEvent(DateTime eventTime) {
    final now = DateTime.now();
    final difference = eventTime.difference(now);

    if (difference.isNegative) {
      return "Time has passed"; // Handle past dates
    }

    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (days > 0) {
      return days == 1 ? "1 day left" : "$days days left";
    } else if (hours > 0) {
      return hours == 1 ? "1 hour left" : "$hours hours left";
    } else if (minutes > 0) {
      return minutes == 1 ? "1 minute left" : "$minutes minutes left";
    } else {
      return "Less than a minute left";
    }
  }

  Future<Uint8List> flutterIconToUint8List(
      IconData icon, Color color, double size) async {
    // Create a widget to render the icon
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Style the icon
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size,
        fontFamily: icon.fontFamily,
        color: color,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    // Convert canvas to image
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());

    // Convert image to byte buffer
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
