import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app%20fonts/app_fonts.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_category.dart';

/// Dropdown selector form field for choosing a support ticket category.
class CreateTicketCategoryFieldWidget extends StatelessWidget {
  final TicketCategory? selectedCategory;
  final String label;
  final String placeholder;
  final String requiredErrorText;
  final List<TicketCategoryOption> categories;
  final ValueChanged<TicketCategory?> onCategoryChanged;

  const CreateTicketCategoryFieldWidget({
    super.key,
    required this.selectedCategory,
    required this.label,
    required this.placeholder,
    required this.requiredErrorText,
    required this.categories,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Category label heading
    final labelWidget = Text(
      label,
      style: AppFonts().mobileCreateTicketFormLabelInter12Medium(
        context,
        color: widgetColors.onSurface,
      ),
    );

    // Dropdown input field
    final dropdownWidget = DropdownButtonFormField<TicketCategory>(
      initialValue: selectedCategory,
      isExpanded: true,
      icon: Icon(
        Icons.expand_more_rounded,
        color: widgetColors.onSurfaceVariant,
        size: 20.0,
      ),
      dropdownColor: widgetColors.surfaceContainerLowest,
      style: AppFonts().mobileCreateTicketDropdownInter14Regular(
        context,
        color: widgetColors.onSurface,
      ),
      hint: Text(
        placeholder,
        style: AppFonts().mobileCreateTicketDropdownInter14Regular(
          context,
          color: widgetColors.onSurfaceVariant,
        ),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: widgetColors.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 10.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.outlineVariant,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.error,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: widgetColors.error,
            width: 1.5,
          ),
        ),
        errorStyle: AppFonts().mobileCreateTicketErrorInter11Regular(
          context,
          color: widgetColors.error,
        ),
      ),
      items: categories.map((cat) {
        return DropdownMenuItem<TicketCategory>(
          value: cat.category,
          child: Text(cat.label),
        );
      }).toList(),
      onChanged: onCategoryChanged,
      validator: (value) {
        if (value == null) {
          return requiredErrorText;
        }
        return null;
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelWidget,
        const SizedBox(height: 6.0),
        dropdownWidget,
      ],
    );
  }
}
