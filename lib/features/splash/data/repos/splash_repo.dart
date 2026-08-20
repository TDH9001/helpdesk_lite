import 'package:flutter/material.dart';
import 'package:helpdesk_lite/core/utils/localization_service/app_localizations.dart';
import 'package:helpdesk_lite/features/splash/data/model/splash_model.dart';

/// Contract repository for the Splash feature.
abstract class SplashRepository {
  Future<SplashModel> getSplashData(BuildContext context);
}

/// Static repository implementation that resolves localized splash data.
class StaticSplashRepository implements SplashRepository {
  const StaticSplashRepository();

  static SplashModel getStaticData(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SplashModel(
      logoAsset: 'assets/Images/helpdesk_lite_icon_only.png',
      title: l10n.splashTitle,
      titleAccent: l10n.splashTitleAccent,
      subtitle: l10n.splashSubtitle,
      startingUpText: l10n.splashStartingUp,
      connectingText: l10n.splashConnecting,
      readyText: l10n.splashReady,
    );
  }

  @override
  Future<SplashModel> getSplashData(BuildContext context) async {
    return getStaticData(context);
  }
}
