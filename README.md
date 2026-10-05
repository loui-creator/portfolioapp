# Lab Portfolio App

A multi-screen Flutter app that serves as the master compilation shell for future lab activities.

## Run it

```
flutter create --project-name portfolio_app .   # only if you need a fresh platform scaffold (android/ios/web folders)
flutter pub get
flutter run
```

If you unzip this into an empty folder, run `flutter create .` first so the
`android/`, `ios/`, and `web/` platform folders get generated, then `flutter pub get`.

## How each requirement is met

| Requirement | Where |
|---|---|
| Project setup | `pubspec.yaml` (adds `provider: ^6.1.2`) |
| Multi-screen navigation | `main.dart` named routes: `/`, `/activity1`, `/activity2`, `/settings` |
| StatelessWidget (static components) | `widgets/custom_button.dart`, `widgets/custom_card.dart`, `HomeScreen` |
| StatefulWidget (local state) | `screens/activity1_screen.dart` (counter), `screens/activity2_screen.dart` (notes list) |
| Responsive layout | `Column`, `Row`, `Expanded`, `GridView.count` with a `LayoutBuilder` that adapts column count to screen width (see `home_screen.dart`) |
| Global state management | `models/app_state.dart` (`ChangeNotifier`) wrapped by `ChangeNotifierProvider` in `main.dart`; `SettingsScreen` edits `isDarkMode` and `userName`; `HomeScreen` and the app bar toggle read them via `Consumer`/`context.watch`, updating instantly everywhere |

## Extending it for future labs

Each new lab activity should become its own `screens/activityN_screen.dart`
StatefulWidget (or Stateless if it has no interaction), get a route entry
in `main.dart`, and a new `ActivityCard` added to the `GridView` in
`home_screen.dart`. Anything that needs to be shared across activities
(e.g. a running score, user progress) should be added as a field + method
on `AppState`, the same pattern used for `isDarkMode` and `userName`.
