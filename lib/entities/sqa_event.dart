import 'dart:convert';

enum SqaEventType { typeA, typeB, typeC } // Replace with actual event types

class SqaEvent {
  final String id;
  final String name;
  final DateTime time;
  final String type;

  SqaEvent({
    required this.id,
    required this.name,
    required this.time,
    required this.type,
  });

  // Convert SqaEvent to JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'time': time.toIso8601String(),
      'type': type.toString().split('.').last, // Save enum as a string
    };
  }

  // Create SqaEvent from Map
  factory SqaEvent.fromMap(Map<String, dynamic> map) {
    return SqaEvent(
      id: map['id'] as String,
      name: map['name'] as String,
      time: DateTime.parse(map['time'] as String),
      type: map['type'] as String,
    );
  }

  // Optional: Create SqaEvent from JSON String
  factory SqaEvent.fromJson(String source) =>
      SqaEvent.fromMap(json.decode(source));

  // Optional: Convert SqaEvent to JSON String
  String toJsonString() => json.encode(toJSON());
}
