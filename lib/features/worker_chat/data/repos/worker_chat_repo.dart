import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';

/// Abstract contract for Worker Chat repository.
abstract class WorkerChatRepo {
  /// Resolves localized static UI strings.
  Future<WorkerChatStaticModel> getWorkerChatData(BuildContext context);

  /// Picks attachments to send in chat or add to ticket.
  Future<List<TicketAttachmentItem>> pickAttachments();

  /// Picks image files specifically.
  Future<List<TicketAttachmentItem>> pickImages();
}
