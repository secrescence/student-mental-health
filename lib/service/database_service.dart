import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for the collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference schedulesCollection =
      FirebaseFirestore.instance.collection('schedules');

  //delete user
  Future deleteUser() async {
    return await userCollection.doc(uid).delete();
  }

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
      'isUserSingedInUsingEmailOnly': true,
      'isUserDoneWithChatbot': false,
      'isUserDoneWithQuestionnaire': false,
      'isUserDoneWithResults': false,
      'whatShouldICallYou': '',
    });
  }

  //check user student id for log in
  Future getUserStudentId() async {
    DocumentReference d = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await d.get();
    if (documentSnapshot.exists) {
      return documentSnapshot['studentId'];
    } else {
      return null;
    }
  }

  //check user student id for sign up
  Future<bool> checkStudentIdExists(String studentId) async {
    final QuerySnapshot result =
        await userCollection.where("studentId", isEqualTo: studentId).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.isEmpty;
  }

  //saving user phone number
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

  //to check user log in status
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

  //questionnaire result
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

  //ADMIN

  //add appointment schedule
  Future addSchedule(String date, String time) async {
    int randomInt = Random().nextInt(10000000);
    String documentId = "$date-$randomInt";

    while (true) {
      DocumentSnapshot documentSnapshot =
          await schedulesCollection.doc(documentId).get();

      if (!documentSnapshot.exists) {
        break;
      }

      randomInt = Random().nextInt(10000000);
      documentId = "$date-$randomInt";
    }

    await schedulesCollection.doc(documentId).set({
      'date': date,
      'time': time,
      'appointedHighPriority': [],
      'appointedMidPriority': [],
      'appointedLowPriority': [],
    });
  }

  Future appointUserWithHighPriority(String schedUid) async {
    return await schedulesCollection.doc(schedUid).set({
      'appointedHighPriority': [uid],
    });
  }

  Future<List<String>> getAppointedHighPriority(String schedUid) async {
    DocumentSnapshot snapshot = await schedulesCollection.doc(schedUid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('appointedHighPriority')) {
        return List<String>.from(data['appointedHighPriority']);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future appointUserWithMidPriority(String schedUid) async {
    return await schedulesCollection.doc(schedUid).set({
      'appointedMidPriority': [uid],
    });
  }

  Future<List<String>> getAppointedMidPriority(String schedUid) async {
    DocumentSnapshot snapshot = await schedulesCollection.doc(schedUid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('appointedMidPriority')) {
        return List<String>.from(data['appointedMidPriority']);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  Future appointUserWithLowPriority(String schedUid) async {
    return await schedulesCollection.doc(schedUid).set({
      'appointedLowPriority': [uid],
    });
  }

  Future<List<String>> getAppointedLowPriority(String schedUid) async {
    DocumentSnapshot snapshot = await schedulesCollection.doc(schedUid).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (data.containsKey('appointedLowPriority')) {
        return List<String>.from(data['appointedLowPriority']);
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  //SteamBuilder
  Future<Stream<QuerySnapshot>> getSchedules() async {
    return schedulesCollection.orderBy('date').snapshots();
  }

  //get all schedules
  Future<Stream<QuerySnapshot>> getUserAppointment() async {
    return schedulesCollection.snapshots();
  }

  Future getAllSchedules() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection("schedules")
        .get()
        .then((QuerySnapshot snapshot) {
      documentIds = snapshot.docs.map((doc) => doc.id).toList();
    });
    return documentIds;
  }

  Future getClosestDate() async {
    List<String> documentIds = [];
    await FirebaseFirestore.instance
        .collection("schedules")
        .get()
        .then((QuerySnapshot snapshot) {
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
