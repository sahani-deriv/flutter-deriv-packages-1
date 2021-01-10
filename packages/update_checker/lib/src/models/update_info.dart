/// Represents information regarding Update.
class UpdateInfo {
  /// Represents information regarding Update.
  UpdateInfo({
    this.isOptional,
    this.buildNumber,
    this.changelog,
    this.changelogs,
    this.url,
  });

  /// [isOptional] determinate if the update is optional or not.
  final bool isOptional;

  /// [buildNumber] represents the minimum build required.
  final int buildNumber;

  /// [changelog] contains changelog information for the latest release.
  final String changelog;

  /// [changelogs] contains changelog information for different languages.
  /// ```
  /// {
  ///    'en': '- Feature 1\n- Feature 2',
  ///    'es': '- característica 1\n- característica 2',
  /// }
  /// ```
  final Map<String, String> changelogs;

  /// [url] is alternative url for updating the app, can be empty.
  final String url;

  @override
  String toString() => 'UpdateInfo('
      'isOptional: $isOptional, '
      'buildNumber: $buildNumber, '
      'url: $url'
      ')';
}
