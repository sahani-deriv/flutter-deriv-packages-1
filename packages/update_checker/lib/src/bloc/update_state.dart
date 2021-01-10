part of 'update_bloc.dart';

/// Abstract class for update state
abstract class UpdateState extends Equatable {
  @override
  List<UpdateInfo> get props => <UpdateInfo>[];
}

/// State to represent when an update is available.
class UpdateAvailable extends UpdateState {
  /// State to represent when an update is available.
  UpdateAvailable(
    this.updateInfo,
  );

  /// Information for the update.
  final UpdateInfo updateInfo;

  @override
  List<UpdateInfo> get props => <UpdateInfo>[updateInfo];

  @override
  String toString() => 'UpdateAvailable: $updateInfo';
}

/// State to represent when there is no update available.
class UpdateNotAvailable extends UpdateState {
  @override
  String toString() => 'UpdateNotAvailable';
}

/// State to represent when the update check is still in progress.
class UpdateInProgress extends UpdateState {
  @override
  String toString() => 'UpdateInProgress';
}
