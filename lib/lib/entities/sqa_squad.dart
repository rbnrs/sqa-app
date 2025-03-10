import 'dart:convert';
import 'package:sqa/entities/sqa_squad_member.dart';

class SqaSquad {
  final String squadId;
  final String squadName;
  final List<SquadMember> squadMembers;

  SqaSquad(
      {required this.squadId,
      required this.squadName,
      required this.squadMembers});

  // Convert to JSON
  Map<String, dynamic> toJSON() {
    return {
      'squadId': squadId,
      'squadName': squadName,
      'squadMembers': squadMembers.map((member) => member.toJSON()).toList(),
    };
  }

  factory SqaSquad.fromJson(String source) =>
      SqaSquad.fromMap(json.decode(source));

  factory SqaSquad.fromMap(Map<String, dynamic> map) {
    return SqaSquad(
      squadId: map['squadId'],
      squadName: map['squadName'],
      squadMembers: (map['members'] as List<dynamic>)
          .map((member) => SquadMember.fromMap(member))
          .toList(),
    );
  }

  String toJsonString() => json.encode(toJSON());

  SqaSquad addMember(SquadMember newMember) {
    return SqaSquad(
      squadId: squadId,
      squadName: squadName,
      squadMembers: [...squadMembers, newMember],
    );
  }

  SqaSquad removeMember(String memberId) {
    return SqaSquad(
      squadId: squadId,
      squadName: squadName,
      squadMembers:
          squadMembers.where((member) => member.memberId != memberId).toList(),
    );
  }
}
