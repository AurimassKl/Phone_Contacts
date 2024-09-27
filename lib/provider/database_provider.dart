// ignore_for_file: strict_raw_type

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/models/user_data.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<UserData?> streamUser() {
    try {
      return _firestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((doc) {
        if (doc.exists) {
          return UserData.fromDocument(doc);
        } else {
          return null;
        }
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}

final databaseProvider = Provider((ref) => Database());
