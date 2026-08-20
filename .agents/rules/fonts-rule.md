---
trigger: always_on
---

# Rule: Centralized Text Style Management (AppFonts)

## Purpose
Every text style used anywhere in the application MUST be defined as a function
inside the central `AppFonts` class. No `TextStyle` may ever be created inline,
hardcoded, or defined locally inside a widget, page, or component — regardless
of whether the text/font is coming from a design implementation (e.g. via the
Google Stitch MCP server), a Figma handoff, or manual styling.

## Location
```
lib/core/utils/app_fonts/app_fonts.dart
```

## Rule
1. **No single-use fonts.** A `TextStyle(...)` must never be written directly
   inside a widget, page, or any file other than `app_fonts.dart`.
2. **One function per distinct text style.** Every unique combination of
   layout, feature, widget, font family, size, and weight gets its own method
   inside the `AppFonts` class.
3. **Reuse before creating.** Before adding a new function, check whether an
   identical style already exists in `AppFonts`. If it does, reuse it instead
   of duplicating.
4. **Mandatory trigger.** Any time a font/text style is introduced from a
   design source (Google Stitch MCP, Figma, manual design spec, etc.), the
   corresponding function must be created in `AppFonts` immediately — never
   applied inline "just this once."

## Function Signature Pattern
```dart
TextStyle <naming>(
  BuildContext context, {
  Color? color,
}) => TextStyle(
  fontFamily: '<FontFamily>',
  fontSize: <fontSize>,
  fontWeight: FontWeight.<weight>,
  color: color,
);
```

## Naming Convention
```
<layout><FeatureName><WidgetName><FontFamily><FontSize><FontWeight>
```

| Segment       | Description                                                        | Example        |
|---------------|---------------------------------------------------------------------|----------------|
| `layout`      | `mobile`, `tablet`, or `desktop` — the breakpoint the style targets | `mobile`       |
| `FeatureName` | The feature/page/module the text belongs to (PascalCase)            | `LandingPage`  |
| `WidgetName`  | The specific widget/text element it's used on (PascalCase)          | `TrustIndicator` |
| `FontFamily`  | The font family name                                                 | `Cairo`        |
| `FontSize`    | The numeric font size                                                 | `16`           |
| `FontWeight`  | The weight, written out (`Bold`, `SemiBold`, `Medium`, `Regular`, `Light`) | `Bold`     |

**Full example:** `mobileLandingPageTrustIndicatorCairo16Bold`

## Reference Example
```dart
import 'dart:ui';
import 'package:flutter/material.dart';

class AppFonts {
  TextStyle mobileCoreSnackBarCairo14Medium(
    BuildContext context, {
    Color? color,
  }) => TextStyle(
    fontFamily: 'Cairo',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color,
  );

  TextStyle mobileLandingPageTrustIndicatorCairo16Bold(
    BuildContext context, {
    Color? color,
  }) => TextStyle(
    fontFamily: 'Cairo',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: color,
  );
}
```

## Enforcement
- Any code review / AI-assisted generation (including design-to-code output
  from MCP tools) that introduces a `TextStyle` outside of `app_fonts.dart`
  must be rejected and rewritten to follow this rule.
- If a responsive style is shared across breakpoints (identical style for
  mobile/tablet/desktop), it may be created once without a layout prefix, but
  this should be a deliberate, explicit exception — not a default.





