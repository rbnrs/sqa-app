import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sqa/entities/sqa_event.dart';

class EventDao {
  static List<SqaEvent> userEvents = [];

  List<SqaEvent> getUpcomingEvents() {
    //TODO replace

    List<SqaEvent> events = [];

    return events;
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
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

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
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

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
      sqaEvents.add(SqaEvent.fromMap(snapshotRaw));
    }

    return sqaEvents;
  }

  Future<SqaEvent?> getEventById(String eventId) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("events").doc(eventId).get();

    if (snapshot.exists) {
      Map<String, dynamic> snapshotRaw = {'id': snapshot.id};
      snapshotRaw.addAll(snapshot.data()!);
      return SqaEvent.fromMap(snapshotRaw);
    }

    return null;
  }
}
