import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';

class SqaWidgetService {
  void showLoadingDialog(BuildContext context, String loadingMsg) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            const Image(
              height: 80,
              image: AssetImage('assets/images/sqa_logo_no_margin.jpeg'),
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              loadingMsg,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: SqaTheme.secondaryColor),
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
          ],
        ));
      },
    );
  }

  void showErrorSnackbar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            errorMsg,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red),
    );
  }
}
