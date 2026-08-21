import 'package:flutter/widgets.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/model/mobile_bottom_nav_static_model.dart';
import 'package:helpdesk_lite/features/mobile_bottom_navigation_bar/data/repos/mobile_bottom_nav_repo.dart';

/// Concrete static implementation of MobileBottomNavRepo.
class StaticMobileBottomNavRepository implements MobileBottomNavRepo {
  const StaticMobileBottomNavRepository();

  static MobileBottomNavStaticModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MobileBottomNavStaticModel(
      title: l10n.myTickets,
      navMyTickets: l10n.navMyTickets,
      navNewTicket: l10n.navNewTicket,
      navQueue: l10n.navQueue,
      navOverview: l10n.navOverview,
      navSettings: l10n.navSettings,
      settingsTitle: l10n.settingsTitle,
      settingsSubtitle: l10n.settingsSubtitle,
      appearanceSection: l10n.appearanceSection,
      languageSection: l10n.languageSection,
      signOut: l10n.signOut,
    );
  }

  @override
  Future<MobileBottomNavStaticModel> getMobileBottomNavData(
    BuildContext context,
  ) async {
    return getStaticData(context);
  }
}
