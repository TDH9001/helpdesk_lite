import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/worker_chat/data/model/worker_chat_static_model.dart';

/// Modal bottom sheet allowing workers to update the category of a ticket.
class WorkerChatCategorySheetWidget extends StatelessWidget {
  final String? currentCategory;
  final WorkerChatStaticModel staticData;
  final ValueChanged<String> onCategorySelected;

  const WorkerChatCategorySheetWidget({
    super.key,
    required this.currentCategory,
    required this.staticData,
    required this.onCategorySelected,
  });

  /// Displays this sheet modally at the bottom of the screen.
  static Future<void> show(
    BuildContext context, {
    required String? currentCategory,
    required WorkerChatStaticModel staticData,
    required ValueChanged<String> onCategorySelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WorkerChatCategorySheetWidget(
        currentCategory: currentCategory,
        staticData: staticData,
        onCategorySelected: onCategorySelected,
      ),
    );
  }

  static const List<String> availableCategories = [
    'Technical Support',
    'Billing & Subscriptions',
    'Account Management',
    'General Inquiry',
    'Feature Request',
    'Bug Report',
  ];

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.0,
              height: 4.0,
              decoration: BoxDecoration(
                color: widgetColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            staticData.changeCategoryTitle,
            style: AppFonts().mobileWorkerChatSheetTitleInter16SemiBold(
              context,
              color: widgetColors.onSurface,
            ),
          ),
          const SizedBox(height: 12.0),
          ...availableCategories.map((category) {
            final isSelected =
                (currentCategory ?? 'General Inquiry').toLowerCase() ==
                    category.toLowerCase();

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              leading: Icon(
                Icons.folder_outlined,
                color: widgetColors.primary,
                size: 20.0,
              ),
              title: Text(
                category,
                style: AppFonts().mobileWorkerChatSheetItemInter14Medium(
                  context,
                  color: isSelected
                      ? widgetColors.primary
                      : widgetColors.onSurface,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_rounded,
                      color: widgetColors.primary,
                      size: 20.0,
                    )
                  : null,
              onTap: () {
                context.pop();
                onCategorySelected(category);
              },
            );
          }),
        ],
      ),
    );
  }
}
