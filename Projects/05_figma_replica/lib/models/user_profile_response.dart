class UserProfileResponse {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String gender;
  final int age;
  final String birthDate;
  final String department;
  final String phone;
  final String image;

  UserProfileResponse({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.gender,
    required this.age,
    required this.birthDate,
    required this.department,
    required this.phone,
    required this.image,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      age: json['age'] ?? 0,
      birthDate: json['birthDate'] ?? '',
      department: json['company']?['department'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
