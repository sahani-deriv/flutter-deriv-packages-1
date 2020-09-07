/// Represents information regarding Updates
class UpdateInfo {
  /// buildNumber represents minimum build required
  final int buildNumber;

  /// changelog shows what's new in latest buildnumber
  final String changelog;

  /// url can be empty. When available should be used instead of App/Play Store
  final String url;

  /// isOptional is Used to represent is Update is Optional or Mandatory
  final bool isOptional;

  UpdateInfo({
    this.buildNumber,
    this.changelog,
    this.url,
    this.isOptional,
  });
}
