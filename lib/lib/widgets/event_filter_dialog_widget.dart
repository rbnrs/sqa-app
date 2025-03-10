import 'package:flutter/material.dart';
import 'package:sqa/themes/sqa_spacing.dart';
import 'package:sqa/themes/sqa_theme.dart';

class EventFilterDialogWidget extends StatefulWidget {
  const EventFilterDialogWidget({super.key});

  @override
  State<EventFilterDialogWidget> createState() =>
      _EventFilterDialogWidgetState();
}

class _EventFilterDialogWidgetState extends State<EventFilterDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Container(
        padding: SqaSpacing.mediumPaddingEdgeInsets,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Filter Events",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              "Event ID",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "EventId"),
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              "Event Name",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Event Name"),
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              "SQA Leader",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: "SQA Leader"), // with value helper...
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              "Event Date",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FilledButton(
                onPressed: () async {
                  DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                        DateTime.now().year + 1,
                        DateTime.now().month,
                        DateTime.now().day,
                      ));

                  if (dateTime == null) return;

                  TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 0, minute: 0),
                  );

                  if (timeOfDay == null) return;
                  /*
                  _joinVoteEndDateEvent = dateTime;
                  _joinVoteEndDateEvent = _startDateEvent!
                      .copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);

                  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
                  _joinVoteEndDate = dateFormat.format(_joinVoteEndDateEvent!);

                  setState(() {});
                  */
                },
                child: const Text("FROM"),
              ),
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: FilledButton(
                onPressed: () async {
                  DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(
                        DateTime.now().year + 1,
                        DateTime.now().month,
                        DateTime.now().day,
                      ));

                  if (dateTime == null) return;

                  TimeOfDay? timeOfDay = await showTimePicker(
                    context: context,
                    initialTime: const TimeOfDay(hour: 0, minute: 0),
                  );

                  if (timeOfDay == null) return;
                  /*
                  _joinVoteEndDateEvent = dateTime;
                  _joinVoteEndDateEvent = _startDateEvent!
                      .copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);

                  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm");
                  _joinVoteEndDate = dateFormat.format(_joinVoteEndDateEvent!);

                  setState(() {});
                  */
                },
                child: const Text("TO"),
              ),
            ),
            const SizedBox(
              height: SqaSpacing.largeMargin,
            ),
            Text(
              "Location Search",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(
              height: SqaSpacing.smallMargin,
            ),
            Slider(
              value: 0,
              onChanged: (value) {},
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "20 km from current location",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: SqaTheme.subFontColor),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("GO!"),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
