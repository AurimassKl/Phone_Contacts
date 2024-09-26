// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phone_contacts/models/Contacts/contacts_data.dart';
import 'package:phone_contacts/provider/database_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({
    super.key,
    required this.contactId,
    required this.contact,
  });

  final String contactId;
  final ContactData contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.read(databaseProvider);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        // dismissible: DismissiblePane(onDismissed: () {}),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await launch('tel://${contact.contactNumber}');
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.phone,
            label: 'Call',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              //delete
              database.deleteContact(
                contact.contactImageURL,
                contactId, contact.contactUserId,
              );
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.deepPurple,
        child: ListTile(
          title: Text(
            contact.contactName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
            ),
          ),
          subtitle: Text(
            contact.contactNumber,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(contact.contactImageURL),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
