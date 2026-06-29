class FirebaseUserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String dob;
  final String email;
  final String phone;
  final DateTime createdAt;


  FirebaseUserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.phone,
    required this.createdAt,
  });


  Map<String, dynamic> toJson(){
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName" : lastName,
      "dob" : dob,
      "email": email,
      "phone": phone,
      "createdAt": createdAt.toIso8601String(),
    };
  }


  factory FirebaseUserModel.fromJson(
      Map<String,dynamic> json){

    return FirebaseUserModel(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'],
      email: json['email'],
      phone: json['phone'] ?? '',
      createdAt:
      DateTime.parse(json['createdAt']),
    );
  }

}