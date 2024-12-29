import 'package:sqa/entities/sqa_event.dart';

class EventDao {
  static List<SqaEvent> userEvents = [];

  List<SqaEvent> getUpcomingEvents() {
    //TODO replace

    List<SqaEvent> events = [];

    events.add(SqaEvent(
      id: "1",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(days: 3)),
      type: SqaEventType.Football,
    ));

    events.add(SqaEvent(
      id: "2",
      name: "Some Cart event",
      time: DateTime.now().add(const Duration(days: 2)),
      type: SqaEventType.Cart,
    ));

    events.add(SqaEvent(
      id: "3",
      name: "Some Basketball event",
      time: DateTime.now().add(const Duration(days: 1)),
      type: SqaEventType.Basketball,
    ));

    events.add(SqaEvent(
      id: "4",
      name: "Some Paddel event",
      time: DateTime.now().add(const Duration(hours: 7)),
      type: SqaEventType.Paddel,
    ));

    events.add(SqaEvent(
      id: "5",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(minutes: 35)),
      type: SqaEventType.Football,
    ));

    events.add(SqaEvent(
      id: "6",
      name: "Some Football event",
      time: DateTime.now().add(const Duration(days: 10)),
      type: SqaEventType.Football,
    ));

    return events;
  }

  Future<void> createSqaEvent(SqaEvent sqaEvent) async {
    userEvents.add(sqaEvent);
  }
}
