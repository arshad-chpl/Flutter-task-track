import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Contact {
  const Contact({required this.name, required this.phone, required this.color});

  final String name;
  final String phone;
  final Color color;
}

const contacts = [
  Contact(name: 'Aarav Mehta', phone: '+91 98765 43210', color: Colors.indigo),
  Contact(name: 'Bansi Sanepara', phone: '+91 98765 43211', color: Colors.teal),
  Contact(name: 'Dhruv Shah', phone: '+91 98765 43212', color: Colors.orange),
  Contact(name: 'Isha Patel', phone: '+91 98765 43213', color: Colors.pink),
  Contact(name: 'Kabir Joshi', phone: '+91 98765 43214', color: Colors.green),
  Contact(name: 'Mira Desai', phone: '+91 98765 43215', color: Colors.purple),
  Contact(name: 'Nisha Verma', phone: '+91 98765 43216', color: Colors.blue),
  Contact(name: 'Rohan Trivedi', phone: '+91 98765 43217', color: Colors.red),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ContactListPage(),
    );
  }
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Contact List Methods'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'ListView'),
              Tab(text: 'Builder'),
              Tab(text: 'For Loop'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListViewExample(),
            ListViewBuilderExample(),
            ForLoopExample(),
          ],
        ),
      ),
    );
  }
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: 'ListView',
      description:
          'ListView is useful when you already know all items and the list is small.',
      code:
          'ListView(children: contacts.map((contact) => ContactTile(...)).toList())',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: contacts.map((contact) {
          return ContactTile(contact: contact);
        }).toList(),
      ),
    );
  }
}

class ListViewBuilderExample extends StatelessWidget {
  const ListViewBuilderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExamplePage(
      title: 'ListView.builder',
      description:
          'ListView.builder is better for long lists because it builds items only when needed.',
      code:
          'ListView.builder(itemCount: contacts.length, itemBuilder: (context, index) => ContactTile(...))',
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return ContactTile(contact: contact);
        },
      ),
    );
  }
}

class ForLoopExample extends StatelessWidget {
  const ForLoopExample({super.key});

  @override
  Widget build(BuildContext context) {
    final contactWidgets = <Widget>[];

    for (final contact in contacts) {
      contactWidgets.add(ContactTile(contact: contact));
    }

    return ExamplePage(
      title: 'For Loop',
      description:
          'A for loop is useful when you want to add conditions or extra logic while creating widgets.',
      code:
          'for (final contact in contacts) { contactWidgets.add(ContactTile(...)); }',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: contactWidgets,
      ),
    );
  }
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({
    super.key,
    required this.title,
    required this.description,
    required this.code,
    required this.child,
  });

  final String title;
  final String description;
  final String code;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  code,
                  style: const TextStyle(fontFamily: 'monospace'),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class ContactTile extends StatelessWidget {
  const ContactTile({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: contact.color,
          child: Text(
            contact.name[0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.phone),
        trailing: const Icon(Icons.call),
      ),
    );
  }
}
