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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: Responsive.paddingAll(8),

      decoration: BoxDecoration(
        color: theme.cardColor,
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
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: Responsive.px(15),
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  username,
                  style: TextStyle(
                    fontSize: Responsive.px(20),
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  email,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.px(13),
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
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