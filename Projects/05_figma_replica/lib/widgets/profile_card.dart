import 'package:flutter/material.dart';
import 'responsive.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String email;

  const ProfileCard({
    super.key,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: Responsive.paddingAll(5),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,

            child: ClipOval(
              child: Image.asset(
                'assets/icons/logo_image.png',
              ),
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: Responsive.px(15),
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  username,
                  style: TextStyle(
                    fontSize: Responsive.px(20),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  email,
                  style: TextStyle(
                    fontSize: Responsive.px(13),
                    color: Colors.grey,
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