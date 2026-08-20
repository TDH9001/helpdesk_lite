---
trigger: always_on
---

# Rule: Centralized Color Management (AppThemeColors)

## Purpose
All colors used anywhere in the application MUST come from the
`AppThemeColors` theme extension. No widget may reference a color file,
constant, or raw `Color(...)` value directly.

## Rule
1. **No direct color file access.** Colors must never be pulled from a
   standalone colors/constants file or hardcoded as `Color(0x...)` inside a
   widget.
2. **Always resolve through the theme extension**, using this pattern:
   ```dart
   Theme.of(context).extension<AppThemeColors>()!.colors.<color_of_choice>
   ```
3. **Call it once per widget.** Inside a widget's `build` method (or
   equivalent), call `Theme.of(context).extension<AppThemeColors>()!.colors`
   exactly once, store it in a variable named `widgetColors`, and reference
   `widgetColors.<color_of_choice>` everywhere else in that widget instead of
   repeating the full lookup.

## Pattern
```dart
@override
Widget build(BuildContext context) {
  final widgetColors = Theme.of(context).extension<AppThemeColors>()!.colors;

  return Container(
    color: widgetColors.background,
    child: Text(
      'Hello',
      style: AppFonts().mobileLandingPageTrustIndicatorCairo16Bold(
        context,
        color: widgetColors.primaryText,
      ),
    ),
  );
}
```

## Enforcement
- Any code (including design-to-code output from MCP tools) that references
  a color file directly, hardcodes a `Color` value, or re-calls
  `Theme.of(context).extension<AppThemeColors>()!.colors` more than once
  inside the same widget must be rejected and rewritten to follow this rule.