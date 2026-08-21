import 'package:file_picker/file_picker.dart';

/// Centralized service for selecting files across mobile, desktop, and web platforms.
class FilePickerService {
  FilePickerService._();

  /// Picks multiple files from user storage.
  ///
  /// Uses the official `FilePicker.pickFiles()` static API from `file_picker` 12.x,
  /// properly routing to platform-specific plugins (such as `file_picker_web` on web).
  static Future<List<PlatformFile>> pickMultipleFiles({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    try {
      return await FilePicker.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
      );
    } catch (_) {
      return const [];
    }
  }

  /// Picks a single file from user storage.
  static Future<PlatformFile?> pickSingleFile({
    FileType type = FileType.any,
    List<String>? allowedExtensions,
  }) async {
    try {
      return await FilePicker.pickFile(
        type: type,
        allowedExtensions: allowedExtensions,
      );
    } catch (_) {
      return null;
    }
  }
}
