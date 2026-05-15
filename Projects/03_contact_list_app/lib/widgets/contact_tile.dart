import 'package:flutter/material.dart';

import '../models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final VoidCallback onTap;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onTap,
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
  return Column(
    children: [
      ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),

        leading: CircleAvatar(
          radius: 28,
          backgroundImage:
              NetworkImage(contact.image),
        ),

        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          contact.phone,
          style: const TextStyle(fontSize: 16),
        ),

        trailing: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              Text(
                contact.time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(width: 8),

              Icon(
                Icons.call,
                color: getStatusColor(
                  contact.status,
                ),
              ),
            ],
          ),
        ),

        onTap: onTap,
      ),

      const Divider(
        thickness: 1,
        indent: 16,
        endIndent: 16,
      ),
    ],
  );
}
}