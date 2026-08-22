import 'package:intl/intl.dart';

/// Data model representing a chat message inside a support ticket conversation.
class ChatMessageModel {
  final String id;
  final String ticketId;
  final String? senderId;
  final String? senderName;
  final String senderRole; // 'customer', 'agent', 'system'
  final String content;
  final bool isInternal;
  final List<String> attachments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  const ChatMessageModel({
    required this.id,
    required this.ticketId,
    this.senderId,
    this.senderName,
    this.senderRole = 'customer',
    required this.content,
    this.isInternal = false,
    this.attachments = const [],
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
  });

  /// Whether the message was authored by the customer.
  bool get isCustomer => senderRole == 'customer';

  /// Whether the message was authored by an agent/worker.
  bool get isAgent => senderRole == 'agent' || senderRole == 'worker';

  /// Whether the message is a system notification.
  bool get isSystem => senderRole == 'system';

  /// Formatted time string (e.g. 10:45 AM).
  String get formattedTime {
    return DateFormat('h:mm a').format(createdAt.toLocal());
  }

  /// Formatted date/time for separators.
  String get formattedDate {
    return DateFormat('MMM d, yyyy').format(createdAt.toLocal());
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String? ?? '',
      ticketId: json['ticket_id'] as String? ?? '',
      senderId: json['sender_id'] as String?,
      senderName: json['sender_name'] as String?,
      senderRole: json['sender_role'] as String? ?? 'customer',
      content: json['content'] as String? ?? '',
      isInternal: json['is_internal'] as bool? ?? false,
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : DateTime.now(),
      isDeleted: json['is_deleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'ticket_id': ticketId,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_role': senderRole,
      'content': content,
      'is_internal': isInternal,
      'attachments': attachments,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  ChatMessageModel copyWith({
    String? id,
    String? ticketId,
    String? senderId,
    String? senderName,
    String? senderRole,
    String? content,
    bool? isInternal,
    List<String>? attachments,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDeleted,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      ticketId: ticketId ?? this.ticketId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderRole: senderRole ?? this.senderRole,
      content: content ?? this.content,
      isInternal: isInternal ?? this.isInternal,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
