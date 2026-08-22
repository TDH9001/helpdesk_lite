import 'package:file_picker/file_picker.dart';

/// Model representing a file attachment selected for a support ticket.
class TicketAttachmentItem {
  final PlatformFile file;
  final String name;
  final int size; // Size in bytes

  const TicketAttachmentItem({
    required this.file,
    required this.name,
    required this.size,
  });

  /// Formatted size string (e.g. 1.2 MB or 450 KB).
  String get formattedSize {
    if (size < 1024) {
      return '$size B';
    } else if (size < 1024 * 1024) {
      final kb = (size / 1024).toStringAsFixed(1);
      return '$kb KB';
    } else {
      final mb = (size / (1024 * 1024)).toStringAsFixed(1);
      return '$mb MB';
    }
  }

  /// Whether this file is an image based on extension.
  bool get isImage {
    final lower = name.toLowerCase();
    return lower.endsWith('.png') ||
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.webp') ||
        lower.endsWith('.gif');
  }
}
