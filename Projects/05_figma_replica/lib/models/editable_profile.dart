class EditableProfile {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String phone;

  EditableProfile({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phone,
  });

  factory EditableProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return EditableProfile(
      firstName:
          json['firstName'] ?? '',

      lastName:
          json['lastName'] ?? '',

      userName: json['userName']?? '',

      email:
          json['email'] ?? '',

      phone:
          json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phone': phone,
    };
  }
}