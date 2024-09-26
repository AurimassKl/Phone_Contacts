// ignore_for_file: strict_raw_type, inference_failure_on_collection_literal
// ignore_for_file: inference_failure_on_instance_creation
// ignore_for_file: inference_failure_on_untyped_parameter

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:phone_contacts/models/Contacts/contacts_data.dart';
import 'package:phone_contacts/models/User/user_data.dart';
import 'package:phone_contacts/provider/auth_provider.dart';
import 'package:phone_contacts/provider/database_provider.dart';

class Database {
  final _firestore = FirebaseFirestore.instance;
  Stream<UserData?> streamUser() {
    try {
      return _firestore
          .collection('users')
          .doc(fireBaseAuthProvider.currentUser!.uid)
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

  Future<void> createUser(
    String? uid,
    String username,
    String email,
  ) async {
    await _firestore.collection('users').doc(uid).set({
      'Name': username,
      'Email': email,
      'Contacts': [],
    });
  }

  Future<void> addNewContact(
    String? name,
    String? number,
    String? fileURL,
  ) async {
    final userId = fireBaseAuthProvider.currentUser!.uid;
    await _firestore.collection('contacts').add({
      'Name': name,
      'Number': number,
      'UserId': userId,
      'ImageURL': fileURL,
    }).then((value) {
      updateUsersContacts(value.id, userId);
    });
  }

  Future<void> updateUsersContacts(
    String? contactId,
    String? userId,
  ) async {
    await _firestore.collection('users').doc(userId).update({
      'Contacts': FieldValue.arrayUnion(<String>[contactId.toString()])
    });
  }

  Future<String> uploadFile(File? imageFile) async {
    final path = 'pictures/${imageFile!.path.split('/').last}';
    final file = File(imageFile.path);

    await firebaseStorageProvider.ref().child(path).putFile(file);

    final ref = firebaseStorageProvider.ref().child(path);
    return ref.getDownloadURL();
  }

  Stream<ContactData?> streamContact(String? id) {
    try {
      return _firestore.collection('contacts').doc(id).snapshots().map((doc) {
        if (doc.exists) {
          return ContactData.fromDocument(doc);
        } else {
          return null;
        }
      });
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> deleteContact(
    String imageURL,
    String contactID,
    String userID,
  ) async {
    await firebaseStorageProvider.refFromURL(imageURL).delete();
    await _firestore.collection('contacts').doc(contactID).delete();
    await _firestore.collection('users').doc(userID).update({
      'Contacts': FieldValue.arrayRemove([contactID])
    });
  }
}
