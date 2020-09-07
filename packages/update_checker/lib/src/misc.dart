import 'dart:convert';

/// Decodes [str] if it is a Base64,
/// otherwise returns the original value of [str].
String decodeBase64(String str) {
  final Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final RegExp _base64 = RegExp(
      r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');

  if (_base64.hasMatch(str)) {
    return stringToBase64.decode(str);
  }

  return str;
}
