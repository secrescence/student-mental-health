import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:student_mental_health/service/database_service.dart';
import 'package:student_mental_health/widgets/utils/colors.dart';

class AdminAppointments extends StatefulWidget {
  const AdminAppointments({super.key});

  @override
  State<AdminAppointments> createState() => _AdminAppointmentsState();
}

class _AdminAppointmentsState extends State<AdminAppointments> {
  String statusView = '';
  String userIdView = '';
  String fullNameView = '';
  String dateOfAppointmentDocId = '';
  String notesView = '';

  bool viewAppointment = true;

  bool isBannerVisible = true;

  int currentIndex = 0;
  final List<String> labels = ['Pending', 'Ongoing', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: adminContentBGColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              // margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: viewAppointment,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          alignment: Alignment.center,
                          child: const Text('Appointments',
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Sofia Pro',
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('appointments')
                        .where('appointedUser', isNotEqualTo: '')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: viewAppointment ? 300 : 400),
                            const SpinKitChasingDots(
                                color: primaryColor, size: 50),
                            const SizedBox(height: 20),
                            const Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 15,
                                color: primaryColor,
                                fontFamily: 'Sofia Pro',
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Container(
                          alignment: Alignment.center,
                          height: 650,
                          child: const Text(
                            'No appointments yet.',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Sofia Pro'),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Something went wrong',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Sofia Pro'),
                          ),
                        );
                      }

                      return Visibility(
                        visible: viewAppointment,
                        replacement: viewAppointmentWidget(),
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;

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
                                  return Container();
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                      'Something went wrong',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Sofia Pro'),
                                    ),
                                  );
                                }
                                Map<String, dynamic> userData = snapshot.data!
                                    .data() as Map<String, dynamic>;

                                // fullNameView =
                                //     '${userData['firstName']} ${userData['lastName']}';
                                String fullName =
                                    '${userData['firstName']} ${userData['lastName']}';

                                return Column(
                                  children: [
                                    const Divider(
                                      height: 0,
                                      thickness: 1,
                                    ),
                                    ListTile(
                                      onTap: () {
                                        setState(() {
                                          isBannerVisible = false;
                                          viewAppointment = false;
                                          fullNameView = fullName;
                                          userIdView = userId;
                                          statusView = status;
                                          dateOfAppointmentDocId = document.id;
                                        });
                                      },
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 5),
                                      title: Row(
                                        children: [
                                          const SizedBox(width: 50),
                                          Text(fullName,
                                              style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 18,
                                              )),
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
                ],
              )),
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: FlutterToggleTab(
                isShadowEnable: true,
                width: 20,
                height: 50,
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
            ),
          ],
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Text(
                        'Notes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      //TODO remove this
                      InkWell(
                        onTap: () {
                          // await DatabaseService().updateAppointmentNotes(
                          //     dateOfAppointmentDocId, notesController.text);
                          // setState(() {
                          //   notes = notesController.text;
                          // });
                          print('');
                        },
                        child: const Text(
                          '',
                          style: TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: (value) async {
                      await DatabaseService().updateAppointmentNotes(
                          dateOfAppointmentDocId, value);
                    },
                    initialValue: notesView,
                    maxLines: 20,
                    style: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 15,
                    ),
                    cursorColor: primaryColor,
                    cursorHeight: 15,
                    mouseCursor: MouseCursor.defer,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add notes...',
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
