import 'package:flutter/material.dart';
import 'responsive.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final VoidCallback? onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),

      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.3),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            CircleAvatar(
              radius: 40,

              backgroundColor: color.withValues(alpha: 0.15),

              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              title,
              textAlign: TextAlign.center,

              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: Responsive.px(14),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}