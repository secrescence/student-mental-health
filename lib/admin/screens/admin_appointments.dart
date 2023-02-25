import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';
import 'package:student_mental_health/widgets/widgets/widgets.dart';

class AdminAppointments extends StatefulWidget {
  const AdminAppointments({super.key});

  @override
  State<AdminAppointments> createState() => _AdminAppointmentsState();
}

class _AdminAppointmentsState extends State<AdminAppointments> {
  Stream<QuerySnapshot>? userAppointmentStream;
  String statusView = '';
  String userIdView = '';
  String fullNameView = '';
  String dateOfAppointmentDocId = '';

  bool viewAppointment = true;

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
            'Appointments',
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
                  visible: viewAppointment,
                  replacement: viewAppointmentWidget(),
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
                      final String status = data['status'];

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

                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  //TODO todo
                                  setState(() {
                                    viewAppointment = false;
                                    fullNameView = fullName;
                                    userIdView = userId;
                                    statusView = status;
                                    dateOfAppointmentDocId = document.id;
                                  });
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
                                    Icon(
                                      Icons.circle,
                                      size: 12,
                                      color: status == 'pending'
                                          ? Colors.red
                                          : status == 'completed'
                                              ? Colors.green
                                              : Colors.amber,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        fontFamily: 'Sofia Pro',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: status == 'pending'
                                            ? Colors.red
                                            : status == 'completed'
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

  Widget viewAppointmentWidget() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: IconButton(
              onPressed: () => setState(() {
                    viewAppointment = true;
                  }),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Text(
                fullNameView,
                style: const TextStyle(
                  fontFamily: 'Sofia Pro',
                  fontSize: 19,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const SizedBox(width: 30),
                Icon(
                  Icons.circle,
                  size: 12,
                  color: statusView == 'pending'
                      ? Colors.red
                      : statusView == 'completed'
                          ? Colors.green
                          : Colors.amber,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  statusView,
                  style: TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: statusView == 'pending'
                        ? Colors.red
                        : statusView == 'completed'
                            ? Colors.green
                            : Colors.amber,
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 30),
                const Text(
                  'Status: ',
                  style: TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 10),
                FlutterToggleTab(
                  isShadowEnable: true,
                  width: 15,
                  borderRadius: 10,
                  marginSelected: const EdgeInsets.all(3),
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sofia Pro'),
                  unSelectedTextStyle: const TextStyle(
                      fontFamily: 'Sofia Pro', color: Colors.black54),
                  labels: labels,
                  selectedIndex: statusView == 'pending'
                      ? currentIndex = 0
                      : statusView == 'ongoing'
                          ? currentIndex = 1
                          : currentIndex = 2,
                  selectedBackgroundColors: [
                    currentIndex == 0
                        ? Colors.red
                        : currentIndex == 1
                            ? Colors.amber
                            : Colors.green,
                  ],
                  selectedLabelIndex: (int index) async {
                    if (currentIndex != index && index == 0) {
                      await DatabaseService().updateAppointmentStatus(
                          dateOfAppointmentDocId, 'pending');
                    } else if (currentIndex != index && index == 1) {
                      await DatabaseService().updateAppointmentStatus(
                          dateOfAppointmentDocId, 'ongoing');
                    } else if (currentIndex != index && index == 2) {
                      await DatabaseService().updateAppointmentStatus(
                          dateOfAppointmentDocId, 'completed');
                    }

                    setState(() {
                      currentIndex = index;
                      if (index == 0) {
                        statusView = 'pending';
                      } else if (index == 1) {
                        statusView = 'ongoing';
                      } else {
                        statusView = 'completed';
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
