import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:update_checker/src/repositories/firebase_base.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';
import '../utils/utils.dart';

part 'update_event.dart';

part 'update_state.dart';

/// UpdateBloc is responsible for fetching the update availability from the
/// Firebase Database and emit the correct state.
class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  /// UpdateBloc needs `FirebaseDatabaseRepository` in order to fetch the update
  /// availability from the Firebase Database and `PackageInfoRepository` to
  /// check the app version with the update to determine the update availability
  UpdateBloc({
    required this.fireBaseRepository,
    this.packageInfoRepository = const PackageInfoRepository(),
  }) : super(UpdateInitialState()) {
    on<UpdateFetchEvent>(
      (UpdateFetchEvent event, Emitter<UpdateState> emit) async =>
          _handleUpdateFetchEvent(event, emit),
    );
  }

  /// Firebase database repository for fetching the update information.
  final FireBaseBase fireBaseRepository;

  /// Package info repository for fetching the app build number.
  final PackageInfoRepository packageInfoRepository;

  Future<void> _handleUpdateFetchEvent(
      UpdateFetchEvent event, Emitter<UpdateState> emit) async {
    if (state is! UpdateInProgressState) {
      emit(UpdateInProgressState());
      final UpdateInfo? info =
          (fireBaseRepository is FirebaseRemoteConfigRepository)
              ? await _getUpdateInfoFromRemoteConfig()
              : await _getUpdateInfoFromDataBase();
      if (info != null) {
        emit(UpdateAvailableState(info));
      } else {
        emit(UpdateNotAvailableState());
      }
    }
  }

  Future<UpdateInfo?> _getUpdateInfoFromRemoteConfig() async {
    final String rawData = await fireBaseRepository.fetchUpdateData();

    // checks if failed to fetch data from Firebase Database and return
    if (rawData.isEmpty) {
      return null;
    }

    // checks if failed to get app build number and return
    final num appBuildNumber = await packageInfoRepository.getAppBuildNumber();
    if (appBuildNumber <= 0) {
      return null;
    }

    final Map<String, dynamic> mapValues = json.decode(rawData);

    final num minVersion =
        mapValues[Platform.isAndroid ? 'android' : 'ios']['version']['minimum'];
    final num latestVersion =
        mapValues[Platform.isAndroid ? 'android' : 'ios']['version']['latest'];

    final bool isMandatory = appBuildNumber < minVersion;

    final bool isOptional =
        appBuildNumber < latestVersion && appBuildNumber > minVersion;

    // checks if no update available and return
    if (!isMandatory && !isOptional) {
      return null;
    }

    return _createUpdate(
      mapValues[Platform.isAndroid ? 'android' : 'ios'],
      isOptional,
      isOptional ? latestVersion : minVersion,
    );
  }

  Future<UpdateInfo?> _getUpdateInfoFromDataBase() async {
    final dynamic rawData = await fireBaseRepository.fetchUpdateData();

    // checks if failed to fetch data from Firebase Database and return
    if (rawData == null) {
      return null;
    }

    // checks if failed to get app build number and return
    final num appBuildNumber = await packageInfoRepository.getAppBuildNumber();
    if (appBuildNumber <= 0) {
      return null;
    }

    final num optionalBuildNumber = rawData['optional']['buildnumber'];
    final num mandatoryBuildNumber = rawData['mandatory']['buildnumber'];
    final bool isMandatory = appBuildNumber < mandatoryBuildNumber;
    final bool isOptional = appBuildNumber < optionalBuildNumber &&
        appBuildNumber >= mandatoryBuildNumber;

    // checks if no update available and return
    if (!isMandatory && !isOptional) {
      return null;
    }

    return _createUpdate(
      rawData[isOptional ? 'optional' : 'mandatory'],
      isOptional,
      isOptional ? optionalBuildNumber : mandatoryBuildNumber,
    );
  }

  UpdateInfo _createUpdate(
    dynamic rawUpdateInfo,
    bool isOptional,
    num buildNumber,
  ) {
    final String? rawChangelogs = rawUpdateInfo['changelogs']?.toString();
    final Map<String, dynamic>? changelogs = rawChangelogs != null
        ? json.decode(
            rawChangelogs.toString().substring(1, rawChangelogs.length - 1),
          )
        : null;

    return UpdateInfo(
      buildNumber: buildNumber,
      url: rawUpdateInfo['url'],
      changelog: decodeBase64(rawUpdateInfo['changelog'] ?? ''),
      changelogs: changelogs,
      isOptional: isOptional,
    );
  }
}
