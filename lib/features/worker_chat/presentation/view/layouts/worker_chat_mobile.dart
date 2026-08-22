import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_header_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_input_bar_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_message_list_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_cubit.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_states.dart';

/// Mobile layout implementation for Worker Chat feature.
class WorkerChatMobile extends StatelessWidget {
  final WorkerChatStaticModel staticData;

  const WorkerChatMobile({super.key, required this.staticData});

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final cubit = context.read<WorkerChatCubit>();

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: BlocConsumer<WorkerChatCubit, WorkerChatStates>(
          listener: (context, state) {
            if (state is WorkerChatFailure && cubit.errorMessage != null) {
              SnackBarService.showError(context, cubit.errorMessage!);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Top interactive header with status/priority/category controls
                WorkerChatHeaderWidget(
                  ticket: cubit.ticket,
                  staticData: staticData,
                  onStatusChanged: (newStatus) => cubit.updateStatus(newStatus),
                  onPriorityChanged: (newPriority) =>
                      cubit.updatePriority(newPriority),
                  onCategoryChanged: (newCategory) =>
                      cubit.updateCategory(newCategory),
                ),
                // Message list rendering public and internal conversations
                Expanded(
                  child: WorkerChatMessageListWidget(
                    messages: cubit.messages,
                    scrollController: cubit.scrollController,
                    isLoading: cubit.isLoading,
                    emptyMessage: staticData.emptyNoMessages,
                    workerTag: staticData.workerTag,
                    customerTag: staticData.customerTag,
                    youTag: staticData.youTag,
                    internalBadgeLabel: staticData.internalNoteBadge,
                  ),
                ),
                // Composer with Public/Internal Note toggle and rich toolbar
                WorkerChatInputBarWidget(
                  controller: cubit.textController,
                  isInternalNote: cubit.isInternalNote,
                  publicReplyTab: staticData.publicReplyTab,
                  internalNoteTab: staticData.internalNoteTab,
                  publicPlaceholder: staticData.publicReplyPlaceholder,
                  internalPlaceholder: staticData.internalNotePlaceholder,
                  sendButtonLabel: staticData.sendButtonLabel,
                  addNoteButtonLabel: staticData.addNoteButtonLabel,
                  helperText: staticData.internalNoteHelperText,
                  attachImageTooltip: staticData.attachImageTooltip,
                  attachFileTooltip: staticData.attachFileTooltip,
                  isSending: cubit.isSending,
                  attachments: cubit.pendingAttachments,
                  attachmentCountLabel: staticData.attachmentCountLabel,
                  onModeChanged: (isInternal) =>
                      cubit.setReplyType(isInternal),
                  onAttachFile: () => cubit.pickAttachments(),
                  onAttachImage: () => cubit.pickImages(),
                  onClearAttachments: () => cubit.clearPendingAttachments(),
                  onRemoveAttachment: (index) =>
                      cubit.removePendingAttachment(index),
                  onSendTap: () => cubit.sendMessage(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
