---
trigger: always_on
---

# Rule: Mandatory Responsive Service for Multi-Layout Screens

## Purpose
Whenever a design provides more than one layout (mobile, tablet, and/or
desktop), the screen MUST be built using the app's `ResponsiveService`
widget — never manual `MediaQuery`/`LayoutBuilder` width checks scattered
inside the screen itself.

## Rule
1. **Trigger condition.** If a design/spec includes more than one layout
   variant (e.g. a distinct mobile AND desktop version, or mobile/tablet/
   desktop), the feature must be split into per-breakpoint layout files and
   wired together with `ResponsiveService`.
2. **File location and naming.** Each layout variant lives in the feature's
   `presentation/view/layouts/` folder, named:
   ```
   <feature_name>_mobile.dart
   <feature_name>_tablet.dart
   <feature_name>_desktop.dart
   ```
3. **Wiring.** The feature's screen file (`<feature_name>_screen.dart`, or
   equivalent) composes the layouts via `ResponsiveService`, never inlines
   breakpoint logic itself:
   ```dart
   ResponsiveService(
     mobile: (context) => const LandingPageMobile(),
     tablet: (context) => const LandingPageTablet(),
     desktop: (context) => const LandingPageDesktop(),
   );
   ```
4. **Single-layout screens are exempt.** If a design only provides one
   layout (no separate tablet/desktop variant), `ResponsiveService` is not
   required — build the screen normally.
5. **No manual breakpoint checks.** Never hand-roll `MediaQuery.of(context)
   .size.width` comparisons or ad-hoc `LayoutBuilder` breakpoint logic
   inside a screen/widget — that logic already lives inside
   `ResponsiveService`/`Breakpoints` and must not be duplicated.

## Reference Implementation
```dart
import 'package:flutter/material.dart';
import 'package:mvvvm_template_with_basic_services/core/utils/responsive_service/breakpoints.dart';

enum DeviceTypes { mobile, tablet, desktop }

class ResponsiveService extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;

  const ResponsiveService({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static DeviceTypes getDeviceType(double deviceWidth) {
    if (deviceWidth < Breakpoints.mobile) {
      return DeviceTypes.mobile;
    } else if (deviceWidth < Breakpoints.tablet) {
      return DeviceTypes.tablet;
    } else {
      return DeviceTypes.desktop;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final type = getDeviceType(constraints.maxWidth);
        switch (type) {
          case DeviceTypes.mobile:
            return mobile(context);
          case DeviceTypes.tablet:
            return tablet?.call(context) ?? mobile(context);
          case DeviceTypes.desktop:
            return desktop?.call(context) ??
                tablet?.call(context) ??
                mobile(context);
        }
      },
    );
  }
}
```

## Enforcement
- Any generated screen (including design-to-code output from MCP tools)
  that has multiple layout variants but does not route through
  `ResponsiveService` must be rejected and restructured.
- `tablet`/`desktop` builders are optional and gracefully fall back
  (desktop → tablet → mobile) — only provide the layouts that actually
  exist for that feature.