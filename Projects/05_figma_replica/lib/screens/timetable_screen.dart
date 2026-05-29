import 'package:flutter/material.dart';
import '../widgets/responsive.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 101, 100),

        title: const Text(
          'Class Timetable',

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        padding: Responsive.paddingAll(14),

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFFE8F0FF),
              Color(0xFFD6E4FF),
            ],
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const SizedBox(height: 10),

              Container(
                width: double.infinity,

                padding: Responsive.paddingAll(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.05,
                      ),

                      blurRadius: 8,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Today\'s Schedule',

                      style: TextStyle(
                        fontSize:
                            Responsive.px(18),

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Monday, 28 May 2026',

                      style: TextStyle(
                        fontSize:
                            Responsive.px(14),

                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              timetableCard(
                subject: 'Mathematics',
                teacher: 'Mr. Sharma',

                timing: '09:00 AM - 10:00 AM',

                room: 'Room 201',

                color: Colors.blue,
              ),

              timetableCard(
                subject: 'Physics',
                teacher: 'Mrs. Patel',

                timing: '10:00 AM - 11:00 AM',

                room: 'Lab 3',

                color: Colors.orange,
              ),

              timetableCard(
                subject: 'Chemistry',
                teacher: 'Dr. Mehta',

                timing: '11:15 AM - 12:15 PM',

                room: 'Room 105',

                color: Colors.green,
              ),

              timetableCard(
                subject: 'Computer Science',
                teacher: 'Mr. Verma',

                timing: '01:00 PM - 02:00 PM',

                room: 'Computer Lab',

                color: Colors.purple,
              ),

              timetableCard(
                subject: 'English',
                teacher: 'Mrs. Rao',

                timing: '02:00 PM - 03:00 PM',

                room: 'Room 110',

                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timetableCard({
    required String subject,
    required String teacher,
    required String timing,
    required String room,
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
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.05),

            blurRadius: 8,
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 6,
            height: 90,

            decoration: BoxDecoration(
              color: color,

              borderRadius:
                  BorderRadius.circular(20),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  subject,

                  style: TextStyle(
                    fontSize:
                        Responsive.px(17),

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 18,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      teacher,

                      style: TextStyle(
                        fontSize:
                            Responsive.px(13),

                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 18,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      timing,

                      style: TextStyle(
                        fontSize:
                            Responsive.px(13),

                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      room,

                      style: TextStyle(
                        fontSize:
                            Responsive.px(13),

                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}