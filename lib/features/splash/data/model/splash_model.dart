/// Data model holding static display content for the Splash Screen.
class SplashModel {
  final String logoAsset;
  final String title;
  final String titleAccent;
  final String subtitle;
  final String startingUpText;
  final String connectingText;
  final String readyText;

  const SplashModel({
    required this.logoAsset,
    required this.title,
    required this.titleAccent,
    required this.subtitle,
    required this.startingUpText,
    required this.connectingText,
    required this.readyText,
  });
}
