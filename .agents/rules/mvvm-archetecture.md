---
trigger: always_on
---

# Rule: MVVM Folder Architecture

## Purpose
Enforce a consistent MVVM folder structure across the entire app. Every
feature must follow this exact layout — no ad-hoc folders, no skipped layers,
no feature-specific logic leaking into `core`.

## Top-Level Structure
```
lib/
├── core/
│   ├── widgets/
│   └── utils/
│       ├── app_fonts/
│       ├── app_colors/
│       ├── app_theme/
│       ├── localization_service/
│       ├── responsive_service/
│       ├── routing_service/
│       ├── shared_models/
│       ├── snackbar_service/
│       └── ... (other shared, cross-app services/functions)
├── features/
│   └── <feature_name>/
│       ├── data/
│       │   ├── model/
│       │   └── repos/
│       │       ├── <feature>_repo.dart        (abstract class)
│       │       └── implementations/           (concrete implementations)
│       └── presentation/
│           ├── view/
│           │   ├── layouts/
│           │   ├── widgets/                   (feature-scoped widgets only)
│           │   └── <feature>_screen.dart
│           └── view_model/
│               └── <feature>_cubit.dart        (state management)
└── main.dart
```

## Rule

### 1. `features/<feature_name>/`
Every feature is fully self-contained under its own folder with exactly two
top-level sub-folders: `data/` and `presentation/`.

**`data/`**
- `model/` — data models for this feature only.
- `repos/` — contains:
  - the **abstract repo class** (the contract) directly inside `repos/`.
  - `implementations/` — the concrete repo implementation(s). **Implementations
    are team-lead-owned only** — other contributors code against the abstract
    repo class, not the implementation.

**`presentation/`**
- `view/`
  - `layouts/` — layout scaffolding for the feature's screen(s).
  - `widgets/` — widgets used ONLY within this feature. Never promote a
    feature-specific widget to `core/widgets/` just for convenience.
  - `<feature>_screen.dart` — the screen entry point.
- `view_model/`
  - `<feature>_cubit.dart` (or equivalent state management class) — owns all
    state/business logic for the feature. Views never talk to repos directly;
    they go through the view model.

### 2. `core/widgets/`
This folder is reserved **only** for widgets that are guaranteed to be reused
across many screens/features app-wide — e.g. the language toggle, the
light/dark mode toggle, a shared form field.

**Test before placing a widget here:** "Will this be used across multiple
unrelated features, not just multiple screens within one feature?" If the
answer is no, it belongs in that feature's `presentation/view/widgets/`
instead, not in `core`.

### 3. `core/utils/`
Shared, cross-app, non-UI-widget concerns only: fonts (`AppFonts`), colors
(`AppThemeColors`/`app_colors`), localization, responsive helpers, routing,
shared models, snackbar service, and any other app-wide utility/service. No
feature-specific logic is ever placed here.

### 4. Cross-feature boundaries
Features must not directly import or reference another feature's internals
(models, repos, widgets, cubits). Anything that needs to be shared across
features belongs in `core` instead.

## Enforcement
- Any new feature must be scaffolded with exactly this structure — no
  skipping `data`/`presentation`, no flattening `view`/`view_model`.
- Any widget added to `core/widgets/` must be justified against the reuse
  test above; if it fails the test, move it into the owning feature's
  `presentation/view/widgets/`.
- Any repo implementation added or modified outside review by the team lead
  should be flagged — implementations live in `repos/implementations/` and
  are team-lead-owned.