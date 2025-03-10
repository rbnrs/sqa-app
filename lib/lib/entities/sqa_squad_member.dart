import 'dart:convert';

enum SquadMemberRole { LEADER, MEMBER }

class SquadMember {
  final String memberId;
  late SquadMemberRole role;

  SquadMember({required this.memberId, required String role}) {
    this.role = _stringToMemberRole(role);
  }

  Map<String, dynamic> toJSON() {
    return {
      'memberId': memberId,
      'role': _memberRoleToString(role),
    };
  }

  factory SquadMember.fromMap(Map<String, dynamic> map) {
    return SquadMember(
      memberId: map['memberId'],
      role: map['role'] ?? 'MEMBER',
    );
  }

  factory SquadMember.fromJson(String source) =>
      SquadMember.fromMap(json.decode(source));

  String toJsonString() => json.encode(toJSON());

  String _memberRoleToString(SquadMemberRole userRole) {
    return userRole == SquadMemberRole.LEADER ? 'LEADER' : 'MEMBER';
  }

  static SquadMemberRole _stringToMemberRole(String role) {
    switch (role.toUpperCase()) {
      case 'ADMIN':
        return SquadMemberRole.LEADER;
      case 'MEMBER':
        return SquadMemberRole.MEMBER;
      default:
        return SquadMemberRole.MEMBER;
    }
  }
}
