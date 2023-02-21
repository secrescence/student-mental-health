import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_mental_health/widgets/widgets/custom_snackbar.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for the collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference appointmentsCollection =
      FirebaseFirestore.instance.collection('appointments');
  final CollectionReference additionalAppointmentsCollection =
      FirebaseFirestore.instance.collection('additionalAppointments');

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
      'isUserDoneWithChatbot': false,
      'isUserDoneWithQuestionnaire': false,
      'isUserDoneWithResults': false,
      'whatShouldICallYou': '',
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
  Future addSchedule(BuildContext context, String date, String time,
      {bool mounted = true}) async {
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

    String documentId = "$date-$timeIndex";

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
      });
    }
  }

  //add appointment schedule
  // Future addSchedule(BuildContext context, String date, String time,
  //     {bool mounted = true}) async {
  //   int randomInt = Random().nextInt(10000000);
  //   String documentId = "$date-$randomInt";

  //   while (true) {
  //     DocumentSnapshot documentSnapshot =
  //         await appointmentsCollection.doc(documentId).get();

  //     if (!documentSnapshot.exists) {
  //       break;
  //     }

  //     randomInt = Random().nextInt(10000000);
  //     documentId = "$date-$randomInt";
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
  //     await appointmentsCollection.doc(documentId).set({
  //       'date': date,
  //       'time': time,
  //       'appointedUser': '',
  //     });
  //   }
  // }

  // Future addTimeSlots(String date, String time) async {
  //   String docId = await addSchedule(date);
  // }

  //the system will automatically add the appointment to the first available slot
  Future appointUser(BuildContext context, {bool mounted = true}) async {
    List<String> scheduleIds = await getAllSchedulesDocId();

    for (String scheduleId in scheduleIds) {
      final DocumentSnapshot appointmentsDoc =
          await appointmentsCollection.doc(scheduleId).get();
      if (appointmentsDoc.get('appointedUser') == '') {
        // If the slot is empty, update it with the uid and return
        await appointmentsCollection.doc(scheduleId).update({
          'appointedUser': uid,
        });
        return;
      }
    }

    // If no empty slot is found, throw an error
    //TODO Create a no available slots dialog
    print('No available slots');
    errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
  }

  //add additional appointment for emergency cases
  Future additionalAppointment(BuildContext context, String date, String time,
      {bool mounted = true}) async {
    // List of available times in ascending order
    final List<String> availableTimes = [
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
    ];

    // Get the index of the selected time
    int timeIndex = availableTimes.indexOf(time);
    if (timeIndex == -1) {
      return;
    }

    String documentId = "$date-$timeIndex";

    while (true) {
      DocumentSnapshot documentSnapshot =
          await additionalAppointmentsCollection.doc(documentId).get();

      if (!documentSnapshot.exists) {
        break;
      }

      print(timeIndex);
      if (timeIndex == 2) {
        timeIndex += 3;
      } else {
        timeIndex += 2;
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
      await additionalAppointmentsCollection.doc(documentId).set({
        'date': date,
        'time': time,
        'appointedUser': '',
      });
    }

    //appoint user
    List<String> scheduleIds = [];
    await additionalAppointmentsCollection.get().then((QuerySnapshot snapshot) {
      scheduleIds = snapshot.docs.map((doc) => doc.id).toList();
    });

    for (String scheduleId in scheduleIds) {
      final DocumentSnapshot appointmentsDoc =
          await additionalAppointmentsCollection.doc(scheduleId).get();
      if (appointmentsDoc.get('appointedUser') == '') {
        // If the slot is empty, update it with the uid and return
        await additionalAppointmentsCollection.doc(scheduleId).update({
          'appointedUser': uid,
        });
        return;
      }
    }

    // If no empty slot is found, throw an error
    //TODO Create a no available slots dialog
    print('No available slots');
    errorSnackbar(context, 'Oh Snap!', 'Time slot already taken');
  }

  //TODO : add a function that will check if the user is already appointed
  Future appointUserWithHighPriority(String schedUid) async {
    return await appointmentsCollection.doc(schedUid).update({
      'appointedHighPriority': [uid],
    });
  }

  // Future<List<String>> getAppointedHighPriority(String schedUid) async {
  //   DocumentSnapshot snapshot =
  //       await appointmentsCollection.doc(schedUid).get();
  //   if (snapshot.exists) {
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //     if (data.containsKey('appointedHighPriority')) {
  //       return List<String>.from(data['appointedHighPriority']);
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     return [];
  //   }
  // }

  // Future appointUserWithMidPriority(String schedUid) async {
  //   return await appointmentsCollection.doc(schedUid).set({
  //     'appointedMidPriority': [uid],
  //   });
  // }

  // Future<List<String>> getAppointedMidPriority(String schedUid) async {
  //   DocumentSnapshot snapshot =
  //       await appointmentsCollection.doc(schedUid).get();
  //   if (snapshot.exists) {
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //     if (data.containsKey('appointedMidPriority')) {
  //       return List<String>.from(data['appointedMidPriority']);
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     return [];
  //   }
  // }

  // Future appointUserWithLowPriority(String schedUid) async {
  //   return await appointmentsCollection.doc(schedUid).set({
  //     'appointedLowPriority': [uid],
  //   });
  // }

  // Future<List<String>> getAppointedLowPriority(String schedUid) async {
  //   DocumentSnapshot snapshot =
  //       await appointmentsCollection.doc(schedUid).get();
  //   if (snapshot.exists) {
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //     if (data.containsKey('appointedLowPriority')) {
  //       return List<String>.from(data['appointedLowPriority']);
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     return [];
  //   }
  // }

  //SteamBuilder
  Future<Stream<QuerySnapshot>> getSchedules() async {
    return appointmentsCollection.orderBy('date').snapshots();
  }

  Future<Stream<DocumentSnapshot<Object?>>> getOnlySpecificScheduleDate(
      String schedUid) async {
    return appointmentsCollection.doc(schedUid).snapshots();
  }

  //get all users data
  Future<Stream<QuerySnapshot>> usersList() async {
    return userCollection.snapshots();
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

  //TODO this is okay
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

  //get appointment schedule
  Future checkIfUidOfScheduleExist(String date, int increment) async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection("counseling")
        .get()
        .then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    List<String> filteredIds = documentIds
        .where((element) => element.startsWith('$date-$increment'))
        .toList();
    return filteredIds;
  }

  Future getSchedulesOfDateNow() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection("counseling")
        .get()
        .then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    List<String> filteredIds = documentIds
        .where((element) => element.startsWith(
            "${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().year}"))
        .toList();

    List<Map<String, dynamic>> schedules = [];
    for (var i = 0; i < filteredIds.length; i++) {
      await FirebaseFirestore.instance
          .collection("counseling")
          .doc(filteredIds[i])
          .get()
          .then((DocumentSnapshot snapshot) {
        schedules.add(snapshot.data() as Map<String, dynamic>);
      });
    }
    return schedules;
  }

// used to display chats of both chatbot and user
  getChats(String chatId) async {
    return userCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

//when user send a message
  Future sendMessage(
      String chatId, Map<String, dynamic> chatMessageData) async {
    userCollection
        .doc(chatId)
        .collection('messages')
        .doc(uid)
        .set(chatMessageData);
  }

  Future sendOption(String chatId, Map<String, dynamic> chatMessageData) async {
    userCollection
        .doc(chatId)
        .collection('messages')
        .doc(chatId)
        .set(chatMessageData);
  }

//chatbot message
  Future chatbotResponse(
      String chatId, String message, String index, String sender) async {
    await userCollection.doc(chatId).collection('messages').doc(index).set({
      'message': message,
      'sender': sender,
      'time': DateTime.now().millisecondsSinceEpoch,
    });
  }

//check if user already replied to chatbot
  Future<bool> ifUserReplied(String chatId, String userName) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(chatId)
        .collection('messages')
        .limit(1)
        .where('sender', isEqualTo: userName)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

//if user chooses yes or no
  Future<bool> ifUserChoosesYesOrNo(String chatId, String answer) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .doc(chatId)
        .collection('messages')
        .limit(1)
        .where('message', isEqualTo: answer)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  //end of db service class
}
