import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/app_theme/app_theme_colors.dart';
import 'package:helpdesk_lite/core/utils/cloud_storage_service/cloud_storage_service.dart';
import 'package:helpdesk_lite/core/utils/database_service/database_service.dart';
import 'package:helpdesk_lite/core/utils/local_storage_service/user_hive_box.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_attachment_item.dart';
import 'package:helpdesk_lite/core/utils/shared_models/ticket_model.dart';
import 'package:helpdesk_lite/core/utils/snackbar_service/snackbar_service.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/create_ticket_static_model.dart';
import 'package:helpdesk_lite/features/create_ticket/data/model/ticket_category.dart';
import 'package:helpdesk_lite/features/create_ticket/data/repos/create_ticket_repo.dart';
import 'package:helpdesk_lite/features/create_ticket/data/repos/implementations/static_create_ticket_repo.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_attachments_section_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_category_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_description_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_subject_field_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_submit_button_widget.dart';
import 'package:helpdesk_lite/features/create_ticket/presentation/view/widgets/create_ticket_upload_progress_widget.dart';

/// Form card container handling inputs, file attachments, and submission.
class CreateTicketFormCardWidget extends StatefulWidget {
  final CreateTicketStaticModel staticData;
  final CreateTicketRepo repository;
  final bool isDesktop;

  const CreateTicketFormCardWidget({
    super.key,
    required this.staticData,
    this.repository = const StaticCreateTicketRepository(),
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
  final CloudStorageService _storageService = CloudStorageService();
  final DatabaseService _databaseService = DatabaseService();

  TicketCategory? _selectedCategory;
  final List<TicketAttachmentItem> _attachments = [];
  bool _isSubmitting = false;
  double _uploadProgress = 0.0;
  String _statusMessage = '';

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
    if (_isSubmitting) return;

    final newItems = await widget.repository.pickAttachments();
    if (newItems.isEmpty) {
      return;
    }

    int newBatchSize = 0;
    for (final item in newItems) {
      if (item.size > _maxSingleFileSize) {
        if (mounted) {
          SnackBarService.showError(
            context,
            widget.staticData.fileSizeExceededError,
          );
        }
        return;
      }
      newBatchSize += item.size;
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
      _attachments.addAll(newItems);
    });
  }

  void _removeAttachment(int index) {
    if (_isSubmitting) return;
    setState(() {
      _attachments.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_isSubmitting) return;

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _selectedCategory == null) {
      SnackBarService.showError(
        context,
        widget.staticData.buttonErrorFixFields,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
      _uploadProgress = 0.0;
      _statusMessage = _attachments.isNotEmpty
          ? widget.staticData.uploadingAttachments(0)
          : widget.staticData.submittingTicket;
    });

    try {
      final List<String> uploadedUrls = [];

      // Sequentially upload file attachments and report progress percentage
      if (_attachments.isNotEmpty) {
        for (int i = 0; i < _attachments.length; i++) {
          final item = _attachments[i];
          final url = await _storageService.uploadPlatformFile(
            platformFile: item.file,
          );
          uploadedUrls.add(url);

          if (mounted) {
            final progressVal = ((i + 1) / _attachments.length) * 0.85;
            final percentageInt = (progressVal * 100).toInt();
            setState(() {
              _uploadProgress = progressVal;
              _statusMessage =
                  widget.staticData.uploadingAttachments(percentageInt);
            });
          }
        }
      }

      if (mounted) {
        setState(() {
          _uploadProgress = 0.90;
          _statusMessage = widget.staticData.submittingTicket;
        });
      }

      // Retrieve current authenticated user profile
      final currentUser = await UserHiveBox.getUserData();

      final categoryLabel = _selectedCategory != null
          ? widget.staticData.categories
              .firstWhere(
                (c) => c.category == _selectedCategory,
                orElse: () => widget.staticData.categories.first,
              )
              .label
          : 'General';

      // Create new ticket model with high priority per system rules
      final ticket = TicketModel(
        id: '',
        code: '',
        title: _subjectController.text.trim(),
        description: _descriptionController.text.trim(),
        category: categoryLabel,
        status: TicketStatus.open,
        priority: TicketPriority.high,
        creatorId: currentUser?.id,
        creatorName: currentUser?.fullName ??
            currentUser?.email.split('@').first,
        creatorEmail: currentUser?.email,
        attachments: uploadedUrls,
      );

      await _databaseService.createTicket(ticket: ticket);

      if (mounted) {
        setState(() {
          _uploadProgress = 1.0;
        });

        SnackBarService.showInfo(
          context,
          widget.staticData.ticketSubmittedSuccess,
        );

        _formKey.currentState?.reset();
        _subjectController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedCategory = null;
          _attachments.clear();
          _isSubmitting = false;
          _uploadProgress = 0.0;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _uploadProgress = 0.0;
        });
        SnackBarService.showError(
          context,
          e.toString().isNotEmpty
              ? e.toString()
              : widget.staticData.ticketSubmittingError,
        );
      }
    }
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
            onCategoryChanged: (val) {
              if (!_isSubmitting) {
                setState(() => _selectedCategory = val);
              }
            },
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
          _isSubmitting
              ? CreateTicketUploadProgressWidget(
                  progress: _uploadProgress,
                  statusMessage: _statusMessage,
                )
              : CreateTicketSubmitButtonWidget(
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
