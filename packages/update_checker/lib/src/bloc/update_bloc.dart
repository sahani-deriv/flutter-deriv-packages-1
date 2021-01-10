import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:package_info/package_info.dart';

import '../models/models.dart';
import '../utils/utils.dart';

part 'update_event.dart';
part 'update_state.dart';

/// UpdateBloc is responsible for fetching the update availability from the
/// Firebase Database and emit the correct state.
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  /// UpdateBloc is responsible for fetching the update availability from the
  /// Firebase Database and emit the correct state.
  UpdateBloc() : super(UpdateInProgress()) {
    add(UpdateFetch());
  }

  @override
  Stream<UpdateState> mapEventToState(UpdateEvent event) async* {
    if (event is UpdateFetch) {
      final UpdateInfo info = await _getUpdateInfo();
      yield info == null ? UpdateNotAvailable() : UpdateAvailable(info);
    }
  }

  Future<UpdateInfo> _getUpdateInfo() async {
    final int appBuildNumber = await _getAppBuildNumber();
    if (appBuildNumber <= 0) {
      return null;
    } // failed to get app build number

    final dynamic rawData = await _fetchData();
    if (rawData == null) {
      return null;
    } // failed to fetch data from Firebase Database

    final int optionalBuildNumber = rawData['optional']['buildnumber'];
    final int mandatoryBuildNumber = rawData['mandatory']['buildnumber'];
    final bool isMandatory = appBuildNumber < mandatoryBuildNumber;
    final bool isOptional = appBuildNumber < optionalBuildNumber;
    if (!isMandatory && !isOptional) {
      return null;
    } // no update available

    return _createUpdate(
      rawData[isOptional ? 'optional' : 'mandatory'],
      isOptional,
      isOptional ? optionalBuildNumber : mandatoryBuildNumber,
    );
  }

  Future<int> _getAppBuildNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return int.tryParse(packageInfo.buildNumber) ?? -1;
  }

  Future<dynamic> _fetchData() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('build')
        .child(Platform.operatingSystem);
    return (await dbRef.once()).value;
  }

  UpdateInfo _createUpdate(
    dynamic rawUpdateInfo,
    bool isOptional,
    int buildNumber,
  ) =>
      UpdateInfo(
        buildNumber: buildNumber,
        url: rawUpdateInfo['url'] ?? null,
        changelog: decodeBase64(rawUpdateInfo['changelog'] ?? ''),
        changelogs: rawUpdateInfo['changelogs'] ?? null,
        isOptional: isOptional,
      );
}
