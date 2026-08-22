import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_attachments_dialog_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_category_sheet_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_header_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_input_bar_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_message_list_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_priority_sheet_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view/widgets/worker_chat_status_sheet_widget.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_cubit.dart';
import 'package:helpdesk_lite/features/worker_chat/presentation/view_model/worker_chat_states.dart';

/// Desktop layout implementation for Worker Chat with split-screen sidebar.
class WorkerChatDesktop extends StatelessWidget {
  final WorkerChatStaticModel staticData;

  const WorkerChatDesktop({super.key, required this.staticData});

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
            final ticket = cubit.ticket;

            // Desktop Right Sidebar Info Panel
            final sidebar = Container(
              width: 320.0,
              decoration: BoxDecoration(
                color: widgetColors.surface,
                border: Border(
                  left: BorderSide(
                    color: widgetColors.outlineVariant.withValues(alpha: 0.4),
                    width: 1.0,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      staticData.ticketInfoTitle,
                      style: AppFonts()
                          .desktopWorkerChatSidebarTitleInter16SemiBold(
                        context,
                        color: widgetColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Customer Profile Card
                    if (ticket.creatorName != null &&
                        ticket.creatorName!.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: widgetColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: widgetColors.outlineVariant
                                .withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.0,
                              backgroundColor: widgetColors.primaryContainer,
                              child: Text(
                                ticket.creatorName![0].toUpperCase(),
                                style: AppFonts()
                                    .mobileWorkerChatInternalBadgeInter10Bold(
                                  context,
                                  color: widgetColors.onPrimaryContainer,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.creatorName!,
                                    style: AppFonts()
                                        .mobileWorkerChatCustomerNameInter13SemiBold(
                                      context,
                                      color: widgetColors.onSurface,
                                    ),
                                  ),
                                  if (ticket.creatorEmail != null)
                                    Text(
                                      ticket.creatorEmail!,
                                      style: AppFonts()
                                          .mobileWorkerChatCustomerEmailInter11Regular(
                                        context,
                                        color: widgetColors.onSurfaceVariant,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                    // Status Quick Action
                    Text(
                      'Status',
                      style: AppFonts()
                          .desktopWorkerChatSidebarLabelInter12Medium(
                        context,
                        color: widgetColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () {
                        WorkerChatStatusSheetWidget.show(
                          context,
                          currentStatus: ticket.status,
                          staticData: staticData,
                          onStatusSelected: (s) => cubit.updateStatus(s),
                        );
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: widgetColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: widgetColors.outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ticket.status.name.toUpperCase(),
                              style: AppFonts()
                                  .desktopWorkerChatSidebarValueInter13SemiBold(
                                context,
                                color: widgetColors.primary,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: widgetColors.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    // Priority Quick Action
                    Text(
                      'Priority',
                      style: AppFonts()
                          .desktopWorkerChatSidebarLabelInter12Medium(
                        context,
                        color: widgetColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () {
                        WorkerChatPrioritySheetWidget.show(
                          context,
                          currentPriority: ticket.priority,
                          staticData: staticData,
                          onPrioritySelected: (p) => cubit.updatePriority(p),
                        );
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: widgetColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: widgetColors.outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ticket.priority.name.toUpperCase(),
                              style: AppFonts()
                                  .desktopWorkerChatSidebarValueInter13SemiBold(
                                context,
                                color: widgetColors.error,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: widgetColors.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    // Category Quick Action
                    Text(
                      'Category',
                      style: AppFonts()
                          .desktopWorkerChatSidebarLabelInter12Medium(
                        context,
                        color: widgetColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () {
                        WorkerChatCategorySheetWidget.show(
                          context,
                          currentCategory: ticket.category,
                          staticData: staticData,
                          onCategorySelected: (c) => cubit.updateCategory(c),
                        );
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 10.0,
                        ),
                        decoration: BoxDecoration(
                          color: widgetColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: widgetColors.outlineVariant
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                ticket.category ?? 'General',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFonts()
                                    .desktopWorkerChatSidebarValueInter13SemiBold(
                                  context,
                                  color: widgetColors.onSurface,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: widgetColors.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Divider(),
                    const SizedBox(height: 12.0),
                    // Attachments Gallery trigger
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 10.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () {
                        WorkerChatAttachmentsDialogWidget.show(
                          context,
                          attachments: ticket.attachments,
                          title: staticData.attachmentsDialogTitle,
                          noAttachmentsText: staticData.noAttachmentsLabel,
                        );
                      },
                      icon: Icon(
                        Icons.image_outlined,
                        size: 18.0,
                        color: widgetColors.primary,
                      ),
                      label: Text(
                        '${staticData.viewAttachmentsLabel} (${ticket.attachments.length})',
                        style: AppFonts()
                            .mobileCustomerChatAttachmentBadgeInter11Bold(
                          context,
                          color: widgetColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      WorkerChatHeaderWidget(
                        ticket: cubit.ticket,
                        staticData: staticData,
                        onStatusChanged: (newStatus) =>
                            cubit.updateStatus(newStatus),
                        onPriorityChanged: (newPriority) =>
                            cubit.updatePriority(newPriority),
                        onCategoryChanged: (newCategory) =>
                            cubit.updateCategory(newCategory),
                      ),
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
                        onClearAttachments: () =>
                            cubit.clearPendingAttachments(),
                        onRemoveAttachment: (index) =>
                            cubit.removePendingAttachment(index),
                        onSendTap: () => cubit.sendMessage(),
                      ),
                    ],
                  ),
                ),
                sidebar,
              ],
            );
          },
        ),
      ),
    );
  }
}
