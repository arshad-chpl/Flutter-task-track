import 'package:flutter/material.dart';
import '../widgets/responsive.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
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
                ? [colorScheme.surface, colorScheme.surfaceContainerHighest]
                : const [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: Responsive.paddingAll(20),

                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(22),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Column(
                  children: [
                    Text(
                      'Overall Performance',
                      style: TextStyle(
                        fontSize: Responsive.px(20),
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 20),

                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green.withValues(alpha: 0.15),

                      child: Text(
                        '8.9',
                        style: TextStyle(
                          fontSize: Responsive.px(28),
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Current CGPA',
                      style: TextStyle(
                        fontSize: Responsive.px(15),
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Semester Results',
                style: TextStyle(
                  fontSize: Responsive.px(20),
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 20),

              resultCard(
                context: context,
                subject: 'Mathematics',
                marks: '92',
                grade: 'A+',
                color: Colors.green,
              ),

              resultCard(
                context: context,
                subject: 'Physics',
                marks: '85',
                grade: 'A',
                color: Colors.orange,
              ),

              resultCard(
                context: context,
                subject: 'Chemistry',
                marks: '88',
                grade: 'A',
                color: Colors.blue,
              ),

              resultCard(
                context: context,
                subject: 'Computer Science',
                marks: '97',
                grade: 'O',
                color: Colors.purple,
              ),

              resultCard(
                context: context,
                subject: 'English',
                marks: '80',
                grade: 'B+',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultCard({
    required BuildContext context,
    required String subject,
    required String marks,
    required String grade,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: Responsive.paddingAll(16),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                subject,
                style: TextStyle(
                  fontSize: Responsive.px(16),
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Marks Obtained: $marks',
                style: TextStyle(
                  fontSize: Responsive.px(13),
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              grade,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.px(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
