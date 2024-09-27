// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/models/user_data.dart';
import 'package:phone_contacts/provider/auth_provider.dart';
import 'package:phone_contacts/provider/database_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 43, 43),
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: auth.signOut,
              child: const Icon(
                Icons.logout,
                size: 26,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<UserData?>(
          stream: database.streamUser(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.error != null) {
              return const Center(child: Text('Some error occurred'));
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Text(
                      'Welcome ${snapshot.data!.userName} !',
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Open Sans',
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  thickness: 2,
                  color: Colors.white,
                ),
                Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
