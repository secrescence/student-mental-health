import 'package:flutter/material.dart';
import 'package:student_mental_health/admin/screens/dashboard.dart';
import 'package:student_mental_health/admin/screens/notes.dart';
import 'package:student_mental_health/admin/screens/schedule.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
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
                Container(
                  color: _currentIndex == 0 ? adminListTileSelectedColor : null,
                  child: ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: Text('Dashboard',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: _currentIndex == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                ),
                Container(
                  color: _currentIndex == 1 ? adminListTileSelectedColor : null,
                  child: ListTile(
                    leading: const Icon(Icons.schedule),
                    title: Text('Schedule',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: _currentIndex == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                ),
                Container(
                  color: _currentIndex == 2 ? adminListTileSelectedColor : null,
                  child: ListTile(
                    leading: const Icon(Icons.note),
                    title: Text('Notes',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: _currentIndex == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                        )),
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[500],
              child: IndexedStack(
                index: _currentIndex,
                children: const [
                  Dashboard(),
                  Schedule(),
                  Notes(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
