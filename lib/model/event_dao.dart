import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqa/entities/sport_type.dart';
import 'package:sqa/entities/sqa_event.dart';
import 'package:sqa/utils/helper.dart';

class EventDao {
  static List<SqaEvent> userEvents = [];

  Future<List<SqaEvent>?> getUpcomingEvents(String sportType) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    String? userId = auth.currentUser?.uid;
    List<SqaEvent> sqaEvents = [];

    if (userId == null) return null;

    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("events")
        .where("sportsType", isEqualTo: sportType)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'id': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['id'] = docSnapshot.id;
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    sqaEvents = sqaEvents.where(
      (element) {
        return SqaHelper()
                .getRemainingTimeToEventStartInSeconds(element.startDate) >
            0;
      },
    ).toList();

    if (sqaEvents.isEmpty) return null;

    return sqaEvents;
  }

  Future<String> createSqaEvent(SqaEvent sqaEvent) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference ref =
        await db.collection("events").add(sqaEvent.toJSON());
    return ref.id;
  }

  Future<List<SqaEvent>?> getEventsCreatedByUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    String? userId = auth.currentUser?.uid;
    List<SqaEvent> sqaEvents = [];

    if (userId == null) return null;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("events").where("creator", isEqualTo: userId).get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'id': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['id'] = docSnapshot.id;
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    sqaEvents = sqaEvents.where(
      (element) {
        return SqaHelper()
                .getRemainingTimeToEventStartInSeconds(element.startDate) >
            0;
      },
    ).toList();

    return sqaEvents;
  }

  Future<List<SqaEvent>?> getEventsUserHasCreated() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    String? userId = auth.currentUser?.uid;
    List<SqaEvent> sqaEvents = [];

    if (userId == null) return null;

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("events").where("creator", isEqualTo: userId).get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'id': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['id'] = docSnapshot.id;
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    sqaEvents = sqaEvents.where(
      (element) {
        return SqaHelper()
                .getRemainingTimeToEventStartInSeconds(element.startDate) >
            0;
      },
    ).toList();

    return sqaEvents;
  }

  Future<List<SqaEvent>?> getEventsUserHasRegistered() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    String? userId = auth.currentUser?.uid;
    List<SqaEvent> sqaEvents = [];

    if (userId == null) return null;

    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("events")
        .where("participants", arrayContains: userId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'id': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['id'] = docSnapshot.id;
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    sqaEvents = sqaEvents.where(
      (element) {
        return SqaHelper()
                .getRemainingTimeToEventStartInSeconds(element.startDate) >
            0;
      },
    ).toList();

    return sqaEvents;
  }

  Future<List<SqaEvent>?> getEventBySportsType(String sportsType) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<SqaEvent> sqaEvents = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection("events")
        .where("sportsType", isEqualTo: sportsType)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docSnapshot
        in snapshot.docs) {
      Map<String, dynamic> snapshotRaw = {'id': docSnapshot.id};
      snapshotRaw.addAll(docSnapshot.data());
      snapshotRaw['id'] = docSnapshot.id;
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    sqaEvents = sqaEvents.where(
      (element) {
        return SqaHelper()
                .getRemainingTimeToEventStartInSeconds(element.startDate) >
            0;
      },
    ).toList();

    return sqaEvents;
  }

  Future<SqaEvent?> getEventById(String eventId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("events").doc(eventId).get();

    if (snapshot.exists) {
      Map<String, dynamic> snapshotRaw = {'id': snapshot.id};
      snapshotRaw.addAll(snapshot.data()!);
      snapshotRaw['id'] = snapshot.id;
      return SqaEvent.fromMap(snapshotRaw);
    }

    return null;
  }

  Future<void> joinEvent(String userId, String eventId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    SqaEvent? sqaEvent = await getEventById(eventId);

    if (sqaEvent == null) {
      throw Exception('Event does not exist. Please check event id');
    }

    sqaEvent.participants.add(userId);

    await db.collection('events').doc(eventId).update(sqaEvent.toJSON());
  }

  Future<void> removeFromEvent(String userId, String eventId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    SqaEvent? sqaEvent = await getEventById(eventId);

    if (sqaEvent == null) {
      throw Exception('Event does not exist. Please check event id');
    }

    sqaEvent.participants.remove(userId);

    await db.collection('events').doc(eventId).update(sqaEvent.toJSON());
  }
}
