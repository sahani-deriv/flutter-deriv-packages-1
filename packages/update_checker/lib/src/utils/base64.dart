import 'dart:convert';

/// Returns decoded base64 [input] as a string.
String decodeBase64(String input) {
  if (!isBase64(input)) {
    return input;
  }

  return utf8.fuse(base64).decode(input);
}

/// Returns true if the [input] is a base64 encoded string.
bool isBase64(String input) {
  final RegExp base64Matcher = RegExp(
    r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$',
  );

  return base64Matcher.hasMatch(input);
}
