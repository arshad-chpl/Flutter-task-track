import 'package:flutter/material.dart';
import '../widgets/responsive.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: Responsive.paddingAll(14),

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [Color(0xFF1A1A1A), Color(0xFF2A2A2A)]
                : const [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              // ================= OVERVIEW CARD =================
              Container(
                width: double.infinity,
                padding: Responsive.paddingAll(18),

                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Text(
                      'Assignment Overview',
                      style: TextStyle(
                        fontSize: Responsive.px(18),
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [
                        overviewCard(
                          context: context,
                          title: 'Completed',
                          value: '12',
                          color: colorScheme.primary,
                        ),

                        overviewCard(
                          context: context,
                          title: 'Pending',
                          value: '5',
                          color: Colors.orange.shade700,
                        ),

                        overviewCard(
                          context: context,
                          title: 'Overdue',
                          value: '2',
                          color: colorScheme.error,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Pending Assignments',
                style: TextStyle(
                  fontSize: Responsive.px(20),
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),

              const SizedBox(height: 20),

              assignmentCard(
                context: context,
                subject: 'Mathematics',
                title: 'Calculus Worksheet',
                dueDate: 'Due: 28 May 2026',
                status: 'Pending',
                color: Colors.orange.shade700,
              ),

              assignmentCard(
                context: context,
                subject: 'Physics',
                title: 'Newton Laws Report',
                dueDate: 'Due: 30 May 2026',
                status: 'Pending',
                color: Colors.orange.shade700,
              ),

              assignmentCard(
                context: context,
                subject: 'Chemistry',
                title: 'Organic Chemistry Notes',
                dueDate: 'Due: 02 June 2026',
                status: 'Completed',
                color: colorScheme.primary,
              ),

              assignmentCard(
                context: context,
                subject: 'Computer Science',
                title: 'Flutter UI Project',
                dueDate: 'Due: 05 June 2026',
                status: 'Pending',
                color: Colors.orange.shade700,
              ),

              assignmentCard(
                context: context,
                subject: 'English',
                title: 'Essay Writing',
                dueDate: 'Due: 26 May 2026',
                status: 'Overdue',
                color: colorScheme.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= ASSIGNMENT CARD =================

  Widget assignmentCard({
    required BuildContext context,
    required String subject,
    required String title,
    required String dueDate,
    required String status,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: Responsive.paddingAll(16),

      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  subject,
                  style: TextStyle(
                    fontSize: Responsive.px(16),
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: Responsive.px(14),
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  dueDate,
                  style: TextStyle(
                    fontSize: Responsive.px(13),
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: .7,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.px(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= OVERVIEW CARD =================

  Widget overviewCard({
    required BuildContext context,
    required String title,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),

          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: Responsive.px(18),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,
          style: TextStyle(
            fontSize: Responsive.px(13),
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: .7),
          ),
        ),
      ],
    );
  }
}
