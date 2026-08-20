import 'package:flutter/material.dart';

/// Widget that displays the HelpDesk Lite logo with smooth entry scaling.
class SplashLogoWidget extends StatelessWidget {
  final String logoAsset;
  final double size;

  const SplashLogoWidget({
    super.key,
    required this.logoAsset,
    this.size = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        logoAsset,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.support_agent_rounded,
          size: size * 0.7,
        ),
      ),
    );
  }
}
