import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bansi Profile',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        fontFamily: 'Poppins',
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 370,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
              color: Colors.black,
              width: 1,
              ),
            ),

            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "My Profile",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A40),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          // Profile Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                           "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                              ),
                          ),

                          // Name
                          const Text(
                            "Bansi Sanepara",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A40),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            "Computer Science Student | Karnavati University",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 28),

                          profileInfo("Gender:", "Female"),
                          profileInfo("Age:", "21 Years"),
                          profileInfo("Education:", "Computer Science"),
                          profileInfo("Hobbies:", "Reading & Playing Guitar"),

                          const SizedBox(height: 24),

                          const Text(
                            "About Me",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1A40),
                            ),
                          ),

                          const SizedBox(height: 14),

                          aboutTile(
                              "Passionate about technology & innovation"),
                          aboutTile(
                              "Loves creating clean UI/UX designs"),
                          aboutTile(
                              "Building robotics & AI projects"),
                          aboutTile(
                              "Exploring startup ideas and side hustles"),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A40),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget aboutTile(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        "• $text",
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xFF1A1A40),
        ),
      ),
    );
  }
}





