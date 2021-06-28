import 'package:package_info/package_info.dart';

/// PackageInfo repository will help to fetch the running app's build number.
class PackageInfoRepository {
  /// Initializes the PackageInfo repository
  const PackageInfoRepository();

  /// Returns the running app's build number.
  Future<int> getAppBuildNumber() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return int.tryParse(packageInfo.buildNumber) ?? -1;
    } on Exception catch (_) {
      return -1;
    }
  }
}
