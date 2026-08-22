import 'dart:developer' as dev;
import 'dart:io' show File;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:helpdesk_lite/core/utils/cloud_storage_service/cloud_storage_endpoints.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/core/utils/supabase_service/Supabase_servic.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Centralized cloud storage service for uploading, downloading, and managing
/// ticket attachments and media using Supabase Storage.
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

  /// Uploads raw file bytes to Supabase Storage and returns its public URL.
  Future<String> uploadBytes({
    required Uint8List bytes,
    required String fileName,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    try {
      final sanitized = _sanitizeFileName(fileName);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final folderPrefix = folder != null && folder.trim().isNotEmpty
          ? '${folder.trim().replaceAll(RegExp(r'^/|/$'), '')}/'
          : '';
      final storagePath = '$folderPrefix${timestamp}_$sanitized';
      final contentType = _getContentType(fileName);

      await _client.storage.from(bucket).uploadBinary(
            storagePath,
            bytes,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true,
            ),
          );

      final publicUrl = _client.storage.from(bucket).getPublicUrl(storagePath);
      return publicUrl;
    } catch (e) {
      dev.log('Error uploading file bytes to Supabase storage: $e');
      rethrow;
    }
  }

  /// Uploads a [PlatformFile] (from file_picker) across mobile and desktop platforms.
  Future<String> uploadPlatformFile({
    required PlatformFile platformFile,
    String? folder,
    String bucket = CloudStorageEndpoints.ticketAttachmentsBucket,
  }) async {
    try {
      Uint8List? fileBytes;

      if (platformFile.path != null) {
        final localFile = File(platformFile.path!);
        if (await localFile.exists()) {
          fileBytes = await localFile.readAsBytes();
        }
      }

      if (fileBytes == null) {
        throw Exception(
          'Unable to read bytes for file "${platformFile.name}". Path is invalid or missing.',
        );
      }

      return await uploadBytes(
        bytes: fileBytes,
        fileName: platformFile.name,
        folder: folder,
        bucket: bucket,
      );
    } catch (e) {
      dev.log('Error uploading PlatformFile to Supabase storage: $e');
      rethrow;
    }
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
