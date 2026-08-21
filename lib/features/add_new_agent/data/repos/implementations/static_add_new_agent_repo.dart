import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/model/add_new_agent_static_model.dart';
import 'package:helpdesk_lite/features/add_new_agent/data/repos/add_new_agent_repo.dart';

/// Concrete static implementation of [AddNewAgentRepo].
class StaticAddNewAgentRepository implements AddNewAgentRepo {
  const StaticAddNewAgentRepository();

  static AddNewAgentStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AddNewAgentStaticModel(
      title: l10n.addNewAgentTitle,
      subtitle: l10n.addNewAgentSubtitle,
      nameLabel: l10n.agentNameLabel,
      nameHint: l10n.agentNameHint,
      emailLabel: l10n.emailAddress,
      emailHint: l10n.emailPlaceholder,
      passwordLabel: l10n.password,
      passwordHint: l10n.passwordPlaceholder,
      roleLabel: l10n.agentRoleLabel,
      roleWorker: l10n.roleWorker,
      roleManager: l10n.roleManager,
      createAgentButton: l10n.createAgentButton,
      cancelButton: l10n.cancelButton,
      successMessage: l10n.agentCreatedSuccess,
    );
  }

  @override
  Future<AddNewAgentStaticModel> getAddNewAgentData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }
}
