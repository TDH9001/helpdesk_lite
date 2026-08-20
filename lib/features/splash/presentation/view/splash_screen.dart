import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:helpdesk_lite/core/utils/responsive_service/respnsive_service.dart';
import 'package:helpdesk_lite/features/splash/data/repos/splash_repo.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/layouts/splash_desktop.dart';
import 'package:helpdesk_lite/features/splash/presentation/view/layouts/splash_mobile.dart';

/// Entry screen for application startup and splash presentation.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _startLoadingSequence();
  }

  /// Simulates initialization progress before routing to customer auth.
  //! <Where splash initialization cubit / startup task should be handled>
  void _startLoadingSequence() {
    const totalTicks = 20;
    int currentTick = 0;

    _progressTimer = Timer.periodic(
      const Duration(milliseconds: 75),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        currentTick++;
        setState(() {
          _progress = currentTick / totalTicks;
        });

        if (currentTick >= totalTicks) {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 250), () {
            if (mounted) {
              context.go('/customer-auth');
            }
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Resolve static localized splash content from repository
    final splashData = StaticSplashRepository.getStaticData(context);

    // Determine current status string based on progress percentage
    final String currentStatus;
    if (_progress < 0.35) {
      currentStatus = splashData.startingUpText;
    } else if (_progress < 0.8) {
      currentStatus = splashData.connectingText;
    } else {
      currentStatus = splashData.readyText;
    }

    return ResponsiveService(
      mobile: (context) => SplashMobile(
        data: splashData,
        progress: _progress,
        currentStatus: currentStatus,
      ),
      desktop: (context) => SplashDesktop(
        data: splashData,
        progress: _progress,
        currentStatus: currentStatus,
      ),
    );
  }
}
