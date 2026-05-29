import 'package:flutter/material.dart';
import '../widgets/responsive.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 101, 100),

        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: Responsive.paddingAll(14),

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE8F0FF), Color(0xFFD6E4FF)],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: Responsive.paddingAll(18),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      'Overall Attendance',
                      style: TextStyle(
                        fontSize: Responsive.px(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,

                          child: CircularProgressIndicator(
                            value: 0.92,
                            strokeWidth: 10,
                            backgroundColor: Colors.grey.shade300,
                            valueColor: const AlwaysStoppedAnimation(
                              Colors.green,
                            ),
                          ),
                        ),

                        Text(
                          '92%',
                          style: TextStyle(
                            fontSize: Responsive.px(24),
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Excellent Attendance Record',
                      style: TextStyle(
                        fontSize: Responsive.px(14),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Subject Wise Attendance',
                style: TextStyle(
                  fontSize: Responsive.px(20),
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              attendanceCard(
                subject: 'Mathematics',
                percentage: '95%',
                attended: '38/40',
                color: Colors.green,
              ),

              attendanceCard(
                subject: 'Physics',
                percentage: '88%',
                attended: '35/40',
                color: Colors.orange,
              ),

              attendanceCard(
                subject: 'Chemistry',
                percentage: '90%',
                attended: '36/40',
                color: Colors.blue,
              ),

              attendanceCard(
                subject: 'Computer Science',
                percentage: '97%',
                attended: '39/40',
                color: Colors.purple,
              ),

              attendanceCard(
                subject: 'English',
                percentage: '85%',
                attended: '34/40',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget attendanceCard({
    required String subject,
    required String percentage,
    required String attended,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: Responsive.paddingAll(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Classes Attended: $attended',
                style: TextStyle(
                  fontSize: Responsive.px(13),
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
            ),

            child: Text(
              percentage,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.px(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}