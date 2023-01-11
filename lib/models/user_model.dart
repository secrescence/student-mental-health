class UserModel {
  final String uid;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String email;
  final String department;
  final String year;
  final String section;
  final String studentId;
  UserModel({
    required this.uid,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.department,
    required this.year,
    required this.section,
    required this.studentId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'phoneNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'department': department,
      'year': year,
      'section': section,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      phoneNumber: map['phoneNumber'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      year: map['year'] as String,
      section: map['section'] as String,
      studentId: map['studentId'] as String,
    );
  }
}
