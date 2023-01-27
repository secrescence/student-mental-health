import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: adminContentBGColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: (() {
                //TODO: Add back button functionality
              }),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF000000),
              )),
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 1.5, color: Colors.white70),
              // insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            labelColor: primaryColor,
            labelStyle: TextStyle(
              fontSize: 15,
              fontFamily: 'Sofia Pro',
              fontWeight: FontWeight.w600,
            ),
            tabs: [
              Tab(
                text: 'Add Schedule',
              ),
              Tab(text: 'Pending Appointments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              height: 100,
              child: Card(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.centerLeft,
                      child: Text('Schedule'),
                    ),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Date"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Time"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Status"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(child: Text('Pending Appointments Content')),
          ],
        ),
      ),
    );
  }
}
