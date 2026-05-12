import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> openUrl(String link) async {
    await launchUrl(
      Uri.parse(link),
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> openEmail() async {
    await launchUrl(
      Uri(
        scheme: 'mailto',
        path: 'bansi@example.com',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: 420,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(),
            ),
            child: Column(
              children: [

                // TITLE
                const Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A40),
                    ),
                  ),
                ),

                const Divider(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        // STACK
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [

                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
                                  ),
                                ),
                              ),
                            ),

                            const Positioned(
                              bottom: -60,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundImage: NetworkImage(
                                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 80),

                        // NAME
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
                          "Computer Science Student",
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 25),

                        // SOCIAL BUTTONS
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                          children: [

                            iconBtn(
                              Icons.work,
                              Colors.blue,
                              () => openUrl("https://linkedin.com"),
                            ),

                            iconBtn(
                              Icons.camera_alt,
                              Colors.purple,
                              () => openUrl("https://instagram.com"),
                            ),

                            iconBtn(
                              Icons.flutter_dash,
                              Colors.black,
                              () => openUrl("https://twitter.com"),
                            ),

                            iconBtn(
                              Icons.email,
                              Colors.red,
                              openEmail,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        info("Gender", "Female"),
                        info("Age", "21 Years"),
                        info("Education", "Computer Science"),
                        info("Hobbies", "Reading & Guitar"),

                        const SizedBox(height: 25),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "About Me",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        about("Passionate about technology"),
                        about("Loves UI/UX design"),
                        about("Building projects"),
                        about("Exploring startups"),

                        const SizedBox(height: 20),
                      ],
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

  // INFO
  Widget info(String t, String v) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            "$t :",
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          v,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );

  // ABOUT
  Widget about(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text("• $text"),
    ),
  );

  // SOCIAL BUTTON
  Widget iconBtn(
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    ElevatedButton(
  onPressed: onTap,
  style: ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(16),
    backgroundColor: color.withOpacity(0.12),
    elevation: 0,
  ),
  child: Icon(icon, color: color),
    );
  }
}
