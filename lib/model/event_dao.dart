import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/utils/helper.dart';

class EventDao {
  static List<SqaEvent> userEvents = [];

  List<SqaEvent> getUpcomingEvents() {
    //TODO replace

    List<SqaEvent> events = [];

    events.add(SqaEvent(
      id: "1",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(days: 3)),
      type: "Football",
    ));

    events.add(SqaEvent(
      id: "2",
      name: "Some Cart event",
      time: DateTime.now().add(const Duration(days: 2)),
      type: "Football",
    ));

    events.add(SqaEvent(
      id: "3",
      name: "Some Basketball event",
      time: DateTime.now().add(const Duration(days: 1)),
      type: "Football",
    ));

    events.add(SqaEvent(
      id: "4",
      name: "Some Paddel event",
      time: DateTime.now().add(const Duration(hours: 7)),
      type: "Football",
    ));

    events.add(SqaEvent(
      id: "5",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(minutes: 35)),
      type: "Football",
    ));

    events.add(SqaEvent(
      id: "6",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(days: 10)),
      type: "Football",
    ));

    return events;
  }

  Future<void> createSqaEvent(SqaEvent sqaEvent) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference ref =
        await db.collection("events").add(sqaEvent.toJSON());
    debugPrint("Add ${ref.id}");
  }
}
