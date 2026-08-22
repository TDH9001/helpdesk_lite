/// Status enum representing the life cycle state of a support ticket.
enum TicketStatus {
  open,
  pending,
  delayed,
  waiting,
  resolved,
  closed;

  /// Creates a [TicketStatus] from a database integer representation.
  static TicketStatus fromInt(int? value) {
    switch (value) {
      case 1:
        return TicketStatus.pending;
      case 2:
        return TicketStatus.delayed;
      case 3:
        return TicketStatus.waiting;
      case 4:
        return TicketStatus.resolved;
      case 5:
        return TicketStatus.closed;
      case 0:
      default:
        return TicketStatus.open;
    }
  }

  /// Converts the status to an integer for database storage.
  int toInt() {
    switch (this) {
      case TicketStatus.open:
        return 0;
      case TicketStatus.pending:
        return 1;
      case TicketStatus.delayed:
        return 2;
      case TicketStatus.waiting:
        return 3;
      case TicketStatus.resolved:
        return 4;
      case TicketStatus.closed:
        return 5;
    }
  }
}

/// Priority enum representing the urgency level of a support ticket.
enum TicketPriority {
  urgent,
  high,
  medium,
  low;

  /// Creates a [TicketPriority] from a database integer representation.
  static TicketPriority fromInt(int? value) {
    switch (value) {
      case 0:
        return TicketPriority.urgent;
      case 1:
        return TicketPriority.high;
      case 3:
        return TicketPriority.low;
      case 2:
      default:
        return TicketPriority.medium;
    }
  }

  /// Converts the priority to an integer for database storage.
  int toInt() {
    switch (this) {
      case TicketPriority.urgent:
        return 0;
      case TicketPriority.high:
        return 1;
      case TicketPriority.medium:
        return 2;
      case TicketPriority.low:
        return 3;
    }
  }
}

/// Comprehensive shared data model for a support ticket.
class TicketModel {
  final String id;
  final String code;
  final String title;
  final String? description;
  final String? category;
  final TicketStatus status;
  final TicketPriority priority;
  final String? creatorId;
  final String? creatorName;
  final String? creatorEmail;
  final String? assigneeId;
  final String? assigneeName;
  final List<String> attachments;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;

  const TicketModel({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    this.category,
    this.status = TicketStatus.open,
    this.priority = TicketPriority.high,
    this.creatorId,
    this.creatorName,
    this.creatorEmail,
    this.assigneeId,
    this.assigneeName,
    this.attachments = const [],
    this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
  });

  /// Helper indicating if the ticket is unassigned.
  bool get isUnassigned => assigneeId == null || assigneeId!.trim().isEmpty;

  /// Returns a formatted relative time string e.g. "5m ago", "2h ago", "1d ago".
  String get updatedTimeAgo {
    final timestamp = updatedAt ?? createdAt;
    if (timestamp == null) return 'Just now';
    final difference = DateTime.now().toUtc().difference(timestamp.toUtc());

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return '${(difference.inDays / 30).floor()}mo ago';
    }
  }

  /// Creates a copy of this [TicketModel] with updated fields.
  TicketModel copyWith({
    String? id,
    String? code,
    String? title,
    String? description,
    String? category,
    TicketStatus? status,
    TicketPriority? priority,
    String? creatorId,
    String? creatorName,
    String? creatorEmail,
    String? assigneeId,
    String? assigneeName,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) =>
      TicketModel(
        id: id ?? this.id,
        code: code ?? this.code,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        creatorId: creatorId ?? this.creatorId,
        creatorName: creatorName ?? this.creatorName,
        creatorEmail: creatorEmail ?? this.creatorEmail,
        assigneeId: assigneeId ?? this.assigneeId,
        assigneeName: assigneeName ?? this.assigneeName,
        attachments: attachments ?? this.attachments,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  /// Converts the model instance to a JSON Map compatible with Supabase.
  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'title': title,
        if (description != null) 'description': description,
        if (category != null) 'category': category,
        'status': status.toInt(),
        'priority': priority.toInt(),
        if (creatorId != null) 'creator_id': creatorId,
        if (creatorName != null) 'creator_name': creatorName,
        if (creatorEmail != null) 'creator_email': creatorEmail,
        if (assigneeId != null) 'assignee_id': assigneeId,
        if (assigneeName != null) 'assignee_name': assigneeName,
        'attachments': attachments,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
        'is_deleted': isDeleted,
      };

  /// Constructs a [TicketModel] from a JSON / Supabase record.
  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id: json['id'] as String? ?? '',
        code: json['code'] as String? ?? '',
        title: json['title'] as String? ?? '',
        description: json['description'] as String?,
        category: json['category'] as String?,
        status: json['status'] is int
            ? TicketStatus.fromInt(json['status'] as int)
            : TicketStatus.open,
        priority: json['priority'] is int
            ? TicketPriority.fromInt(json['priority'] as int)
            : TicketPriority.medium,
        creatorId: json['creator_id'] as String?,
        creatorName: json['creator_name'] as String?,
        creatorEmail: json['creator_email'] as String?,
        assigneeId: json['assignee_id'] as String?,
        assigneeName: json['assignee_name'] as String?,
        attachments: (json['attachments'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            const [],
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String)
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'] as String)
            : null,
        isDeleted: json['is_deleted'] as bool? ?? false,
      );
}
