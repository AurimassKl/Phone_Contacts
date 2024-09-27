// ignore_for_file: inference_failure_on_function_invocation

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_contacts/provider/auth_provider.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();


  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Ocured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> createUser(String? uid, String username, String email) async {
    await dataProvider.collection('users').doc(uid).set({
      'Name': username,
      'Email': email,
    });
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
    BuildContext context,
  ) async {
    try {
      final result = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      await createUser(result?.uid, name, email);
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error ocured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    } 
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
