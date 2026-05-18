import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const Profile());

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfilePage();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController =
    TextEditingController(text: "Bansi Sanepara");

final TextEditingController professionController =
    TextEditingController(text: "Computer Science Student");



  String name = "Bansi Sanepara";
  String profession = "Computer Science Student";
  File? profileImage;
  bool isFollowing = false;
  int followers = 120;
  bool isDark = false;

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

  Future<void> pickImage() async {

  final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      profileImage = File(pickedFile.path);
    });
  }
}
void showEditDialog() {

  nameController.text = name;
  professionController.text = profession;

  showDialog(
    context: context,
    builder: (context) {

      return AlertDialog(
        title: const Text("Edit Profile"),

        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: professionController,
                decoration: const InputDecoration(
                  labelText: "Profession",
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: pickImage,
                child: const Text("Change Profile Photo"),
              ),
            ],
          ),
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          ElevatedButton(
            onPressed: () {

              setState(() {
                name = nameController.text;
                profession = professionController.text;
              },
              );

              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      elevation: 0,
  backgroundColor: const Color(0xFF5C6BC0),
  centerTitle: true,
  title: const Text(
    "Profile",
    style: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ),
  ),

  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
),

    body: SafeArea(
      child: Center(
        child: Container(
          width: 420,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark
                ? const Color.fromARGB(255, 56, 54, 54)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(),
          ),
          
            child: Column(
              children: [
              
               Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                      });
                      },
                      ),

                // TITLE
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color:
                      isDark ? Colors.white : const Color(0xFF1A1A40),
                      ),
                    ),
                  ),
               ],
                ),
                const Divider(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        // STACK
                        SizedBox(
                          height: 300,
                          child: Stack(
                            
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
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
                          
                                Positioned(
                                  bottom: 20,
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 65,
                                            backgroundImage:
                                        profileImage != null
                                          ? FileImage(profileImage!)
                                          : const NetworkImage(
                                              "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                                         ) as ImageProvider,
                                       ),
                                      ),
                                    ),
                          
                                    Positioned(
                                      bottom: 10,
                                      //bottom:10,
                                      //right: 10,
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.blue,
                                        child: IconButton(
                                        padding: EdgeInsets.zero,
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        onPressed: showEditDialog,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ),

                        // const SizedBox(height: 60),

                        // NAME
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        const SizedBox(height: 5),

                        Text(
                          profession,
                          style: TextStyle(
                            fontSize: 24,
                            color: isDark ? Colors.white : Colors.grey,
                        ),
                        ),

                        const SizedBox(height: 20),
                        

                        Text(
                          "$followers Followers",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black
                            ),
                            ),

                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (!isFollowing) {
                                        isFollowing = true;
                                        followers++;
                                        }
                                        });
                                        },
                                        child: Text(
                                          isFollowing ? "Following" : "Follow",
                                          ),
                                        ),
                                        
                                      const SizedBox(width: 15),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            if (isFollowing) {
                                              isFollowing = false;
                                              followers--;
                                              }
                                              });
                                              },
                                              child: const Text("Unfollow"),
                                              ),
                                              ],
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
                              const Color.fromARGB(255, 24, 106, 157),
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

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "About Me",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
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
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              ),
          ),
        ),
        Text(
          v,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
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
      child: Text("• $text",
      style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              ),
      ),
    ),
  );

  // SOCIAL BUTTON
  Widget iconBtn(
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return ElevatedButton(
  onPressed: onTap,
  style: ElevatedButton.styleFrom(
    shape: const CircleBorder(),
    padding: const EdgeInsets.all(16),
    backgroundColor: color.withOpacity(0.12),
    elevation: 0,
  ),
  child: Icon(icon, 
  color: color,
  size: 30,
  ),
    );
  }
}