# Deriv Env

`deriv_env` is a Flutter package that provides a way to retrieve and manage environment variables. It is built on top of the `base_env.dart` inteface, which provides an interface for interacting with the environment.

## Installation

To use Deriv_env, add it to your dependencies in the `pubspec.yaml` file:

```yaml
dependencies:
  deriv_env: latest_version
```

Then run `flutter pub get` to install the package.

## Usage

To use `deriv_env` in your Flutter app, import the `deriv_env.dart` file:

```dart
import 'package:deriv_env/deriv_env.dart';
```

The package provides a `singleton instance` of the `Env` class, which can be accessed by calling `Env()`.

### Checking if an environment variable is initialized

You can check if the environment variable is initialized using the `isInitialized` getter.

```dart
bool isInitialized = Env().isInitialized;
```

### Loading environment variables

Before using any environment variables, you need to load them from a file. The `load` method loads the variables from a file with the specified filename (default is `.env`).

```dart
await Env().load();
```

The load method expects the file to contain key-value pairs separated by an equals sign (`=`) and each pair separated by a newline character (`\n`). Blank lines and comments (lines starting with a `#`) are ignored.

#### Sample `.env` file

```env
# This is a sample .env file.
# It contains environment variables used by the app.

# Basic environment variables.
STRING_VAR = hello world
INT_VAR = 123
DOUBLE_VAR = 3.14
BOOL_VAR = true

# Other environment variables.
API_KEY = 1234567890
API_URL = https://api.deriv.com
```

### Getting all environment variables

You can get all the loaded environment variables using the `entries` getter.

```dart
Map<String, dynamic> allVariables = Env().entries;
```

### Getting environment variables

You can retrieve an environment variable using the `get` method. The method takes a key and an optional default value. If the key is not found in the loaded environment variables, the default value will be returned.

```dart
String apiKey = Env().get<String>('API_KEY', defaultValue: 'API_KEY_VALUE');
```

The `get` method returns a value of the type specified in the type parameter. Supported types are `String`, `int`, `double` and `bool`.