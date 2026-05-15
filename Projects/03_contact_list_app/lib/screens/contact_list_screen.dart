import 'package:flutter/material.dart';

import '../data/contact_data.dart';
import '../screens/contact_detail_screen.dart';
import '../widgets/contact_tile.dart';
import '../screens/add_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() =>
      _ContactListScreenState();
}

class _ContactListScreenState
    extends State<ContactListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  centerTitle: true,
  title: const Text(
    "Contacts",
    style: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  ),

  actions: [
    IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AddContactScreen(),
          ),
        );
      },
    ),
  ],
),

      body: ListView.builder(
        itemCount: contacts.length,

        itemBuilder: (context, index) {
          final person = contacts[index];

          return ContactTile(
            contact: person,

            onTap: () async {
              final updatedContact = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ContactDetailScreen(
                    contact: person,
                  ),
                ),
              );

              if (updatedContact != null) {
                setState(() {
                  contacts[index] = updatedContact;
                });
              }
            },
          );
        },
      ),
    );
  }
}