# 🎫 HelpDesk Lite

<p align="center">
  <b>A sleek, cross-platform support ticketing system — built with Flutter, powered by Supabase.</b>
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.11-02569B?logo=flutter&logoColor=white">
  <img alt="Dart" src="https://img.shields.io/badge/Dart-^3.11.4-0175C2?logo=dart&logoColor=white">
  <img alt="Supabase" src="https://img.shields.io/badge/Backend-Supabase-3ECF8E?logo=supabase&logoColor=white">
  <img alt="Platforms" src="https://img.shields.io/badge/Platforms-Android%20|%20iOS%20|%20Web%20|%20Windows%20|%20macOS%20|%20Linux-informational">
  <img alt="License" src="https://img.shields.io/badge/status-active-brightgreen">
</p>

<p align="center">
  <a href="https://helpdesk-lite-indol.vercel.app/"><img alt="Live Demo" src="https://img.shields.io/badge/🔗_Live_Demo-helpdesk--lite--indol.vercel.app-success?style=for-the-badge"></a>
</p>

<h3 align="center">
  🔗 <a href="https://helpdesk-lite-indol.vercel.app/"><b>helpdesk-lite-indol.vercel.app</b></a>
</h3>

<p align="center">
  Deployed and live — click above to try it out.
</p>

---

From opening a ticket to closing it out, HelpDesk Lite covers the whole support loop: customers raise issues and chat directly with the people fixing them, while agents and managers triage the queue, assign work, and keep an eye on team performance — in **Arabic or English**, on **any platform**, **light or dark**.

## ✨ Features

| | |
|---|---|
| 🔐 **Customer Authentication** | Email/password sign-up & login, backed by Supabase Auth |
| 🎟️ **Ticket Creation** | Title, description, category, priority, and multi-file attachments |
| 📋 **My Tickets** | Customers track every ticket they've raised, live |
| 📥 **Ticket Queue** | Agents filter by unassigned / high-priority, and search by code, title, customer, or category |
| 💬 **In-Ticket Chat** | Threaded conversations per ticket for both customers and workers, with attachments and internal-only notes |
| 🧑‍💼 **Agent Management** | Managers onboard new support agents on the fly |
| 📊 **Overview Dashboard** | Live metrics — total open tickets & tickets created this week |
| 📱💻 **Adaptive Navigation** | Bottom nav bar on mobile, side drawer on desktop — auto-switches at breakpoints |
| 🌗 **Theming** | Full light/dark mode, toggled instantly via `ThemeCubit` |
| 🌍 **Localization** | Complete Arabic + English translations with in-app language switching |
| 📦 **Offline-Friendly Cache** | Hive stores the logged-in user profile locally for fast, resilient reloads |

## 🧰 Core Services

Everything the app needs to talk to the outside world lives under `lib/core/utils/`, each wrapped in its own focused service:

| Service | What it does |
|---|---|
| **`SupabaseDeclaration`** | Bootstraps the Supabase client (URL + publishable key) once at app start |
| **`DatabaseService`** | The workhorse — CRUD for users, tickets, and messages: create/assign/search tickets, track per-agent handled-ticket counts, compute live overview metrics (open count, created-this-week), append attachments, and auto-post a ticket's description as its first chat message |
| **`AuthenticationService`** | Sign-up (creates the auth user *and* the matching `user` table row in one call), login, logout, and password-reset via Supabase Auth |
| **`CloudStorageService`** | Uploads ticket attachments to Supabase Storage — handles `File` *and* `PlatformFile` (so it works identically on Web, mobile, and desktop), auto-detects MIME type, sanitizes filenames, supports batch uploads, and returns public URLs |
| **`FilePickerService`** | Thin cross-platform wrapper around `file_picker` for single/multi file selection |
| **`HiveDatabases` / `UserHiveBox`** | Local persistence — caches the signed-in user's profile in a Hive box so the app can hydrate instantly without a network round-trip |
| **`ResponsiveService`** | A `LayoutBuilder`-driven widget that switches between mobile/tablet/desktop builders at configurable breakpoints (600px / 900px) |
| **`SnackBarService`** | Centralized, theme-aware info & error banners (rounded, floating, icon-led) so every screen shows feedback consistently |
| **`LocalizationService` / `LocalizationCubit`** | ARB-based i18n pipeline driving runtime switching between Arabic and English |
| **`AppTheme` / `ThemeCubit`** | Centralized `ThemeData` for light & dark mode, exposed app-wide via a theme extension |
| **`AppFonts` / `AppColors`** | Design-token layer — a single source of truth for text styles and the color palette, so UI stays consistent across every screen |

## 🏗️ Architecture

HelpDesk Lite is organized as **feature-first MVVM**: every screen under `lib/features/` is a self-contained module with its own `data` and `presentation` layers, and within `presentation`, a strict **View ↔ ViewModel** split.

```
lib/
├── core/
│   ├── utils/            # Shared services — see table above
│   └── widgets/          # Shared widgets (language/theme toggles, image preview)
├── features/
│   ├── splash/
│   ├── customer_authentication/
│   ├── create_ticket/
│   ├── my_tickets/
│   ├── ticket_queue/
│   ├── customer_chat/
│   ├── worker_chat/
│   ├── overview/
│   ├── add_new_agent/
│   ├── mobile_bottom_navigation_bar/
│   └── desktop_drawer/
└── main.dart
```

**How the layers talk to each other:**

- **View** — pure Flutter widgets (`*_screen.dart`, plus `layouts/` for responsive mobile/desktop variants and `widgets/` for feature-scoped components). Views never call services directly; they only read state from and dispatch actions to their ViewModel via `BlocBuilder` / `BlocProvider`.
- **ViewModel** — a `Cubit<State>` per feature (e.g. `TicketQueueCubit extends Cubit<TicketQueueStates>`) that owns all business logic: fetching data, applying filters/search, handling form submission, and emitting sealed state classes (`...Initial`, `...Loading`, `...Success`, `...Failure`) that the View reacts to.
- **Data** — some features define an abstract **repository contract** (e.g. `TicketQueueRepo`) with a concrete implementation under `implementations/` (e.g. `StaticTicketQueueRepo`), decoupling the ViewModel from where data actually comes from (localized static content, in this case). For live app data, ViewModels call the shared `DatabaseService`, `AuthenticationService`, and `CloudStorageService` directly rather than going through Supabase clients themselves — keeping all network/backend logic out of the UI layer entirely.

This keeps each feature testable and swappable in isolation: a View can be redesigned without touching logic, a ViewModel can be unit-tested without a widget tree, and a repository's data source can be swapped without either of them knowing.

State management runs on **`flutter_bloc`** (Cubits) throughout, navigation on **`go_router`**, with a `MultiBlocProvider` wiring up the two app-wide Cubits — `LocalizationCubit` and `ThemeCubit` — at the root in `main.dart`.

### Data models

| Model | Purpose |
|---|---|
| **`TicketModel`** | Full ticket record — `code`, `title`, `description`, `category`, `TicketStatus` (open → pending → delayed → waiting → resolved → closed), `TicketPriority` (urgent/high/medium/low), creator & assignee info, attachments, timestamps, soft-delete flag |
| **`UserModel`** | Account profile — `email`, `UserType` (user/worker/manager), full name, ticket history, handled-ticket count, last sign-in |
| **`ChatMessageModel`** | Per-ticket chat message with sender role, content, attachments, and an internal-note flag |

## 📱 Platforms

Android · iOS · Web · Windows · macOS · Linux — build targets for all six are included out of the box.

## 🌍 Localization

Translations live in `.arb` files (see `L10n.yaml`), with `LocalizationCubit` flipping the app's `Locale` between `ar` and `en` at runtime — no restart required.

---

<p align="center">Built with 💙 and Flutter.</p>
