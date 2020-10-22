# analytics
***
This package is used for collecting and sending analytical information from the app to "Firebase" and "Segment".

## How to use
***
##### 1. Enabling analytics.
```
Analytics.instance.init(deviceToken: "<FIREBASE_TOKEN_HERE>");
```
##### 2. Logging to 'Segment' in different scenarios.

// when app is  opened.
```
Analytics.instance.logAppOpened();
```
//when app is in background.
```
Analytics.instance.logAppBackgrounded();
```
//when app is crashed.
```
Analytics.instance.logAppCrashed();
```

##### 3. Sending information about current screen.
```
Analytics.instance.setCurrentScreen(screenName: "<CURRENT_SCREEN_NAME_HERE>");
```
##### 4. Setting routes/screens which need to be whitelisted for analytics.
```
Analytics.instance.setIgnoredRoutes([
      'IGNORED_SCREEN_NAME_1',
      'IGNORED_SCREEN_NAME_2',
      '.....................',
      'IGNORED_SCREEN_NAME_N'
    ]);
```
##### 5. Sending information during user login.
```
Analytics.instance.logLoginEvent("<USER_ID_HERE");
```
##### 6. Sending information during user logout.
```
Analytics.instance.logLogoutEvent();
```
##### 7. Sending information about important events to "Firebase".
```
Analytics.instance.logToFirebase(
      name: "<EVENT_NAME_HERE>",
      params: <String, dynamic>{'PARAM_1': 'VALUE_1',
                                'PARAM_1': 'VALUE_1',
                                '.......': '.......',
                                'PARAM_N': 'VALUE_N'},
    );
```