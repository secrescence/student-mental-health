import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for the collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');
  final CollectionReference appointmentsWaitingListCollection =
      FirebaseFirestore.instance.collection('appointmentsWaitingList');
  final CollectionReference additionalAppointmentsCollection =
      FirebaseFirestore.instance.collection('additionalAppointments');
  final CollectionReference journalCollection =
      FirebaseFirestore.instance.collection('journal');

  StreamSubscription<QuerySnapshot>? queueSubscription;

  Future sendEmail() async {
    String userName =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getUserName();
    String userEmail =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getUserEmail();
    String message =
        'Good day! you have an appointment with the guidance counselor. Please check your appointment screen for more details.';

    const serviceId = 'service_9jrgmse';
    const templateId = 'template_3avfj5g';
    const userId = 'V2rX-nEaZfwpSl1uI';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': userName,
          'to_email': userEmail,
          'message': message,
        },
      }),
    );
  }

  //delete user
  Future deleteUser() async {
    return await userCollection.doc(uid).delete();
  }

  //get all users uid
  Future getAllUsersUid() async {
    List<String> documentIds = [];
    await userCollection.get().then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    return documentIds;
  }

  // saving the user data from sign up
  Future savingUserData(String firstName, String lastName, String email,
      String department, String year, String section, String studentId) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'department': department,
      'year': year,
      'section': section,
      'studentId': studentId,
      'uid': uid,
      'phoneNumber': '',
      //user progress in the app by default
      'isUserSingedInUsingEmailOnly': true,
      'isUserDoneWithOTP': false,
      'isUserDoneWithChatbot': false,
      'isUserDoneWithQuestionnaire': false,
      'isUserDoneWithResults': false,
      'whatShouldICallYou': '',
      'dateSignedUpUsingEmailOnly': DateTime.now(),
    });
  }

  //check if user student id is correct for log in
  Future getUserStudentId() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['studentId'];
    } else {
      return null;
    }
  }

  //check if user student id already used for sign up
  Future<bool> checkStudentIdExists(String studentId) async {
    final QuerySnapshot result =
        await userCollection.where("studentId", isEqualTo: studentId).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isEmpty;
  }

  //save and get user phone number
  Future addPhoneNumber(String phoneNumber) async {
    return await userCollection.doc(uid).update({
      'phoneNumber': phoneNumber,
    });
  }

  Future getUserPhoneNumber() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['phoneNumber'];
  }

  //to check user progress in the app
  Future userDoneWithOTP() async {
    return await userCollection.doc(uid).update({
      'isUserDoneWithOTP': true,
    });
  }

  Future userDoneWithChatbot() async {
    return await userCollection.doc(uid).update({
      'isUserDoneWithChatbot': true,
    });
  }

  Future userDoneWithQuestionnaire() async {
    return await userCollection.doc(uid).update({
      'isUserDoneWithQuestionnaire': true,
    });
  }

  Future userDoneWithResults() async {
    return await userCollection.doc(uid).update({
      'isUserDoneWithResults': true,
    });
  }

  Future getUsersDoneWithOTP() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['isUserDoneWithOTP'];
  }

  Future getUsersSignedInUsingEmailOnly() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['isUserSingedInUsingEmailOnly'];
  }

  Future getUserDoneChatbot() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['isUserDoneWithChatbot'];
  }

  Future getDoneWithQuestionnaire() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['isUserDoneWithQuestionnaire'];
  }

  Future getUserDoneWithResults() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['isUserDoneWithResults'];
  }

  //save questionnaire result
  Future questionnaireResult(
    double grandMean,
    double categoryNonacceptanceMEAN,
    double categoryGoalsMEAN,
    double categoryImpulseMEAN,
    double categoryAwarenessMEAN,
    double categoryStrategiesMEAN,
    double categoryClarityMEAN,
  ) async {
    userCollection.doc(uid).collection('questionnaireResult').doc(uid).set({
      'dateAnswered': DateTime.now().toString(),
      'grandMean': grandMean,
      'categoryNonacceptanceMEAN': categoryNonacceptanceMEAN,
      'categoryGoalsMEAN': categoryGoalsMEAN,
      'categoryImpulseMEAN': categoryImpulseMEAN,
      'categoryAwarenessMEAN': categoryAwarenessMEAN,
      'categoryStrategiesMEAN': categoryStrategiesMEAN,
      'categoryClarityMEAN': categoryClarityMEAN,
      'isHighPriority': false,
      'isMidPriority': false,
      'isLowPriority': false,
    });
  }

  Future isResultHighOrMidOrLow(String whatPriority) async {
    return await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .update({
      whatPriority: true,
    });
  }

  Future<String> checkPriority() async {
    DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data['isHighPriority']) {
        return 'High Priority';
      } else if (data['isMidPriority']) {
        return 'Mid Priority';
      } else if (data['isLowPriority']) {
        return 'Low Priority';
      } else {
        return 'None';
      }
    } else {
      return 'Document does not exist';
    }
  }

  //get all questionnaire result
  Future getQuestionnaireResult() async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  Future getQuestionnaireResultForAdmin(String userUid) async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(userUid)
        .collection('questionnaireResult')
        .doc(userUid)
        .get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else {
      return null;
    }
  }

  //get highest result of categories
  Future<Map<String, dynamic>?> getHighestResult() async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> results = snapshot.data() as Map<String, dynamic>;
      double maxValue = double.negativeInfinity;
      String? maxKey;

      results.forEach((key, value) {
        if (value > maxValue) {
          maxValue = value;
          maxKey = key;
        }
      });

      return {maxKey!: maxValue};
    } else {
      return null;
    }
  }

  //get Grand Mean/Overall Score
  Future getOverallScore() async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return snapshot['grandMean'];
    } else {
      return null;
    }
  }

  //add what should i call you
  Future userWhatShouldICallYou(String whatShouldICallYou) async {
    return await userCollection.doc(uid).update({
      'whatShouldICallYou': whatShouldICallYou,
    });
  }

  //get what should i call you
  Future getUserWhatShouldICallYou() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['whatShouldICallYou'];
    } else {
      return null;
    }
  }

  // [ADMIN FUNCTIONS]

  //add counseling schedule
  Future addSchedule(
      {required BuildContext context,
      required String date,
      required String forDocId,
      required String time,
      bool mounted = true}) async {
    // List of available times in ascending order
    final List<String> availableTimes = [
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM'
    ];

    // Get the index of the selected time
    int timeIndex = availableTimes.indexOf(time);

    if (timeIndex == -1) {
      if (!mounted) return;
      errorSnackbar(context, 'Oh Snap!', 'Invalid time');
      return;
    }

    String documentId = "$forDocId-$timeIndex";

    while (true) {
      DocumentSnapshot documentSnapshot =
          await appointmentsCollection.doc(documentId).get();

      if (!documentSnapshot.exists) {
        break;
      }

      if (timeIndex == 1) {
        timeIndex += 2;
      } else {
        timeIndex++;
      }
      if (timeIndex >= availableTimes.length) {
        if (!mounted) return;
        errorSnackbar(context, 'Oh Snap!', 'No more available time slots');
        return;
      }

      documentId = "$date-$timeIndex";
    }

    // Check if there are any schedules already for the given date and time
    final QuerySnapshot querySnapshot = await appointmentsCollection
        .where('date', isEqualTo: date)
        .where('time', isEqualTo: time)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      if (!mounted) return;
      errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
    } else {
      await appointmentsCollection.doc(documentId).set({
        'date': date,
        'time': time,
        'appointedUser': '',
        'status': 'pending',
      });
    }
  }

  // the system will automatically add the appointment to the first available slot
  // Future appointUser(BuildContext context, String priority, {bool mounted = true}) async {
  //   List<String> scheduleIds = await getAllSchedulesDocId();

  //   for (String scheduleId in scheduleIds) {
  //     final DocumentSnapshot appointmentsDoc =
  //         await appointmentsCollection.doc(scheduleId).get();
  //     if (appointmentsDoc.get('appointedUser') == '') {
  //       // If the slot is empty, update it with the uid and return
  //       await appointmentsCollection.doc(scheduleId).update({
  //         'appointedUser': uid,
  //         'appointedUserPriority': priority,
  //       });
  //       return;
  //     }
  //   }

  //   // If no empty slot is found, throw an error
  //   print('No available slots');
  //   errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
  // }

  Future appointUser(BuildContext context, String priority,
      {bool mounted = true}) async {
    List<String> scheduleIds = await getAllSchedulesDocId();

    for (String scheduleId in scheduleIds) {
      final DocumentSnapshot appointmentsDoc =
          await appointmentsCollection.doc(scheduleId).get();
      if (appointmentsDoc.get('appointedUser') == '') {
        // If the slot is empty, update it with the uid and return
        await appointmentsCollection.doc(scheduleId).update({
          'appointedUser': uid,
          'priorityNumber': priority,
        });
        sendEmail();
        return;
      }
    }

    // If no empty slot is found, add the user to the waiting list based on priority
    await appointmentsWaitingListCollection.add({
      'uid': uid,
      'priority': priority,
      'timestamp': Timestamp.now(),
    });

    await userCollection.doc(uid).update({
      'inWaitingList': true,
    });

    // Listen to the waiting list collection and automatically appoint a user when a new schedule becomes available
    listenToAppointmentsCollection();
  }

  void listenToAppointmentsCollection() {
    appointmentsCollection.snapshots().listen((querySnapshot) async {
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        if (documentSnapshot.get('appointedUser') == '') {
          // If a schedule becomes available, check the waiting list and appoint the user with the highest priority
          QuerySnapshot waitingListSnapshot =
              await appointmentsWaitingListCollection
                  .orderBy('priority')
                  .orderBy('timestamp', descending: false)
                  .limit(1)
                  .get();
          if (waitingListSnapshot.docs.isNotEmpty) {
            DocumentSnapshot waitingListDoc = waitingListSnapshot.docs.first;
            await waitingListDoc.reference.delete();

            await appointmentsCollection.doc(documentSnapshot.id).update({
              'appointedUser': waitingListDoc.get('uid'),
              'priorityNumber': waitingListDoc.get('priority'),
            });

            await userCollection.doc(waitingListDoc.get('uid')).update({
              'inWaitingList': false,
            });
            sendEmail();
          }
        }
      }
    });
  }

  //add additional appointment for emergency cases
  // Future additionalAppointment(BuildContext context, String date,
  //     {bool mounted = true}) async {
  //   // List of available times in ascending order
  //   final List<String> availableTimes = [
  //     '9:00 AM',
  //     '10:00 AM',
  //     '11:00 AM',
  //     '2:00 PM',
  //     '3:00 PM',
  //     '4:00 PM',
  //   ];

  //   // Get the index of the selected time
  //   int timeIndex = availableTimes.indexOf(availableTimes[2]);
  //   if (timeIndex == -1) {
  //     return;
  //   }

  //   String documentId = "$date-$timeIndex";

  //   while (true) {
  //     DocumentSnapshot documentSnapshot =
  //         await additionalAppointmentsCollection.doc(documentId).get();

  //     if (!documentSnapshot.exists) {
  //       break;
  //     }

  //     if (timeIndex == 2) {
  //       timeIndex += 3;
  //     } else {
  //       timeIndex += 2;
  //     }

  //     if (timeIndex >= availableTimes.length) {
  //       if (!mounted) return;
  //       errorSnackbar(context, 'Oh Snap!', 'No more available time slots');
  //       return;
  //     }

  //     documentId = "$date-$timeIndex";
  //     print(documentId);
  //   }

  //   // Check if there are any schedules already for the given date and time
  //   final QuerySnapshot querySnapshot = await appointmentsCollection
  //       .where('date', isEqualTo: date)
  //       .where('time', isEqualTo: time)
  //       .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     if (!mounted) return;
  //     errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
  //   } else {
  //     await additionalAppointmentsCollection.doc(documentId).set({
  //       'date': date,
  //       'time': time,
  //       'appointedUser': '',
  //       'status': 'pending',
  //     });
  //   }

  //   //appoint user
  //   List<String> scheduleIds = [];
  //   await additionalAppointmentsCollection.get().then((QuerySnapshot snapshot) {
  //     scheduleIds = snapshot.docs.map((doc) => doc.id).toList();
  //   });

  //   for (String scheduleId in scheduleIds) {
  //     final DocumentSnapshot appointmentsDoc =
  //         await additionalAppointmentsCollection.doc(scheduleId).get();
  //     if (appointmentsDoc.get('appointedUser') == '') {
  //       // If the slot is empty, update it with the uid and return
  //       await additionalAppointmentsCollection.doc(scheduleId).update({
  //         'appointedUser': uid,
  //       });
  //       return;
  //     }
  //   }

  //   // If no empty slot is found, throw an error
  //   print('No available slots');
  //   errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
  // }

  //Streams
  Future<Stream<QuerySnapshot>> getSchedules() async {
    return appointmentsCollection.orderBy('date').snapshots();
  }

  Future<Stream<DocumentSnapshot<Object?>>> getOnlySpecificScheduleDate(
      String schedUid) async {
    return appointmentsCollection.doc(schedUid).snapshots();
  }

  //get all users data
  Future usersList() async {
    return userCollection.snapshots();
  }

  Future questionnaireResultStream() async {
    return userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .snapshots();
  }

  //get all schedules
  Future<Stream<QuerySnapshot>> getUserAppointment() async {
    return appointmentsCollection.snapshots();
  }

  Future whatDateTheCurrentUserIsAppointed() async {
    return appointmentsCollection
        .where('appointedUser', isEqualTo: uid)
        .snapshots();
  }

  Future getAllSchedulesDocId() async {
    List<String> documentIds = [];
    await appointmentsCollection.get().then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    return documentIds;
  }

  Future getClosestDate() async {
    List<String> documentIds = [];
    await appointmentsCollection.get().then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    return documentIds[0];
  }

  Future updateAppointmentStatus(String schedUid, String status) async {
    return await appointmentsCollection.doc(schedUid).update({
      'status': status,
    });
  }

  Future updateAppointmentNotes(String schedUid, String notes) async {
    return await appointmentsCollection.doc(schedUid).update({
      'notes': notes,
    });
  }

  Future addJournalNotes() async {
    String randInt = Random().nextInt(90000).toString();
    String docId = '$uid-$randInt';
    await journalCollection.doc(docId).set({
      'id': uid,
      'title': '',
      'content': '',
      'mood': 'neutral',
      'date': DateFormat('MMMM d, y').format(DateTime.now()),
    });

    return docId;
  }

  Future updateJournalTitle(String userUid, String? title) async {
    return await journalCollection.doc(userUid).update({
      'title': title,
    });
  }

  Future updateJournalContent(String userUid, String? content) async {
    return await journalCollection.doc(userUid).update({
      'content': content,
    });
  }

  Future updateJournalMood(String userUid, String mood) async {
    return await journalCollection.doc(userUid).update({
      'mood': mood,
    });
  }

  Future getUserEmail() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['email'];
    } else {
      return null;
    }
  }

  Future getUserName() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['firstName'] + ' ' + documentSnapshot['lastName'];
    } else {
      return null;
    }
  }

  Future getFirstName() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['firstName'];
    } else {
      return null;
    }
  }

  Future getLastName() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['lastName'];
    } else {
      return null;
    }
  }

  Future getEmail() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['email'];
    } else {
      return null;
    }
  }

  Future updateFirstName(String firstName) async {
    return await userCollection.doc(uid).update({
      'firstName': firstName,
    });
  }

  Future updateLastName(String lastName) async {
    return await userCollection.doc(uid).update({
      'lastName': lastName,
    });
  }

  Future updateEmail(String email) async {
    return await userCollection.doc(uid).update({
      'email': email,
    });
  }

  Future updatePhone(String phone) async {
    return await userCollection.doc(uid).update({
      'phone': phone,
    });
  }

  Future getDateAnswered() async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return snapshot['dateAnswered'];
    } else {
      return null;
    }
  }

  Future getDateCanAnswerAgain() async {
    final DocumentSnapshot snapshot = await userCollection
        .doc(uid)
        .collection('questionnaireResult')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      return snapshot['dateCanAnswerAgain'];
    } else {
      return null;
    }
  }

  Future dateDoneWithQuestionnaire() async {
    return await userCollection.doc(uid).update({
      'dateDoneWithQuestionnaire': DateTime.now(),
    });
  }

  Future getIsInWaitingList() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['inWaitingList'];
    } else {
      return null;
    }
  }

  //end of db service class
}
