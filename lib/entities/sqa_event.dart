enum SqaEventType { Football, Cart, Basketball, Paddel }

class SqaEvent {
  final String id;
  final String name;
  final DateTime time;
  final SqaEventType type;

  SqaEvent(
      {required this.id,
      required this.name,
      required this.time,
      required this.type});
}
