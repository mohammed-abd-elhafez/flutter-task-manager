# Task Manager

A focused Flutter task manager built with the same documentation-first standard as the starter architecture.

## Features

The app includes a progress summary, task filtering by workflow status, priority indicators, and tap-to-cycle task transitions. The current data source is a mock repository so the UI can be connected to an API or local database without changing the presentation layer.

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
