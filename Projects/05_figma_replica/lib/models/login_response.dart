class LoginResponse {
  final int id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  const LoginResponse({
    required this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      message: json['message']??'',
    );
  }
}