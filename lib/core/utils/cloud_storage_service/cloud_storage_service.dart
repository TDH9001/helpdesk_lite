import 'dart:developer' as dev;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:helpdesk_lite/core/utils/cloud_storage_service/cloud_storage_endpoints.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Centralized cloud storage service for uploading, downloading, and managing
/// ticket attachments and media using Supabase Storage with File and PlatformFile.
class CloudStorageService {
  final SupabaseClient _client;

  CloudStorageService({SupabaseClient? client})
      : _client = client ?? SupabaseDeclaration.instance;

  /// Helper to determine MIME content type from file extension.
  String _getContentType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      case 'zip':
        return 'application/zip';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return 'application/octet-stream';
    }
  }

  /// Sanitizes a file name for safe cloud storage paths.
  String _sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
  }

  /// Uploads a [File] to Supabase Storage and returns its public URL.
  Future<String> uploadFile({
    required File file,
    String? fileName,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    try {
      final name = fileName ?? file.path.split(Platform.pathSeparator).last;
      final sanitized = _sanitizeFileName(name);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final folderPrefix = folder != null && folder.trim().isNotEmpty
          ? '${folder.trim().replaceAll(RegExp(r'^/|/$'), '')}/'
          : '';
      final storagePath = '$folderPrefix${timestamp}_$sanitized';
      final contentType = _getContentType(name);

      await _client.storage.from(bucket).upload(
            storagePath,
            file,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true,
            ),
          );

      final publicUrl = _client.storage.from(bucket).getPublicUrl(storagePath);
      return publicUrl;
    } catch (e) {
      dev.log('Error uploading File to Supabase storage: $e');
      rethrow;
    }
  }

  /// Uploads a [PlatformFile] to Supabase Storage across Web, Mobile, and Desktop.
  Future<String> uploadPlatformFile({
    required PlatformFile platformFile,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    try {
      final sanitized = _sanitizeFileName(platformFile.name);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final folderPrefix = folder != null && folder.trim().isNotEmpty
          ? '${folder.trim().replaceAll(RegExp(r'^/|/$'), '')}/'
          : '';
      final storagePath = '$folderPrefix${timestamp}_$sanitized';
      final contentType = _getContentType(platformFile.name);

      if (kIsWeb || platformFile.path == null) {
        final bytes = await platformFile.readAsBytes();
        await _client.storage.from(bucket).uploadBinary(
              storagePath,
              bytes,
              fileOptions: FileOptions(
                contentType: contentType,
                upsert: true,
              ),
            );
      } else {
        final file = File(platformFile.path!);
        await _client.storage.from(bucket).upload(
              storagePath,
              file,
              fileOptions: FileOptions(
                contentType: contentType,
                upsert: true,
              ),
            );
      }

      final publicUrl = _client.storage.from(bucket).getPublicUrl(storagePath);
      return publicUrl;
    } catch (e) {
      dev.log('Error uploading PlatformFile to Supabase storage: $e');
      rethrow;
    }
  }

  /// Uploads a list of [File] items sequentially and returns their public URLs.
  Future<List<String>> uploadMultipleFiles({
    required List<File> files,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    final List<String> uploadedUrls = [];

    for (final file in files) {
      try {
        final url = await uploadFile(
          file: file,
          folder: folder,
          bucket: bucket,
        );
        uploadedUrls.add(url);
      } catch (e) {
        dev.log('Failed to upload file ${file.path}: $e');
        rethrow;
      }
    }

    return uploadedUrls;
  }

  /// Uploads a list of [PlatformFile] attachments sequentially and returns their public URLs.
  Future<List<String>> uploadMultiplePlatformFiles({
    required List<PlatformFile> platformFiles,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    final List<String> uploadedUrls = [];

    for (final file in platformFiles) {
      try {
        final url = await uploadPlatformFile(
          platformFile: file,
          folder: folder,
          bucket: bucket,
        );
        uploadedUrls.add(url);
      } catch (e) {
        dev.log('Failed to upload attachment ${file.name}: $e');
        rethrow;
      }
    }

    return uploadedUrls;
  }

  /// Uploads a list of [TicketAttachmentItem] from the create-ticket feature and returns their public URLs.
  Future<List<String>> uploadTicketAttachments({
    required List<TicketAttachmentItem> attachments,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    return uploadMultiplePlatformFiles(
      platformFiles: attachments.map((item) => item.file).toList(),
      folder: folder,
      bucket: bucket,
    );
  }

  /// Deletes a file from Supabase Storage by its full public URL or relative storage path.
  Future<void> deleteFile({
    required String fileUrlOrPath,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    try {
      String storagePath = fileUrlOrPath;

      // Extract storage path if a full public URL was provided
      if (fileUrlOrPath.contains('/$bucket/')) {
        storagePath = fileUrlOrPath.split('/$bucket/').last;
      }

      await _client.storage.from(bucket).remove([storagePath]);
    } catch (e) {
      dev.log('Error deleting file from Supabase storage: $e');
      rethrow;
    }
  }
}
