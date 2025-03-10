import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqa/entities/sqa_squad.dart';

class SquadDAO {
  Future<List<SqaSquad>> loadSquadsForUser(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<SqaSquad> squads = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('squads')
        .where("memberIds", arrayContains: userId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'squadId': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['squadId'] = docSnapshot.id;
      squads.add(SqaSquad.fromMap(snapshotRaw));
    }

    return squads;
  }
}
