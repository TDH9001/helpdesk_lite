import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_chips_widget.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_search_bar_widget.dart';

/// Containerized header sheet holding the search bar and quick filter chips.
class TicketQueueFilterSheetWidget extends StatelessWidget {
  final String searchPlaceholder;
  final String allActiveLabel;
  final String unassignedLabel;
  final String highPriorityLabel;
  final QueueFilterType selectedFilter;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<QueueFilterType>? onFilterChanged;

  const TicketQueueFilterSheetWidget({
    super.key,
    required this.searchPlaceholder,
    required this.allActiveLabel,
    required this.unassignedLabel,
    required this.highPriorityLabel,
    required this.selectedFilter,
    this.searchController,
    this.onSearchChanged,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Filter sheet container with rounded bottom corners and shadow
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 14.0),
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search input bar
          TicketQueueSearchBarWidget(
            placeholder: searchPlaceholder,
            controller: searchController,
            onChanged: onSearchChanged,
          ),
          const SizedBox(height: 12.0),

          // Horizontal quick filter chips
          TicketQueueFilterChipsWidget(
            allActiveLabel: allActiveLabel,
            unassignedLabel: unassignedLabel,
            highPriorityLabel: highPriorityLabel,
            selectedFilter: selectedFilter,
            onFilterChanged: onFilterChanged,
          ),
        ],
      ),
    );
  }
}
