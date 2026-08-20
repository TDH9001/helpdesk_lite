class CustomerAuthModel {
  final String email;
  final String? password;
  final String? confirmPassword;
  final String? token;
  final String? userId;

  const CustomerAuthModel({
    required this.email,
    this.password,
    this.confirmPassword,
    this.token,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        if (password != null) 'password': password,
        if (confirmPassword != null) 'confirmPassword': confirmPassword,
        if (token != null) 'token': token,
        if (userId != null) 'userId': userId,
      };

  factory CustomerAuthModel.fromJson(Map<String, dynamic> json) =>
      CustomerAuthModel(
        email: json['email'] as String? ?? '',
        password: json['password'] as String?,
        confirmPassword: json['confirmPassword'] as String?,
        token: json['token'] as String?,
        userId: json['userId'] as String?,
      );
}
