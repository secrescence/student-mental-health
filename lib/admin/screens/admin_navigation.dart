import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/admin/auth/admin_signin.dart';
import 'package:student_mental_health/admin/screens/admin_dashboard.dart';
import 'package:student_mental_health/admin/screens/students_results.dart';
import 'package:student_mental_health/admin/screens/admin_appointments.dart';
import 'package:student_mental_health/admin/screens/admin_schedule.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

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
            child: Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: adminContentBGColor,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset.zero, // changes position of shadow
                  ),
                ],
              ),
              child: Card(
                elevation: 100,
                shape: const BeveledRectangleBorder(),
                margin: const EdgeInsets.only(right: 5),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('assets/admin_logo.png'),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        'CAPSU Dayao',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                            child: Icon(Icons.dashboard_outlined,
                                color: _currentIndex == 0
                                    ? Colors.black
                                    : Colors.grey[600]),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Dashboard',
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
                            child: Icon(Icons.schedule_outlined,
                                color: _currentIndex == 1
                                    ? Colors.black
                                    : Colors.grey[600]),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Schedule',
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
                            child: Icon(Icons.calendar_month_outlined,
                                color: _currentIndex == 2
                                    ? Colors.black
                                    : Colors.grey[600]),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Appointments',
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
                    SizedBox(
                      width: 300,
                      child: Container(
                        decoration: BoxDecoration(
                          color: _currentIndex == 3
                              ? adminListTileSelectedColor
                              : null,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(Icons.grading_outlined,
                                color: _currentIndex == 3
                                    ? Colors.black
                                    : Colors.grey[600]),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text('Student\'s Results',
                                style: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontWeight: _currentIndex == 3
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                )),
                          ),
                          onTap: () => setState(() => _currentIndex = 3),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 70,
                      color: const Color(0xFF1D3557).withOpacity(0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              FirebaseAuth.instance.signOut().then((value) =>
                                  nextScreenReplace(
                                      context, const AdminSignIn()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Colors.black,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Sign out',
                                  style: TextStyle(fontFamily: 'Sofia Pro'),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                AdminDashboard(),
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
