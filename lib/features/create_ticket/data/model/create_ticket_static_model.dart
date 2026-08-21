import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_category.dart';

/// Category option item for ticket categorization dropdown.
class TicketCategoryOption {
  final TicketCategory category;
  final String label;

  const TicketCategoryOption({
    required this.category,
    required this.label,
  });
}

/// Static UI text model for Create Ticket feature.
class CreateTicketStaticModel {
  final String appBarTitle;
  final String headerTitle;
  final String headerSubtitle;
  final String subjectLabel;
  final String subjectPlaceholder;
  final String categoryLabel;
  final String selectCategoryPlaceholder;
  final List<TicketCategoryOption> categories;
  final String priorityLabel;
  final String priorityLowLabel;
  final String priorityMediumLabel;
  final String priorityHighLabel;
  final String descriptionLabel;
  final String descriptionPlaceholder;
  final String attachmentsLabel;
  final String uploadZoneHint;
  final String submitButtonLabel;
  final String subjectRequiredError;
  final String categoryRequiredError;
  final String descriptionRequiredError;
  final String descriptionTooShortError;
  final String fileSizeExceededError;
  final String totalSizeExceededError;
  final String ticketSubmittedSuccess;
  final String buttonErrorFixFields;

  const CreateTicketStaticModel({
    required this.appBarTitle,
    required this.headerTitle,
    required this.headerSubtitle,
    required this.subjectLabel,
    required this.subjectPlaceholder,
    required this.categoryLabel,
    required this.selectCategoryPlaceholder,
    required this.categories,
    required this.priorityLabel,
    required this.priorityLowLabel,
    required this.priorityMediumLabel,
    required this.priorityHighLabel,
    required this.descriptionLabel,
    required this.descriptionPlaceholder,
    required this.attachmentsLabel,
    required this.uploadZoneHint,
    required this.submitButtonLabel,
    required this.subjectRequiredError,
    required this.categoryRequiredError,
    required this.descriptionRequiredError,
    required this.descriptionTooShortError,
    required this.fileSizeExceededError,
    required this.totalSizeExceededError,
    required this.ticketSubmittedSuccess,
    required this.buttonErrorFixFields,
  });
}
