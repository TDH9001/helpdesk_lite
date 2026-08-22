class CustomerAuthModel {
  final String email;
  final String? username;
  final String? password;
  final String? confirmPassword;
  final String? token;
  final String? userId;

  const CustomerAuthModel({
    required this.email,
    this.username,
    this.password,
    this.confirmPassword,
    this.token,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        if (username != null) 'username': username,
        if (password != null) 'password': password,
        if (confirmPassword != null) 'confirmPassword': confirmPassword,
        if (token != null) 'token': token,
        if (userId != null) 'userId': userId,
      };

  factory CustomerAuthModel.fromJson(Map<String, dynamic> json) =>
      CustomerAuthModel(
        email: json['email'] as String? ?? '',
        username: json['username'] as String?,
        password: json['password'] as String?,
        confirmPassword: json['confirmPassword'] as String?,
        token: json['token'] as String?,
        userId: json['userId'] as String?,
      );
}
