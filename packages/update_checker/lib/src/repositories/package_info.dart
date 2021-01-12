import 'package:package_info/package_info.dart';

/// PackageInfoRepository
class PackageInfoRepository {
  /// PackageInfoRepository
  const PackageInfoRepository();

  /// Will return the running app build number.
  Future<int> getAppBuildNumber() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return int.tryParse(packageInfo.buildNumber) ?? -1;
    } on Exception catch (_) {
      return -1;
    }
  }
}
