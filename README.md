# Add-to-app sample

This project demonstrates usage of `FlutterPlugin` combined with flutter plugins and
platform-implementations.

## Branches

1. `main` – branch there app works as expected.
2. `plugins_crash` – error with plugins occurs. Pay attention to latest commit – it confirms message,
that default `FlutterFragment` does not register plugins.

## Preparations

1. Run `flutter pub get` inside `flutter_module` to generate android-related code.
2. Open project (root directory) in Android studio.
3. Run `gradle sync` and then `Run` on android device (tested on Emulator with API-level 35)
