import 'dart:convert';

class SqaEvent {
  final String id;
  final String name;
  final String sportsType;
  final String creator;
  final String startDate;
  final String duration;
  final int maxParticipants;
  final String location;
  final String description;
  final List<String> participants;

  SqaEvent({
    required this.id,
    required this.name,
    required this.sportsType,
    required this.creator,
    required this.startDate,
    required this.location,
    required this.description,
    required this.maxParticipants,
    required this.duration,
    required this.participants,
  });

  // Convert SqaEvent to JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'sportsType': sportsType, // Stored as string
      'creator': creator,
      'startDate': startDate,
      'duration': duration,
      'maxParticipants': maxParticipants,
      'location': location,
      'description': description,
      'participants': participants,
    };
  }

  // Create SqaEvent from Map
  factory SqaEvent.fromMap(Map<String, dynamic> map) {
    return SqaEvent(
      id: map['id'] as String,
      name: map['name'] as String,
      sportsType: map['sportsType'] as String,
      creator: map['creator'] as String,
      startDate: map['startDate'] as String,
      duration: map['duration'] as String,
      maxParticipants: map['maxParticipants'] as int,
      location: map['location'] as String,
      description: map['description'] as String,
      participants: List<String>.from(map['participants'] as List),
    );
  }

  // Optional: Create SqaEvent from JSON String
  factory SqaEvent.fromJson(String source) =>
      SqaEvent.fromMap(json.decode(source));

  // Optional: Convert SqaEvent to JSON String
  String toJsonString() => json.encode(toJSON());
}
