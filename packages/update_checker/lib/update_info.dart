/// Represents information regarding Updates
/// buildNumber represents minimum build required
/// changelog shows what's new in latest buildnumber
/// url can be empty. When available should be used instead of App/Play Store
/// isOptional is Used to represent is Update is Optional or Mandatory 
class UpdateInfo {
  final int buildNumber;
  final String changelog;
  final String url;
  final bool isOptional;

  UpdateInfo({
    this.buildNumber,
    this.changelog,
    this.url,
    this.isOptional,
  });
}
