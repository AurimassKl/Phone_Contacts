// ignore_for_file: avoid_dynamic_calls, inference_failure_on_instance_creation

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_contacts/models/Contacts/contacts_data.dart';
import 'package:phone_contacts/models/User/user_data.dart';
import 'package:phone_contacts/models/auth_model.dart';
import 'package:phone_contacts/pages/add_contact_page.dart';
import 'package:phone_contacts/provider/auth_provider.dart';
import 'package:phone_contacts/provider/database_provider.dart';
import 'package:phone_contacts/widgets/contacts_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      appBar: buildAppBar(auth),
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
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).padding.top + kToolbarHeight),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 144, 95, 228),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Card(
                      color: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Center(
                          child: Text(
                            'Welcome ${snapshot.data!.userName} !',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans',
                              fontSize: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text(snapshot.data!.userContacts.length.toString()),
                  //Contacts list
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.userContacts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: StreamBuilder<ContactData?>(
                          stream: database.streamContact(
                            snapshot.data!.userContacts[index],
                          ),
                          builder: (context, snapshotContact) {
                            if (!snapshotContact.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshotContact.error != null) {
                              return const Center(
                                child: Text('Some error occurred'),
                              );
                            }
                            return ContactsList(
                              contactId: snapshot.data!.userContacts[index],
                              contact: snapshotContact.data!,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar buildAppBar(Authentication auth) {
    return AppBar(
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
    );
  }
}
