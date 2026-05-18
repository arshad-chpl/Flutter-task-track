import 'package:flutter/material.dart';

import '../models/contact.dart';
import 'update_contact_screen.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({
    super.key,
    required this.contact,
  });

  Color getStatusColor(String status) {
    if (status == "Online") {
      return Colors.green;
    } else if (status == "Busy") {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),

        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedContact = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateContactScreen(
                    contact: contact,
                  ),
                ),
              );

              if (updatedContact != null) {
                Navigator.pop(context, updatedContact);
              }
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(contact.image),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "Name: ${contact.name}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Phone: ${contact.phone}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Email: ${contact.email}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Bio: ${contact.bio}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Status: ${contact.status}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: getStatusColor(contact.status),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}