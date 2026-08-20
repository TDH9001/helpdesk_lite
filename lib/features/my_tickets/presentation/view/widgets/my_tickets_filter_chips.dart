import 'package:flutter/material.dart';
import 'package:helpdesk_lite/features/my_tickets/data/model/ticket_model.dart';
import 'package:helpdesk_lite/features/my_tickets/presentation/view/widgets/my_tickets_filter_chip_item.dart';

/// Horizontal scrollable or wrap container of filter chips for filtering tickets.
class MyTicketsFilterChips extends StatelessWidget {
  final String allActiveLabel;
  final String openLabel;
  final String pendingLabel;
  final String waitingLabel;
  final String? dateLabel;
  final TicketStatus? selectedStatus;
  final bool isDesktop;
  final ValueChanged<TicketStatus?>? onStatusSelected;

  const MyTicketsFilterChips({
    super.key,
    required this.allActiveLabel,
    required this.openLabel,
    required this.pendingLabel,
    required this.waitingLabel,
    this.dateLabel,
    this.selectedStatus,
    this.isDesktop = false,
    this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    // List of filter chips items
    final chips = [
      MyTicketsFilterChipItem(
        label: allActiveLabel,
        isSelected: selectedStatus == null,
        isDesktop: isDesktop,
        onTap: () => onStatusSelected?.call(null),
      ),
      MyTicketsFilterChipItem(
        label: openLabel,
        isSelected: selectedStatus == TicketStatus.open,
        isDesktop: isDesktop,
        onTap: () => onStatusSelected?.call(TicketStatus.open),
      ),
      MyTicketsFilterChipItem(
        label: pendingLabel,
        isSelected: selectedStatus == TicketStatus.pending,
        isDesktop: isDesktop,
        onTap: () => onStatusSelected?.call(TicketStatus.pending),
      ),
      MyTicketsFilterChipItem(
        label: waitingLabel,
        isSelected: selectedStatus == TicketStatus.waiting,
        isDesktop: isDesktop,
        onTap: () => onStatusSelected?.call(TicketStatus.waiting),
      ),
      if (dateLabel != null)
        MyTicketsFilterChipItem(
          label: dateLabel!,
          isSelected: false,
          icon: Icons.calendar_month_outlined,
          isDesktop: isDesktop,
          onTap: () {
            //! <Where date filter selection should be handled>
          },
        ),
    ];

    if (isDesktop) {
      return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: chips,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: chips
            .map(
              (chip) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: chip,
              ),
            )
            .toList(),
      ),
    );
  }
}
