import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';
import 'package:intl/intl.dart';

class StudentsResults extends StatefulWidget {
  const StudentsResults({super.key});

  @override
  State<StudentsResults> createState() => _StudentsResultsState();
}

class _StudentsResultsState extends State<StudentsResults> {
  Stream<QuerySnapshot>? userAppointmentStream;
  String priorityView = '';
  String userIdView = '';
  String fullNameView = '';
  String dateOfAppointmentDocId = '';
  String studentIdView = '';

  bool viewStudentResult = true;

  int currentIndex = 0;
  final List<String> labels = ['Pending', 'Ongoing', 'Completed'];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await DatabaseService().getUserAppointment().then((snapshot) {
      setState(() {
        userAppointmentStream = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Student\'s Results',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sofia Pro'),
          ),
        ),
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     onPressed: (() {
        //       //TODO: Add back button functionality
        //     }),
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Color(0xFF000000),
        //     )),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            // margin: const EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder<QuerySnapshot>(
              stream: userAppointmentStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitChasingDots(
                      color: primaryColor,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                }

                return Visibility(
                  visible: viewStudentResult,
                  replacement: viewStudentResultWidget(),
                  child: ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      // final String fullName =
                      //     '${data['firstName']} ${data['lastName']}';
                      if (data['status'] == null) {
                        return const SizedBox.shrink();
                      }

                      // userIdView = data['appointedUser'];
                      // statusView = data['status'];

                      final String userId = data['appointedUser'];
                      final String priority = data['userAppointedPriority'];

                      return StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData ||
                              snapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitChasingDots(
                                color: primaryColor,
                                size: 50,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Something went wrong'),
                            );
                          }

                          Map<String, dynamic> userData =
                              snapshot.data!.data() as Map<String, dynamic>;

                          // fullNameView =
                          //     '${userData['firstName']} ${userData['lastName']}';
                          String fullName =
                              '${userData['firstName']} ${userData['lastName']}';
                          String studentId = userData['studentId'];

                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  //TODO todo
                                  setState(() {
                                    viewStudentResult = false;
                                    fullNameView = fullName;
                                    userIdView = userId;
                                    priorityView = priority;
                                    dateOfAppointmentDocId = document.id;
                                    studentIdView = studentId;
                                  });
                                  print(dateOfAppointmentDocId);
                                },
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                title: Row(
                                  children: [
                                    const SizedBox(width: 50),
                                    Text(fullName),
                                    const Spacer(),
                                    const SizedBox(width: 50),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    const SizedBox(width: 50),
                                    Text(
                                      priority,
                                      style: TextStyle(
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: priority == 'high priority'
                                            ? Colors.red
                                            : priority == 'low priority'
                                                ? Colors.green
                                                : Colors.amber,
                                      ),
                                    ),
                                    const SizedBox(width: 50),
                                  ],
                                ),
                                trailing: const Padding(
                                  padding: EdgeInsets.only(right: 50),
                                  child: Text(
                                    'view',
                                    style: TextStyle(
                                      fontFamily: 'Sofia Pro',
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 0,
                                thickness: 1,
                              ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget viewStudentResultWidget() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: IconButton(
                  onPressed: () => setState(() {
                        viewStudentResult = true;
                      }),
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            const Spacer(),
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all<Size>(const Size(85, 35)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          phoneFieldButtonColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      DateTime currentDate = DateTime.now();
                      String formattedDate =
                          DateFormat('MM-dd-yyyy').format(currentDate);
                      print(formattedDate); // output: 02-18-2023
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.print, size: 16),
                        SizedBox(width: 5),
                        Text(
                          'Print',
                          style:
                              TextStyle(fontSize: 14, fontFamily: 'Sofia Pro'),
                        ),
                      ],
                    ))),
            const SizedBox(width: 20),
          ],
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'Name: $fullNameView',
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 19,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'Student ID: $studentIdView',
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 19,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: const Text(
            'Visual Summary',
            style: TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 21,
            ),
          ),
        ),
        Row(
          children: [],
        )
      ],
    );
  }
}
