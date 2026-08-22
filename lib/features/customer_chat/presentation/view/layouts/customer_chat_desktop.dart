import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/customer_chat/data/model/customer_chat_static_model.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_attachments_dialog_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_header_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_input_bar_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_message_list_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_cubit.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_states.dart';

/// Desktop layout implementation for Customer Chat with split screen info panel.
class CustomerChatDesktop extends StatelessWidget {
  final CustomerChatStaticModel staticData;

  const CustomerChatDesktop({super.key, required this.staticData});

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;
    final cubit = context.read<CustomerChatCubit>();

    return Scaffold(
      backgroundColor: widgetColors.background,
      body: SafeArea(
        child: BlocConsumer<CustomerChatCubit, CustomerChatStates>(
          listener: (context, state) {
            if (state is CustomerChatFailure && cubit.errorMessage != null) {
              SnackBarService.showError(context, cubit.errorMessage!);
            }
          },
          builder: (context, state) {
            final ticket = cubit.ticket;

            // Right sidebar containing ticket summary
            final sideInfoPanel = Container(
              width: 320.0,
              decoration: BoxDecoration(
                color: widgetColors.surface,
                border: Border(
                  left: BorderSide(
                    color: widgetColors.outlineVariant.withValues(alpha: 0.5),
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staticData.ticketInfoTitle,
                    style: AppFonts()
                        .desktopCustomerChatSidebarTitleInter16SemiBold(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Ticket Code
                  Text(
                    'Code',
                    style: AppFonts()
                        .desktopCustomerChatSidebarLabelInter12Medium(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    ticket.code,
                    style: AppFonts()
                        .desktopCustomerChatSidebarValueInter13SemiBold(
                      context,
                      color: widgetColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Subject
                  Text(
                    'Subject',
                    style: AppFonts()
                        .desktopCustomerChatSidebarLabelInter12Medium(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    ticket.title,
                    style: AppFonts()
                        .desktopCustomerChatSidebarValueInter13SemiBold(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Category
                  Text(
                    'Category',
                    style: AppFonts()
                        .desktopCustomerChatSidebarLabelInter12Medium(
                      context,
                      color: widgetColors.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    ticket.category ?? 'General',
                    style: AppFonts()
                        .desktopCustomerChatSidebarValueInter13SemiBold(
                      context,
                      color: widgetColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  // Status & Priority
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status',
                              style: AppFonts()
                                  .desktopCustomerChatSidebarLabelInter12Medium(
                                context,
                                color: widgetColors.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              ticket.status.name.toUpperCase(),
                              style: AppFonts()
                                  .desktopCustomerChatSidebarValueInter13SemiBold(
                                context,
                                color: widgetColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Priority',
                              style: AppFonts()
                                  .desktopCustomerChatSidebarLabelInter12Medium(
                                context,
                                color: widgetColors.onSurfaceVariant,
                              ),
                            ),
                            Text(
                              ticket.priority.name.toUpperCase(),
                              style: AppFonts()
                                  .desktopCustomerChatSidebarValueInter13SemiBold(
                                context,
                                color: widgetColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Divider(),
                  const SizedBox(height: 12.0),
                  // Attachments trigger button
                  OutlinedButton.icon(
                    onPressed: () {
                      CustomerChatAttachmentsDialogWidget.show(
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
            );

            return Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CustomerChatHeaderWidget(
                        ticket: ticket,
                        viewAttachmentsLabel: staticData.viewAttachmentsLabel,
                        noAttachmentsLabel: staticData.noAttachmentsLabel,
                        attachmentsDialogTitle:
                            staticData.attachmentsDialogTitle,
                      ),
                      Expanded(
                        child: CustomerChatMessageListWidget(
                          messages: cubit.messages,
                          scrollController: cubit.scrollController,
                          isLoading: cubit.isLoading,
                          emptyMessage: staticData.emptyNoMessages,
                          workerTag: staticData.workerTag,
                          youTag: staticData.youTag,
                        ),
                      ),
                      CustomerChatInputBarWidget(
                        controller: cubit.textController,
                        placeholder: staticData.typeMessagePlaceholder,
                        isSending: cubit.isSending,
                        attachments: cubit.pendingAttachments,
                        attachmentCountLabel: staticData.attachmentCountLabel,
                        onAttachTap: () => cubit.pickAttachments(),
                        onClearAttachments: () =>
                            cubit.clearPendingAttachments(),
                        onSendTap: () => cubit.sendMessage(),
                      ),
                    ],
                  ),
                ),
                sideInfoPanel,
              ],
            );
          },
        ),
      ),
    );
  }
}
