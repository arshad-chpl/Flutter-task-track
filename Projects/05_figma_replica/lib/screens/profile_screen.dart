import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<UserProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    //final colorScheme = Theme.of(context).colorScheme;
    //final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<UserProvider>();

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),

        iconTheme: const IconThemeData(color: Colors.white),

        actions: [
          IconButton(
            onPressed: () async {
              await provider.logout(context);
            },

            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage.isNotEmpty
          ? Center(child: Text(provider.errorMessage))
          : provider.user == null
          ? const Center(child: Text('No User Data'))
          : RefreshIndicator(
              onRefresh: () async {
                await provider.loadProfile();
              },

              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                padding: const EdgeInsets.all(18),

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,

                        borderRadius: BorderRadius.circular(24),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),

                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [
                          Container(
                            // decoration: BoxDecoration(
                            //   shape: BoxShape.circle,
                            //   border: Border.all(color: Colors.white, width: 3),
                            // ),
                            child: CircleAvatar(
                              radius: 55,

                              //backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                provider.user!.image,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          Text(
                            '${provider.firstNameController.text} ${provider.lastNameController.text}',

                            textAlign: TextAlign.center,

                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            provider.emailController.text,

                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.7),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              if (provider.isEditing) {
                                await provider.saveProfile();

                                if (!context.mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile Updated'),
                                  ),
                                );
                              }

                              provider.toggleEdit();
                            },

                            icon: Icon(
                              provider.isEditing ? Icons.save : Icons.edit,
                            ),

                            label: Text(
                              provider.isEditing
                                  ? 'Save Profile'
                                  : 'Edit Profile',
                            ),

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(vertical: 15),

                              backgroundColor: const Color.fromARGB(
                                255,
                                30,
                                101,
                                100,
                              ),

                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await provider.resetProfile();

                              if (!context.mounted) {
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Profile reset to API data'),
                                ),
                              );
                            },

                            icon: const Icon(Icons.refresh),

                            label: const Text('Reset'),

                            style: ElevatedButton.styleFrom(
                              elevation: 0,

                              padding: const EdgeInsets.symmetric(vertical: 15),

                              backgroundColor: const Color(0xFF5E8C4A),

                              foregroundColor: Colors.white,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    profileTile(
                      icon: Icons.person_outline,
                      title: 'First Name',
                      controller: provider.firstNameController,
                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.person_outline,
                      title: 'Last Name',
                      controller: provider.lastNameController,
                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.account_circle_outlined,
                      title: 'Username',
                      controller: provider.userNameController,
                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.phone_outlined,
                      title: 'Phone Number',
                      controller: provider.phoneController,
                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      controller: provider.emailController,
                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.wc,
                      title: 'Gender',

                      controller: TextEditingController(
                        text: provider.user!.gender,
                      ),

                      editable: false,

                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.calendar_month,
                      title: 'Date of Birth',

                      controller: TextEditingController(
                        text: provider.user!.birthDate,
                      ),

                      editable: false,

                      isEditing: provider.isEditing,
                    ),

                    profileTile(
                      icon: Icons.school_outlined,
                      title: 'Department',

                      controller: TextEditingController(
                        text: provider.user!.department,
                      ),

                      editable: false,

                      isEditing: provider.isEditing,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget profileTile({
    required IconData icon,
    required String title,
    required TextEditingController controller,
    required bool isEditing,
    bool editable = true,
  }) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 16),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                30,
                101,
                100,
              ).withValues(alpha: 0.1),

              borderRadius: BorderRadius.circular(12),
            ),

            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 10),

                isEditing && editable
                    ? TextFormField(
                        controller: controller,

                        decoration: InputDecoration(
                          isDense: true,

                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                              ? Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest
                              : Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 30, 101, 100),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        controller.text,

                        style: TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
