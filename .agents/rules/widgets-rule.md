---
trigger: always_on
---

# Rule: Standalone Widgets & One Widget Per File

## Purpose
Prevent local helper widget builder functions and enforce strict componentization where every widget is an independent, reusable, standalone widget class in its own dedicated file.

## Core Rules

1. **No Local Widget Helper Methods or Functions:**
   - Never write methods or functions that return `Widget` inside a class or file (e.g., `Widget _buildCard()`, `Widget _buildHeader()`, `Widget _buildChip()`, or local functions inside `build(BuildContext context)`).
   - Any visual element, sub-component, row, card, or repeated item MUST be extracted into a standalone widget class extending `StatelessWidget` (or `StatefulWidget` when local state is needed).

2. **One Widget Per File:**
   - Every widget class gets its own dedicated `.dart` file.
   - Do not define multiple widget classes within the same file (e.g., no private `class _ChildWidget extends StatelessWidget` living at the bottom of another widget's file).
   - When a widget is extracted, it immediately receives its own new file.

3. **File Placement & Naming:**
   - **Feature-scoped widgets:** Place in `lib/features/<feature_name>/presentation/view/widgets/` named `<feature_name>_<component_name>_widget.dart`.
   - **Cross-feature / App-wide widgets:** Place in `lib/core/widgets/` named `<component_name>_widget.dart`.

4. **Documentation & Formatting:**
   - Every extracted widget class must have a top-level `///` doc comment describing its exact purpose and UI role.
   - All colors and typography must resolve through `AppThemeColors` and `AppFonts` per the project's color and font rules.

## Enforcement
- Any code containing local `Widget _build...()` methods or multiple widget classes in a single file must be rejected and refactored into separate files.
