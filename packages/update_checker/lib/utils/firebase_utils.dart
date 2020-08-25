import 'dart:io';
import 'dart:developer' as dev;
import 'package:firebase_database/firebase_database.dart';
import 'package:update_checker/update_info.dart';
import 'package:update_checker/utils/misc.dart';
import 'package:package_info/package_info.dart';

class FirebaseUtils {
/*
  Firebase Database looks like as follows
          build:
            android:
              option:
                buildnumer: 24
                changelog: 'RFAyUCB2ZXJ....' // Base64
                url: 'https://alternative.app.link'
              mandatory:
                buildnumber: 18
                changelog: 'RFAyUCB2ZXJ....' // Base64
                url: 'https://alternative.app.link'
  */
  Future<UpdateInfo> fetchBuildNumbers() async {
    try {
      String platform = Platform.operatingSystem;
      DatabaseReference dbRef =
          FirebaseDatabase.instance.reference().child('build').child(platform);

      final buildRemoteInfo = (await dbRef.once()).value;
      final buildNumberOptional = buildRemoteInfo['optional']['buildnumber'];
      final buildNumberMandatory = buildRemoteInfo['mandatory']['buildnumber'];

      // Get BuildNumber currently running
      final packageInfo = await PackageInfo.fromPlatform();
      final buildNumberCurrent = int.tryParse(packageInfo.buildNumber) ?? -1;

      if (buildNumberCurrent > 0 && buildNumberCurrent < buildNumberMandatory) {
        // Current build is lower than Minimum Required Build
        final String buildAppUrl = buildRemoteInfo['mandatory']['url'] ?? null;
        final String changelog =
            decodeBase64(buildRemoteInfo['mandatory']['changelog'] ?? '');

        return UpdateInfo(
          buildNumber: buildNumberMandatory,
          url: buildAppUrl,
          changelog: changelog,
          isOptional: false,
        );
      } else if (buildNumberCurrent > 0 &&
          buildNumberCurrent < buildNumberOptional) {
        // Optional new build is available
        final String buildAppUrl = buildRemoteInfo['optional']['url'] ?? null;
        final String changelog =
            decodeBase64(buildRemoteInfo['optional']['changelog'] ?? '');

        return UpdateInfo(
          buildNumber: buildNumberOptional,
          url: buildAppUrl,
          changelog: changelog,
          isOptional: true,
        );
      }
    } catch (err) {
      // Something went wrong
      dev.log(err.toString());
    }
    return null;
  }
}
