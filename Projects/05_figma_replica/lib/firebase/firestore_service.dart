import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/firebase_user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(FirebaseUserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<FirebaseUserModel?> getUser(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();

    if (snapshot.exists) {
      return FirebaseUserModel.fromJson(snapshot.data()!);
    }

    return null;
  }

  Future<void> updateUser(FirebaseUserModel user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
