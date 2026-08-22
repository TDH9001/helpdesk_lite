import 'package:flutter/material.dart';
import 'package:helpdesk_lite/features/ticket_queue/presentation/view/widgets/ticket_queue_filter_chip_item_widget.dart';

/// Filter selection modes available on the Ticket Queue screen.
enum QueueFilterType {
  allActive,
  unassigned,
  highPriority,
}

/// Horizontal list of quick-filter pill buttons for filtering tickets in the queue.
class TicketQueueFilterChipsWidget extends StatelessWidget {
  final String allActiveLabel;
  final String unassignedLabel;
  final String highPriorityLabel;
  final QueueFilterType selectedFilter;
  final ValueChanged<QueueFilterType>? onFilterChanged;

  const TicketQueueFilterChipsWidget({
    super.key,
    required this.allActiveLabel,
    required this.unassignedLabel,
    required this.highPriorityLabel,
    this.selectedFilter = QueueFilterType.allActive,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          TicketQueueFilterChipItemWidget(
            label: allActiveLabel,
            icon: Icons.filter_list_rounded,
            filterType: QueueFilterType.allActive,
            isSelected: selectedFilter == QueueFilterType.allActive,
            onSelected: onFilterChanged,
          ),
          const SizedBox(width: 8.0),
          TicketQueueFilterChipItemWidget(
            label: unassignedLabel,
            icon: Icons.person_off_outlined,
            filterType: QueueFilterType.unassigned,
            isSelected: selectedFilter == QueueFilterType.unassigned,
            onSelected: onFilterChanged,
          ),
          const SizedBox(width: 8.0),
          TicketQueueFilterChipItemWidget(
            label: highPriorityLabel,
            icon: Icons.flag_outlined,
            filterType: QueueFilterType.highPriority,
            isSelected: selectedFilter == QueueFilterType.highPriority,
            onSelected: onFilterChanged,
            customIconColor: Colors.amber.shade700,
          ),
        ],
      ),
    );
  }
}
