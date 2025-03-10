import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/model/sports_dao.dart';
import 'package:sqa/model/users_dao.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';
import 'package:sqa/utils/helper.dart';

class EventInfoWidget extends StatefulWidget {
  final SqaEvent sqaEvent;
  const EventInfoWidget({super.key, required this.sqaEvent});

  @override
  State<EventInfoWidget> createState() => _EventInfoWidgetState();
}

class _EventInfoWidgetState extends State<EventInfoWidget> {
  @override
  Widget build(BuildContext context) {
    SportType sportType = SportsDao()
        .getSportsTypes()
        .firstWhere((element) => element.name == widget.sqaEvent.sportsType);

    String userId = FirebaseAuth.instance.currentUser!.uid;

    return InkWell(
      onTap: () {
        String routeName = Uri(
          path: '/detail',
          queryParameters: {
            'eventId': widget.sqaEvent.id,
          },
        ).toString();

        Navigator.of(context).pushNamed(routeName);
      },
      child: Container(
        padding: SqaSpacing.largePaddingEdgeInsets,
        child: Row(
          children: [
            Container(
              padding: SqaSpacing.mediumPaddingEdgeInsets,
              decoration: BoxDecoration(
                color: SqaTheme.secondaryColor,
                borderRadius: BorderRadius.circular(500),
              ),
              child: Icon(
                sportType.icon,
                color: SqaTheme.backgroundColor,
              ),
            ),
            const SizedBox(
              width: SqaSpacing.mediumMargin,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sqaEvent.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
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
                widget.sqaEvent.creator == userId
                    ? const Text("SQA Leader: You")
                    : FutureBuilder(
                        future: UsersDao()
                            .readUserByUserId(widget.sqaEvent.creator),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Text(
                                "SQA Leader: ${snapshot.data!.username}");
                          }

                          return const Text("");
                        },
                      )
              ],
            ),
            const Spacer(),
            Text(
              "${widget.sqaEvent.participants.length} / ${widget.sqaEvent.maxParticipants}",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: SqaTheme.subFontColor),
            ),
          ],
        ),
      ),
    );
  }
}
