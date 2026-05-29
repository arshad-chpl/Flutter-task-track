import 'package:flutter/material.dart';
import '../widgets/responsive.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 101, 100),

        title: const Text(
          'Assignments',
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
                  children: [
                    Text(
                      'Assignment Overview',

                      style: TextStyle(
                        fontSize:
                            Responsive.px(18),

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,

                      children: [
                        overviewCard(
                          title: 'Completed',
                          value: '12',
                          color: Colors.green,
                        ),

                        overviewCard(
                          title: 'Pending',
                          value: '5',
                          color: Colors.blue,
                        ),

                        overviewCard(
                          title: 'Overdue',
                          value: '2',
                          color: Colors.red,
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
                ),
              ),

              const SizedBox(height: 20),

              assignmentCard(
                subject: 'Mathematics',
                title: 'Calculus Worksheet',

                dueDate: 'Due: 28 May 2026',

                status: 'Pending',

                color: Colors.blue,
              ),

              assignmentCard(
                subject: 'Physics',
                title: 'Newton Laws Report',

                dueDate: 'Due: 30 May 2026',

                status: 'Pending',

                color: Colors.blue,
              ),

              assignmentCard(
                subject: 'Chemistry',
                title: 'Organic Chemistry Notes',

                dueDate: 'Due: 02 June 2026',

                status: 'Completed',

                color: Colors.green,
              ),

              assignmentCard(
                subject: 'Computer Science',
                title: 'Flutter UI Project',

                dueDate: 'Due: 05 June 2026',

                status: 'Pending',

                color: Colors.blue,
              ),

              assignmentCard(
                subject: 'English',
                title: 'Essay Writing',

                dueDate: 'Due: 26 May 2026',

                status: 'Overdue',

                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget assignmentCard({
    required String subject,
    required String title,
    required String dueDate,
    required String status,
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
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  subject,

                  style: TextStyle(
                    fontSize:
                        Responsive.px(16),

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  title,

                  style: TextStyle(
                    fontSize:
                        Responsive.px(14),

                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  dueDate,

                  style: TextStyle(
                    fontSize:
                        Responsive.px(13),

                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),

              borderRadius:
                  BorderRadius.circular(30),
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

  Widget overviewCard({
    required String title,
    required String value,
    required Color color,
  }) {
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

            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}