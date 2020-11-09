# update_checker

update_checker plugin checks for the availability of new updates for the app using it.
The plugin uses Firebase Database which needs to be updated manually or through automation whenever there is a new release. Firebase Database is used to fetch data which looks like the following:

```
build:
    android:
        optional:
            buildnumer: 24
            changelog: 'RFAyUCB2ZXJ....' // Base64
            url: 'https://alternative.app.link'
        mandatory:
            buildnumber: 18
            changelog: 'RFAyUCB2ZXJ....' // Base64
            url: 'https://alternative.app.link'
```

### Types of Udpates

There can be an optional update or mandatory update.
For optional updates, users can dismiss the alert and continue using old version.
But for mandatory updates, we should block the usage of app unless user updates.

### Fields

* buildnumber - this is an integer to represent the minimum buildnumber required
* changelog - this is base64 encoded changelog
* url - an optional URL to redirect user to, instead of App Store / Play Store

### Buildnumber

Current installed buildnumber for the application is obtained using `PackageInfo`
This buildnumer is picked from `pubspec.yaml`. E.g.

```
name: otc_cashier
description: DP2P is a peer-to-peer payments on deriv.com
version: 1.1.3+8
```

`8` from version will be our buildnumber.
buildnumber can also be set manually as in case of circleci builds 
E.g. `flutter build --build-number $CIRCLE_BUILD_NUM`

## How to Use

```
class UpdateCheckWidget extends UpdateCheck {
  final Widget child;

  UpdateCheckWidget({this.child}) : super(child: child);

  @override
  void showOptionalAlert(BuildContext context, UpdateInfo update) {
    // Show optional alert
  }

  @override
  void showMandatoryPage(BuildContext context, UpdateInfo update) {
    // Show blocking UI
  }
}
```

This package provides [UpdateCheck](./lib/widgets/update_check.dart) widget which can be extended.
There are two methods `showOptionalAlert` and `showMandatoryPage`
Before using the Widget, add the Bloc

```
providers: [
    BlocProvider<UpdateCheckBloc>(
        create: (BuildContext context) => UpdateCheckBloc(),
    ),
]
```

Use `UpdateCheckStart` event to start checking for Update.
Use `UpdateCheckCancel` event to cancel the last request to check update

```
BlocProvider.of<UpdateCheckBloc>(context).add(UpdateCheckStart());
BlocProvider.of<UpdateCheckBloc>(context).add(UpdateCheckCancel());
```