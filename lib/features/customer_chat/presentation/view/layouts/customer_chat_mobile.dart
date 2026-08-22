import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/customer_chat/data/model/customer_chat_static_model.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_header_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_input_bar_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view/widgets/customer_chat_message_list_widget.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_cubit.dart';
import 'package:helpdesk_lite/features/customer_chat/presentation/view_model/customer_chat_states.dart';

/// Mobile layout implementation for Customer Chat feature.
class CustomerChatMobile extends StatelessWidget {
  final CustomerChatStaticModel staticData;

  const CustomerChatMobile({super.key, required this.staticData});

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
            return Column(
              children: [
                // Top control and ticket info bar
                CustomerChatHeaderWidget(
                  ticket: cubit.ticket,
                  viewAttachmentsLabel: staticData.viewAttachmentsLabel,
                  noAttachmentsLabel: staticData.noAttachmentsLabel,
                  attachmentsDialogTitle: staticData.attachmentsDialogTitle,
                ),
                // Chat message bubbles list
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
                // Message composer input bar
                CustomerChatInputBarWidget(
                  controller: cubit.textController,
                  placeholder: staticData.typeMessagePlaceholder,
                  isSending: cubit.isSending,
                  attachments: cubit.pendingAttachments,
                  attachmentCountLabel: staticData.attachmentCountLabel,
                  onAttachTap: () => cubit.pickAttachments(),
                  onClearAttachments: () => cubit.clearPendingAttachments(),
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
