import 'package:flutter/material.dart';
import 'package:student_mental_health/admin/screens/students_results.dart';
import 'package:student_mental_health/admin/screens/admin_appointments.dart';
import 'package:student_mental_health/admin/screens/schedule.dart';
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
          Container(
            width: 380,
            color: Colors.white,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: const Icon(Icons.schedule),
                      title: Text('Schedule',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontWeight: _currentIndex == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          )),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: Text('Appointments',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontWeight: _currentIndex == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          )),
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      leading: const Icon(Icons.quiz),
                      title: Text('Student\'s Results',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontWeight: _currentIndex == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                          )),
                      onTap: () => setState(() => _currentIndex = 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                Schedule(),
                Notes(),
                Dashboard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
