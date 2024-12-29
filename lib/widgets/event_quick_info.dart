import 'package:flutter/material.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/utils/helper.dart';

class EventQuickInfo extends StatefulWidget {
  final SqaEvent sqaEvent;

  const EventQuickInfo({super.key, required this.sqaEvent});

  @override
  State<EventQuickInfo> createState() => _EventQuickInfoState();
}

class _EventQuickInfoState extends State<EventQuickInfo> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: SqaSpacing.mediumPaddingEdgeInsets,
        child: Row(
          children: [
            Container(
              padding: SqaSpacing.mediumPaddingEdgeInsets,
              decoration: BoxDecoration(
                color: SqaTheme.primaryColor,
                borderRadius: BorderRadius.circular(500),
              ),
              child: Icon(
                Icons.sports,
                color: SqaTheme.backgroundColor,
              ),
            ),
            const SizedBox(
              width: SqaSpacing.largeMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sqaEvent.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: SqaTheme.fontColor),
                ),
                Text(
                  SqaHelper().leftTimeForEvent(widget.sqaEvent.time),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: SqaTheme.subFontColor),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: SqaTheme.secondaryColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
