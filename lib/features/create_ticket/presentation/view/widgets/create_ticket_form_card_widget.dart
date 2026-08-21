import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/file_picker_service/file_picker_service.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_attachment_item.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_category.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_attachments_section_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_category_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_description_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_subject_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_submit_button_widget.dart';

/// Form card container handling inputs, file attachments, and submission.
class CreateTicketFormCardWidget extends StatefulWidget {
  final CreateTicketStaticModel staticData;
  final bool isDesktop;

  const CreateTicketFormCardWidget({
    super.key,
    required this.staticData,
    this.isDesktop = false,
  });

  @override
  State<CreateTicketFormCardWidget> createState() =>
      _CreateTicketFormCardWidgetState();
}

class _CreateTicketFormCardWidgetState
    extends State<CreateTicketFormCardWidget> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  TicketCategory? _selectedCategory;
  final List<TicketAttachmentItem> _attachments = [];

  static const int _maxSingleFileSize = 5 * 1024 * 1024; // 5 MB
  static const int _maxTotalFileSize = 25 * 1024 * 1024; // 25 MB

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  int get _currentTotalBytes {
    return _attachments.fold<int>(0, (sum, item) => sum + item.size);
  }

  Future<void> _pickFiles() async {
    try {
      final List<PlatformFile> files =
          await FilePickerService.pickMultipleFiles();

      if (files.isEmpty) {
        return;
      }

      int newBatchSize = 0;
      final List<TicketAttachmentItem> validNewItems = [];

      for (final file in files) {
        final int fileSize = await file.length();

        if (fileSize > _maxSingleFileSize) {
          if (mounted) {
            SnackBarService.showError(
              context,
              widget.staticData.fileSizeExceededError,
            );
          }
          return;
        }

        newBatchSize += fileSize;
        validNewItems.add(
          TicketAttachmentItem(
            file: file,
            name: file.name,
            size: fileSize,
          ),
        );
      }

      if (_currentTotalBytes + newBatchSize > _maxTotalFileSize) {
        if (mounted) {
          SnackBarService.showError(
            context,
            widget.staticData.totalSizeExceededError,
          );
        }
        return;
      }

      setState(() {
        _attachments.addAll(validNewItems);
      });
    } catch (_) {
      // User cancelled or platform picker closed without selection
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _selectedCategory == null) {
      SnackBarService.showError(
        context,
        widget.staticData.buttonErrorFixFields,
      );
      return;
    }

    //! <Where ticket submission state should be handled >

    SnackBarService.showInfo(context, widget.staticData.ticketSubmittedSuccess);

    _formKey.currentState?.reset();
    _subjectController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedCategory = null;
      _attachments.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

    // Form inputs and action widgets
    final formBody = Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CreateTicketSubjectFieldWidget(
            controller: _subjectController,
            label: widget.staticData.subjectLabel,
            placeholder: widget.staticData.subjectPlaceholder,
            requiredErrorText: widget.staticData.subjectRequiredError,
          ),
          const SizedBox(height: 16.0),
          CreateTicketCategoryFieldWidget(
            selectedCategory: _selectedCategory,
            label: widget.staticData.categoryLabel,
            placeholder: widget.staticData.selectCategoryPlaceholder,
            requiredErrorText: widget.staticData.categoryRequiredError,
            categories: widget.staticData.categories,
            onCategoryChanged: (val) => setState(() => _selectedCategory = val),
          ),
          const SizedBox(height: 16.0),
          CreateTicketDescriptionFieldWidget(
            controller: _descriptionController,
            label: widget.staticData.descriptionLabel,
            placeholder: widget.staticData.descriptionPlaceholder,
            requiredErrorText: widget.staticData.descriptionRequiredError,
            tooShortErrorText: widget.staticData.descriptionTooShortError,
          ),
          const SizedBox(height: 16.0),
          CreateTicketAttachmentsSectionWidget(
            label: widget.staticData.attachmentsLabel,
            uploadHint: widget.staticData.uploadZoneHint,
            attachments: _attachments,
            onPickFiles: _pickFiles,
            onRemoveAttachment: _removeAttachment,
          ),
          const SizedBox(height: 20.0),
          CreateTicketSubmitButtonWidget(
            label: widget.staticData.submitButtonLabel,
            onSubmit: _submitForm,
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: widgetColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: widgetColors.outlineVariant, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: formBody,
    );
  }
}
