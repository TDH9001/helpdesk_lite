/// Defines the user role / type within the application.
enum UserType {
  user,
  worker,
  manager;

  /// Creates a [UserType] from a string or integer representation.
  static UserType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'worker':
        return UserType.worker;
      case 'manager':
        return UserType.manager;
      case 'user':
      default:
        return UserType.user;
    }
  }

  /// Creates a [UserType] from a database integer value.
  static UserType fromInt(int? value) {
    switch (value) {
      case 1:
        return UserType.worker;
      case 2:
        return UserType.manager;
      case 0:
      default:
        return UserType.user;
    }
  }

  /// Returns the integer representation for database storage.
  int toInt() {
    switch (this) {
      case UserType.user:
        return 0;
      case UserType.worker:
        return 1;
      case UserType.manager:
        return 2;
    }
  }
}

/// Shared model representing an application user and their profile information.
class UserModel {
  final String id;
  final String email;
  final UserType type;
  final String? fullName;
  final List<String> ticketIds;
  final DateTime? lastSignedIn;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.type,
    this.fullName,
    this.ticketIds = const [],
    this.lastSignedIn,
    this.createdAt,
  });

  /// Checks if the user has a regular user role.
  bool get isUser => type == UserType.user;

  /// Checks if the user is a worker/technician.
  bool get isWorker => type == UserType.worker;

  /// Checks if the user is a manager/admin.
  bool get isManager => type == UserType.manager;

  /// Returns a copy of [UserModel] with updated fields.
  UserModel copyWith({
    String? id,
    String? email,
    UserType? type,
    String? fullName,
    List<String>? ticketIds,
    DateTime? lastSignedIn,
    DateTime? createdAt,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    type: type ?? this.type,
    fullName: fullName ?? this.fullName,
    ticketIds: ticketIds ?? this.ticketIds,
    lastSignedIn: lastSignedIn ?? this.lastSignedIn,
    createdAt: createdAt ?? this.createdAt,
  );

  /// Converts the [UserModel] instance into a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'type': type.name,
    'type_code': type.toInt(),
    if (fullName != null) 'full_name': fullName,
    'ticket_ids': ticketIds,
    if (lastSignedIn != null) 'last_signed_in': lastSignedIn!.toIso8601String(),
    if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
  };

  /// Creates a [UserModel] instance from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String? ?? '',
    email: json['email'] as String? ?? '',
    type: json['type'] != null
        ? UserType.fromString(json['type'] as String?)
        : (json['type_code'] != null
              ? UserType.fromInt(json['type_code'] as int?)
              : UserType.user),
    fullName: json['full_name'] as String? ?? json['fullName'] as String?,
    ticketIds:
        (json['ticket_ids'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        (json['ticketIds'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        const [],
    lastSignedIn: json['last_signed_in'] != null
        ? DateTime.tryParse(json['last_signed_in'] as String)
        : (json['lastSignedIn'] != null
              ? DateTime.tryParse(json['lastSignedIn'] as String)
              : null),
    createdAt: json['created_at'] != null
        ? DateTime.tryParse(json['created_at'] as String)
        : (json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'] as String)
              : null),
  );
}
