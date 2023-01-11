import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // reference for the collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference questionnaireCollection =
      FirebaseFirestore.instance.collection('questionnaire');
  final CollectionReference phoneNumbersCollection =
      FirebaseFirestore.instance.collection('phoneNumbers');

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
      'studentID': studentId,
      'uid': uid,
    });
  }

  Future gettingUserEmail(String email) async {
    QuerySnapshot? snapshot =
        await userCollection.where('phoneNumber', isEqualTo: email).get();
    return snapshot;
  }

  Future savePhoneNumberToDB(String phoneNumber) async {
    return await phoneNumbersCollection.doc(uid).set({
      'phoneNumber': phoneNumber,
    });
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

// questionnaire result
  questionnaireResult(
    double grandMean,
    double categoryNonacceptanceMEAN,
    double categoryGoalsMEAN,
    double categoryImpulseMEAN,
    double categoryAwarenessMEAN,
    double categoryStrategiesMEAN,
    double categoryClarityMEAN,
  ) async {
    userCollection.doc(uid).collection('questionnaire').doc('result').set({
      'grandMean': grandMean,
      'categoryNonacceptanceMEAN': categoryNonacceptanceMEAN,
      'categoryGoalsMEAN': categoryGoalsMEAN,
      'categoryImpulseMEAN': categoryImpulseMEAN,
      'categoryAwarenessMEAN': categoryAwarenessMEAN,
      'categoryStrategiesMEAN': categoryStrategiesMEAN,
      'categoryClarityMEAN': categoryClarityMEAN,
    });
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot = await phoneNumbersCollection.doc(uid).get();
    if (snapshot.exists) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }
  //end of db service class
}
