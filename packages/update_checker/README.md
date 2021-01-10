# update_checker

A helper package that will check and retrieve update information from the server for the given package.

---

## Getting Started

The plugin uses `Firebase Database` which needs to be updated manually or through automation whenever there is a new release.

### Data structure

```yaml
build:
  android:
    optional:
      buildnumber: 24
      changelog: 'RFAyUCB2ZXJ....' // Base64
      url: 'https://alternative.app.link'
    mandatory:
      buildnumber: 18
      changelog: 'RFAyUCB2ZXJ....' // Base64
      url: 'https://alternative.app.link'
```


### Update types

`Optional`: Can be dismissed and continue using old version.

`Mandatory`: Will block the usage of app unless user updates.

---

## Installation

1. Open `pubspec.yaml`, and add the `update_checker` dependency:

```yaml
update_checker:
  git:
    url: git@github.com:regentmarkets/flutter-deriv-packages.git
    path: packages/update_checker
    ref: master
```

2. Run `flutter pub get` in the terminal, or click **Packages get** in IntelliJ or Android Studio.

**Refer to this [link](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) for more details.*

---

## Example

Todo