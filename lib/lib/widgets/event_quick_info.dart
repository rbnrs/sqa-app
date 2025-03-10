import 'package:flutter/material.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/sports_dao.dart';
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
    List<SportType> sportsTypes = SportsDao().getSportsTypes();
    SportType sportType = sportsTypes.firstWhere(
      (element) {
        return element.name == widget.sqaEvent.sportsType;
      },
    );

    return InkWell(
      onTap: () {
        String routeName = Uri(
          path: '/detail',
          queryParameters: {
            'eventId': widget.sqaEvent.id,
          },
        ).toString();

        Navigator.of(context)
            .pushNamedAndRemoveUntil(routeName, ModalRoute.withName('/home'));
      },
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
                sportType.icon,
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
                  SqaHelper().leftTimeForEvent(SqaHelper()
                      .eventStartDateToDateTime(widget.sqaEvent.startDate)),
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
