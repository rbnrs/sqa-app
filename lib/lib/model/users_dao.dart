import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqa/entities/sqa_user.dart';

class UsersDao {
  Future<SqaUser?> readUserByUserId(String userId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("users").doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> snapshotRaw = {'userId': snapshot.id};
      snapshotRaw.addAll(snapshot.data()!);
      snapshotRaw['userId'] = snapshot.id;
      return SqaUser.fromMap(snapshotRaw);
    }

    return null;
  }
}
