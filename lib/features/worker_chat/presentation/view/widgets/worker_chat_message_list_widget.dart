import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/shared_models/chat_message_model.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_bubble_widget.dart';

/// Scrollable message list widget rendering customer and agent replies and internal notes.
class WorkerChatMessageListWidget extends StatelessWidget {
  final List<ChatMessageModel> messages;
  final ScrollController scrollController;
  final bool isLoading;
  final String emptyMessage;
  final String workerTag;
  final String customerTag;
  final String youTag;
  final String internalBadgeLabel;

  const WorkerChatMessageListWidget({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.isLoading,
    required this.emptyMessage,
    required this.workerTag,
    required this.customerTag,
    required this.youTag,
    required this.internalBadgeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (messages.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mark_chat_unread_outlined,
                size: 48.0,
                color: widgetColors.outlineVariant,
              ),
              const SizedBox(height: 12.0),
              Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: AppFonts().mobileCustomerChatEmptyMessageInter14Regular(
                  context,
                  color: widgetColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return WorkerChatBubbleWidget(
          message: msg,
          workerTag: workerTag,
          customerTag: customerTag,
          youTag: youTag,
          internalBadgeLabel: internalBadgeLabel,
        );
      },
    );
  }
}
