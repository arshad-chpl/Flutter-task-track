import 'package:flutter/material.dart';

import 'contact/data/contact_data.dart';
import 'contact/contact_screens/contact_detail_screen.dart';
import 'contact/widgets/contact_tile.dart';
import 'contact/contact_screens/add_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() =>
      _ContactListScreenState();
}

class _ContactListScreenState
    extends State<ContactListScreen> {
          String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredContacts = contacts.where((contact) {
      return contact.name
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C6BC0),
        centerTitle: true,
        title: const Text(
            "Contacts",
          style: TextStyle(
            //color: Colors.white,
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

body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(

              decoration: InputDecoration(
                hintText: "Search contact",

                prefixIcon: const Icon(
                  Icons.search,
                ),

                filled: true,
                fillColor: Colors.grey.shade200,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),


     Expanded(
            child: ListView.builder(
        itemCount: filteredContacts.length,
        itemBuilder: (context, index) {
            final person = filteredContacts[index];

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
      ),
    ],
  ),
  );
}
}