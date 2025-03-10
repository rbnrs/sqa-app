import 'dart:convert';

class SqaUser {
  final String userId;
  final String username;

  SqaUser({
    required this.userId,
    required this.username,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': userId,
      'username': username,
    };
  }

  factory SqaUser.fromMap(Map<String, dynamic> map) {
    return SqaUser(
      userId: map['userId'],
      username: map['username'],
    );
  }

  // Optional: Create SqaEvent from JSON String
  factory SqaUser.fromJson(String source) =>
      SqaUser.fromMap(json.decode(source));

  // Optional: Convert SqaEvent to JSON String
  String toJsonString() => json.encode(toJSON());
}
