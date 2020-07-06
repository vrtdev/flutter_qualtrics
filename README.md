# Qualtrics

Bridges the [Qualtrics SDK](https://api.qualtrics.com/docs/mobile-ios-intercept-sdk) to Flutter.

# Installation

```yaml
dependencies:
  qualtrics: ^0.0.1
```
```shell script
flutter pub get
```
```dart
import 'package:qualtrics/qualtrics.dart';
```

## Getting Started

Qualtrics SDKs setup reference : https://api.qualtrics.com/docs/mobile-ios-intercept-sdk

```dart
final qualitrics = Qualtrics(brandId: "", zoneId: "", interceptId: "");

bool result = await qualtrics.evaluateTargetingLogic();
bool result = await qualtrics.display();
await qualtrics.hide();
await qualtrics.displayTarget("someTarget");

await qualtrics.registerViewVisit("someViewName");

await qualtrics.resetTimer();
await qualtrics.resetViewCounter();
```