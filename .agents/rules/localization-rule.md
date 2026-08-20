---
trigger: always_on
---

# Rule: Mandatory Localization (L10N)

## Purpose
No static/hardcoded user-facing text may ever appear directly in a widget.
Every piece of visible text must be sourced through the app's localization
(L10N) system.

## Rule
1. **No hardcoded strings.** Any user-facing text (labels, buttons, titles,
   error messages, hints, tooltips, etc.) must never be written as a raw
   string literal inside a widget.
2. **Always go through L10N.** Text must be pulled from the generated
   localization class, e.g.:
   ```dart
   AppLocalizations.of(context)!.someKey
   ```
   or the project's preferred accessor (e.g. a `context.l10n.someKey`
   extension, if one exists).
3. **Add the key at the same time as the text.** Whenever new static text is
   introduced (manually, or from a design import), the corresponding key
   must be added to the localization files for **all** supported languages
   (Arabic and English) in the same change — never added for one language
   and left missing/untranslated for the other.
4. **No placeholder/English-only shortcuts.** Do not add a key to only the
   English `.arb` file "to fix it later" — both languages are added together
   or the text isn't merged.
5. **Call it once per widget.** Never call `AppLocalizations.of(context)!`
   more than once inside the same widget/build method. Call it once, store
   it in a variable named `l10n`, and reference `l10n.someKey` everywhere
   else in that widget instead of repeating the lookup.

5. **Resolve once, at the source — not in the widget.** For static UI text,
   `l10n` is called once inside the feature's `Static<Feature>Repository`
   `getStaticData(context)` function (see the MVVM rule's Static Data
   Repository Pattern) and stored as a variable named `l10n` there. The
   resulting model is what the screen/widget consumes — widgets do not call
   `AppLocalizations.of(context)!` directly for text that belongs to a
   static model. If a widget genuinely needs a one-off localized string
   outside that pattern, the same rule applies at the widget level: call it
   once, store it as `l10n`, never call it twice in the same build.

## Pattern
```dart
// Inside Static<Feature>Repository.getStaticData(context):
final l10n = AppLocalizations.of(context)!;

return LandingModel(
  title: l10n.landingTitle,
  subtitle: l10n.landingSubtitle,
  primaryButtonText: l10n.buyCarButton,
  secondaryButtonText: l10n.sellCarButton,
  trustIndicators: [
    TrustIndicator(title: l10n.trust1Title, subtitle: l10n.trust1Subtitle),
    TrustIndicator(title: l10n.trust2Title, subtitle: l10n.trust2Subtitle),
  ],
);
// The screen then just consumes the resulting LandingModel — no l10n
// calls of its own.
```

## Enforcement
- Any code (including design-to-code output from MCP tools) that introduces
  a raw string literal as user-facing text must be rejected and rewritten to
  use a localization key.
- Any new localization key must appear in every supported language's `.arb`
  file before the change is considered complete.
- Any code that calls `AppLocalizations.of(context)!` more than once inside
  the same widget must be rejected and rewritten to use a single `l10n`
  variable instead.