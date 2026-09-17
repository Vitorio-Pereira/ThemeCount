# ThemeCount

A small Flutter practice project: a counter app with a persisted dark/light theme toggle. Built as a first hands-on exercise with `StatefulWidget`, parent-child callbacks, and async local storage.

## Features

- Increment / decrement / reset counter
- Decrement and reset are disabled when the counter is at 0
- Dark/light theme toggle (`ThemeMode`), controlled from the app root and triggered from a child widget via callback
- Both the counter value and the selected theme persist across app restarts using `shared_preferences`

## Tech stack

- Flutter / Dart
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) for local key-value persistence

## Getting started

```bash
flutter pub get
flutter run
```

Requires a working Flutter SDK installation. See the [official Flutter docs](https://docs.flutter.dev/get-started/install) if you don't have one set up.

## Project structure

Single-file app for simplicity (`lib/main.dart`):

- `MyApp` (`StatefulWidget`) — holds theme state (`_themeMode`), exposes `_toggleTheme()`, loads/saves the theme via `shared_preferences`
- `MyHomePage` (`StatefulWidget`) — holds counter state (`_counter`), exposes increment/decrement/reset, loads/saves the counter via `shared_preferences`
- Theme changes are triggered in `MyHomePage` and propagated up to `MyApp` through a `VoidCallback` passed via constructor

## Why this exists

This is a learning exercise, not a production app — the goal was to get hands-on with core Flutter concepts (state lifting, `initState`, async persistence) before moving on to more complex projects. Code and architecture decisions were worked through manually as part of that learning process.

## License

MIT
