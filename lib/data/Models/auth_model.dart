class LoginResponse {
  LoginResponse({
    required this.token,
    required this.email,
    required this.name,
  });

  final String token;
  final String email;
  final String name;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'name': name,
    };
  }
}
