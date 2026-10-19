# Task Manager

A focused Flutter task manager built with the same documentation-first standard as the starter architecture.

## Features

The app includes a progress summary, task filtering by workflow status, visible status and priority labels, accessible tap-to-cycle task transitions, and confirmation feedback. The current data source is an in-memory mock repository, so changes reset on refresh; the UI can be connected to an API or local database without changing the presentation layer.

This repository is presented as a web-first architecture and interaction prototype. Android release signing and persistence are intentionally left for a production integration.

## Run

```bash
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
```

## Structure

```text
lib/
├── app.dart
├── core/theme/app_theme.dart
├── main.dart
└── features/tasks/
    ├── data/task_repository.dart
    ├── domain/task_models.dart
    └── presentation/
        ├── task_card.dart
        ├── task_controller.dart
        └── task_page.dart
```

## Documentation standard

Comments and documentation explain decisions and business rules. Clear widget syntax is intentionally left self-explanatory. The repository contract is the seam for adding persistence later.
