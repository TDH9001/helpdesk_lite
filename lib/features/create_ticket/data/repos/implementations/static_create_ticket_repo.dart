import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/file_picker_service/file_picker_service.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_category.dart';
import 'package:helpdesk_lite/features/create_ticket/data/repos/create_ticket_repo.dart';

/// Concrete static repository resolving localized text and file operations.
class StaticCreateTicketRepository implements CreateTicketRepo {
  const StaticCreateTicketRepository();

  /// Resolves localized static data once and returns a populated model.
  static CreateTicketStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CreateTicketStaticModel(
      appBarTitle: l10n.navNewTicket,
      headerTitle: l10n.createTicketTitle,
      headerSubtitle: l10n.createTicketSubtitle,
      subjectLabel: l10n.ticketSubject,
      subjectPlaceholder: l10n.ticketSubjectPlaceholder,
      categoryLabel: l10n.ticketCategory,
      selectCategoryPlaceholder: l10n.ticketSelectCategory,
      categories: [
        TicketCategoryOption(
          category: TicketCategory.technical,
          label: l10n.categoryTechnical,
        ),
        TicketCategoryOption(
          category: TicketCategory.billing,
          label: l10n.categoryBilling,
        ),
        TicketCategoryOption(
          category: TicketCategory.account,
          label: l10n.categoryAccount,
        ),
        TicketCategoryOption(
          category: TicketCategory.general,
          label: l10n.categoryGeneral,
        ),
      ],
      priorityLabel: l10n.ticketPriority,
      priorityLowLabel: l10n.priorityLow,
      priorityMediumLabel: l10n.priorityMedium,
      priorityHighLabel: l10n.priorityHigh,
      descriptionLabel: l10n.ticketDescription,
      descriptionPlaceholder: l10n.ticketDescriptionPlaceholder,
      attachmentsLabel: l10n.ticketAttachments,
      uploadZoneHint: l10n.ticketUploadZoneHint,
      submitButtonLabel: l10n.submitTicket,
      subjectRequiredError: l10n.subjectRequired,
      categoryRequiredError: l10n.categoryRequired,
      descriptionRequiredError: l10n.descriptionRequired,
      descriptionTooShortError: l10n.descriptionTooShort,
      fileSizeExceededError: l10n.fileSizeExceededError,
      totalSizeExceededError: l10n.totalSizeExceededError,
      ticketSubmittedSuccess: l10n.ticketSubmittedSuccess,
      buttonErrorFixFields: l10n.buttonErrorFixFields,
    );
  }

  @override
  Future<CreateTicketStaticModel> getCreateTicketData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }

  @override
  Future<List<TicketAttachmentItem>> pickAttachments() async {
    final files = await FilePickerService.pickMultipleFiles();
    if (files.isEmpty) {
      return const [];
    }

    final List<TicketAttachmentItem> items = [];
    for (final file in files) {
      final size = await file.length();
      items.add(TicketAttachmentItem(file: file, name: file.name, size: size));
    }
    return items;
  }
}
