import 'package:flutter/material.dart';
import '../models/contact.dart';

class UpdateContactScreen extends StatefulWidget {
  final Contact contact;

  const UpdateContactScreen({
    super.key,
    required this.contact,
  });

  @override
  State<UpdateContactScreen> createState() =>
      _UpdateContactScreenState();
}


class _UpdateContactScreenState
    extends State<UpdateContactScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.contact.name);
    phoneController =
        TextEditingController(text: widget.contact.phone);
    emailController =
        TextEditingController(text: widget.contact.email);
  }

  void saveContact() {
  final updatedContact = Contact(
    name: nameController.text,
    phone: phoneController.text,
    email: emailController.text,
    bio: widget.contact.bio,
    image: widget.contact.image,
    status: widget.contact.status,
    time: widget.contact.time, 
  );

  Navigator.pop(context, updatedContact);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: saveContact,
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}