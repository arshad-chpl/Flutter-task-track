import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//  APP 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contacts App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ContactListScreen(),
    );
  }
}

// CONTACT LIST SCREEN 
class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() =>
      _ContactListScreenState();
}

class _ContactListScreenState
    extends State<ContactListScreen> {

  // CONTACT LIST
  final List<Map<String, dynamic>> contacts = [

    {
"name": "Aarav Sharma",
"status": "Online",
"bio": "Flutter Developer & UI Enthusiast",
"phone": "+91 9876543201",
"email": "aarav@example.com",
"image": "https://i.pravatar.cc/150?img=1"
},
{
"name": "Diya Patel",
"status": "Offline",
"bio": "Coffee lover and mobile app designer",
"phone": "+91 9876543202",
"email": "diya@example.com",
"image": "https://i.pravatar.cc/150?img=2"
},
{
"name": "Rohan Mehta",
"status": "Online",
"bio": "Building creative Flutter apps",
"phone": "+91 9876543203",
"email": "rohan@example.com",
"image": "https://i.pravatar.cc/150?img=3"
},
{
"name": "Ananya Verma",
"status": "Busy",
"bio": "UI/UX learner and tech explorer",
"phone": "+91 9876543204",
"email": "ananya@example.com",
"image": "https://i.pravatar.cc/150?img=4"
},
{
"name": "Kabir Singh",
"status": "Offline",
"bio": "Passionate about animations",
"phone": "+91 9876543205",
"email": "kabir@example.com",
"image": "https://i.pravatar.cc/150?img=5"
},
{
"name": "Meera Joshi",
"status": "Online",
"bio": "Learning Flutter one widget at a time",
"phone": "+91 9876543206",
"email": "meera@example.com",
"image": "https://i.pravatar.cc/150?img=6"
},
{
"name": "Vivaan Kapoor",
"status": "Away",
"bio": "Clean code advocate",
"phone": "+91 9876543207",
"email": "vivaan@example.com",
"image": "https://i.pravatar.cc/150?img=7"
},
{
"name": "Sara Khan",
"status": "Online",
"bio": "Designing beautiful experiences",
"phone": "+91 9876543208",
"email": "sara@example.com",
"image": "https://i.pravatar.cc/150?img=8"
},
{
"name": "Arjun Nair",
"status": "Offline",
"bio": "Backend + Flutter enthusiast",
"phone": "+91 9876543209",
"email": "arjun@example.com",
"image": "https://i.pravatar.cc/150?img=9"
},
{
"name": "Priya Desai",
"status": "Busy",
"bio": "Creating responsive UIs",
"phone": "+91 9876543210",
"email": "priya@example.com",
"image": "https://i.pravatar.cc/150?img=10"
},
{
"name": "Yash Malhotra",
"status": "Online",
"bio": "Exploring Dart deeply",
"phone": "+91 9876543211",
"email": "yash@example.com",
"image": "https://i.pravatar.cc/150?img=11"
},
{
"name": "Ishita Roy",
"status": "Away",
"bio": "Love creating minimal UI",
"phone": "+91 9876543212",
"email": "ishita@example.com",
"image": "https://i.pravatar.cc/150?img=12"
},
{
"name": "Dev Patel",
"status": "Online",
"bio": "Future full-stack developer",
"phone": "+91 9876543213",
"email": "dev@example.com",
"image": "https://i.pravatar.cc/150?img=13"
},
{
"name": "Neha Sharma",
"status": "Offline",
"bio": "Tech enthusiast and learner",
"phone": "+91 9876543214",
"email": "neha@example.com",
"image": "https://i.pravatar.cc/150?img=14"
},
{
"name": "Kunal Jain",
"status": "Busy",
"bio": "Working on Flutter animations",
"phone": "+91 9876543215",
"email": "kunal@example.com",
"image": "https://i.pravatar.cc/150?img=15"
},
{
"name": "Riya Sen",
"status": "Online",
"bio": "Loves dark themed apps",
"phone": "+91 9876543216",
"email": "riya@example.com",
"image": "https://i.pravatar.cc/150?img=16"
},
{
"name": "Aman Gupta",
"status": "Offline",
"bio": "Practicing Flutter layouts",
"phone": "+91 9876543217",
"email": "aman@example.com",
"image": "https://i.pravatar.cc/150?img=17"
},
{
"name": "Simran Kaur",
"status": "Online",
"bio": "Building apps with creativity",
"phone": "+91 9876543218",
"email": "simran@example.com",
"image": "https://i.pravatar.cc/150?img=18"
},
{
"name": "Harsh Vardhan",
"status": "Away",
"bio": "Flutter beginner with big goals",
"phone": "+91 9876543219",
"email": "harsh@example.com",
"image": "https://i.pravatar.cc/150?img=19"
},
{
"name": "Nisha Iyer",
"status": "Busy",
"bio": "Exploring app architectures",
"phone": "+91 9876543220",
"email": "nisha@example.com",
"image": "https://i.pravatar.cc/150?img=20"
}
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true, // 👈 centers the title

      title: const Text(
        "Contacts",
        style: TextStyle(
          fontSize: 28, // 👈 increases size
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    body: ListView.builder(
      itemCount: contacts.length,

      itemBuilder: (context, index) {
        final person = contacts[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),

         
          leading: CircleAvatar(
  radius: 28,
  backgroundImage: NetworkImage(person["image"]),
),
          
          title: Text(
            person["name"],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),

          subtitle: Text(
            person["phone"],
            style: const TextStyle(fontSize: 20),
          ),
          
          trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Text(
      "10:30 AM", // you can change or make dynamic later
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    ),
    const SizedBox(width: 8),

    Icon(
      Icons.call,
      size: 22,
      color: person["status"] == "Online"
          ? Colors.green
          : person["status"] == "Busy"
              ? Colors.red
              : Colors.grey,
    ),
  ],
),

          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContactDetailScreen(contact: person),
              ),
            );
          },
        );
      },
    ),
  );
}
    }
// ---------------- DETAIL SCREEN ----------------
class ContactDetailScreen extends StatelessWidget {
  final Map<String, dynamic> contact;
 
  const ContactDetailScreen({
    super.key,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact["name"]),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 

            Center(
  child: CircleAvatar(
    radius: 100,
    backgroundImage: NetworkImage(contact["image"]),
  ),
),

            const SizedBox(height: 20),

            Text(
              "Name: ${contact["name"]}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Phone: ${contact["phone"]}",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 8),

            Text(
              "Email: ${contact["email"]}",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 8),

            Text(
              "Bio: ${contact["bio"]}",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 12),

            Text(
              "Status: ${contact["status"]}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: contact["status"] == "Online"
                    ? Colors.green
                    : contact["status"] == "Busy"
                        ? Colors.red
                        : Colors.grey,
              ),
            ),

            const SizedBox(height: 30),
            

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Back",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


