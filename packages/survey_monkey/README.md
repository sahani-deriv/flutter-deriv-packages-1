# survey_monkey

SurveyMonkey plugin is used to display a survey provided by SurveyMonkey services. The plugin is a
wrapper over SurveyMonkey SDKs for both Android and iOS. In order to successfully load a survey,
`SurveyHash` is needed which can be obtained from SurveyMonkey.com with a PRO account.


## Installation

In order to use the plugin, add the following to `pubspec.yaml` file. Refer to this [link](https://flutter.dev/docs/development/packages-and-plugins/using-packages) for more details.

```yaml
survey_monkey:
       git:
         url: git@github.com:regentmarkets/flutter-deriv-packages.git
         path: packages/survey_monkey
         ref: master
```

Import `survey_monkey.dart` and `survey_monkey_response.dart` if you want to use the response data;

```dart
import 'package:survey_monkey/survey_monkey.dart';
import 'package:survey_monkey/survey_monkey_response.dart';
```

## Usage

The plugin can be used by simply making a call to `SurveyMonkey.loadSurveyMonkey` as follows;

```dart
 final SurveyMonkeyResponse response =
                    await SurveyMonkey.loadSurveyMonkey(surveyHash: 'YOUR_SURVEY_HASH');

 // Use values as follows;
 final String status = response.status;
 final String respondentId = response.respondentId;
 final String error = response.error;
```

## Compatibility

- Android: the plugin requires a minimum API level of 21 and Kotlin 1.4.0.
- iOS: The minimum iOS version supported is 12.


## Issues with SurveyMonkey SDKs

- Media upload is not working.
- Internet connectivity change is not handled well at the SDK.
- Loading time to open a survey can be very long.

For the entire list of open issues refer to the following links;

- [iOS](https://github.com/SurveyMonkey/surveymonkey-ios-sdk/issues)
- [Android](https://github.com/SurveyMonkey/surveymonkey-android-sdk/issues)