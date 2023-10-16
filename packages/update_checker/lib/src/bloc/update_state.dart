part of 'update_bloc.dart';

/// Abstract class for update state
abstract class UpdateState extends Equatable {
  @override
  List<UpdateInfo> get props => <UpdateInfo>[];
}

/// State to represent when the update check hasn't begun yet.
class UpdateInitialState extends UpdateState {
  @override
  String toString() => 'UpdateInitialState';
}

/// State to represent when the update check is still in progress.
class UpdateInProgressState extends UpdateState {
  @override
  String toString() => 'UpdateInProgressState';
}

/// State to represent when an update is available.
class UpdateAvailableState extends UpdateState {
  /// State to represent when an update is available.
  UpdateAvailableState(
    this.updateInfo,
  );

  /// Information for the update.
  final UpdateInfo updateInfo;

  @override
  List<UpdateInfo> get props => <UpdateInfo>[updateInfo];

  @override
  String toString() => 'UpdateAvailableState: $updateInfo';
}

/// State to represent when there is no update available.
class UpdateNotAvailableState extends UpdateState {
  @override
  String toString() => 'UpdateNotAvailableState';
}
