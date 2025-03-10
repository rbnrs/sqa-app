import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';

class SquadMemberWidget extends StatefulWidget {
  const SquadMemberWidget({super.key});

  @override
  State<SquadMemberWidget> createState() => _SquadMemberWidgetState();
}

class _SquadMemberWidgetState extends State<SquadMemberWidget> {
  @override
  Widget build(BuildContext context) {
    double avatarSize = 60;

    return InkWell(
      onTap: () {},
      child: Container(
        margin: SqaSpacing.mediumMarginEdgeInsets.copyWith(top: 0, bottom: 0),
        padding: SqaSpacing.smallPaddingEdgeInsets,
        child: Row(
          children: [
            Container(
              height: avatarSize,
              width: avatarSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: SqaTheme.secondaryColor,
              ),
              child: Icon(
                Icons.person,
                color: SqaTheme.fontColor,
                size: 35,
              ),
            ),
            const SizedBox(
              width: SqaSpacing.mediumMargin,
            ),
            Text(
              "Hello",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            const Chip(
              label: Text("Leader"),
            )
          ],
        ),
      ),
    );
  }
}
