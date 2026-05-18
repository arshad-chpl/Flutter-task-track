import 'package:flutter/material.dart';
import '../models/contact.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() =>
      _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final imageController = TextEditingController();

  void saveContact() {
    final newContact = Contact(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      bio: bioController.text,
      image: imageController.text,
      status: "Online",
      time: DateTime.now().toString(),
    );

    Navigator.pop(context, newContact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),

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
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: "Bio"),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Image"),
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