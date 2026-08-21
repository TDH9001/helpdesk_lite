import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/model/desktop_drawer_static_model.dart';
import 'package:helpdesk_lite/features/desktop_drawer/data/repos/desktop_drawer_repo.dart';

/// Concrete static implementation of DesktopDrawerRepo.
class StaticDesktopDrawerRepository implements DesktopDrawerRepo {
  const StaticDesktopDrawerRepository();

  static DesktopDrawerStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DesktopDrawerStaticModel(
      appName: l10n.appName,
      internalOps: l10n.internalOps,
      navMyTickets: l10n.navMyTickets,
      navNewTicket: l10n.navNewTicket,
      navQueue: l10n.navQueue,
      navOverview: l10n.navOverview,
      navSupport: l10n.navSupport,
      navArchive: l10n.navArchive,
      signOut: l10n.signOut,
    );
  }

  @override
  Future<DesktopDrawerStaticModel> getDesktopDrawerData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }
}
