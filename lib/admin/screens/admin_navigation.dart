import 'package:flutter/material.dart';
import 'package:student_mental_health/admin/screens/students_results.dart';
import 'package:student_mental_health/admin/screens/admin_appointments.dart';
import 'package:student_mental_health/admin/screens/admin_schedule.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class AdminNavigation extends StatefulWidget {
  const AdminNavigation({super.key});

  @override
  State<AdminNavigation> createState() => _AdminNavigationState();
}

class _AdminNavigationState extends State<AdminNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Card(
              shadowColor: adminContentBGColor,
              elevation: 10,
              shape: const BeveledRectangleBorder(),
              margin: const EdgeInsets.only(right: 2.1),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset('assets/admin_logo.png'),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Admin',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 0
                            ? adminListTileSelectedColor
                            : null,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.schedule,
                              color: _currentIndex == 0
                                  ? Colors.black
                                  : Colors.grey[600]),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Schedule',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontWeight: _currentIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                        ),
                        onTap: () => setState(() => _currentIndex = 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 1
                            ? adminListTileSelectedColor
                            : null,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.calendar_month,
                              color: _currentIndex == 1
                                  ? Colors.black
                                  : Colors.grey[600]),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Appointments',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontWeight: _currentIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                        ),
                        onTap: () => setState(() => _currentIndex = 1),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 2
                            ? adminListTileSelectedColor
                            : null,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Icon(Icons.grading,
                              color: _currentIndex == 2
                                  ? Colors.black
                                  : Colors.grey[600]),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text('Student\'s Results',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontWeight: _currentIndex == 2
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                        ),
                        onTap: () => setState(() => _currentIndex = 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                AdminSchedule(),
                AdminAppointments(),
                StudentsResults(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
