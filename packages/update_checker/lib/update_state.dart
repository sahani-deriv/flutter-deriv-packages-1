import 'package:equatable/equatable.dart';
import 'package:update_checker/update_info.dart';

/// Abstract State class for being used in [UpdateCheckBloc]
abstract class UpdateCheckState extends Equatable {
  @override
  List<Object> get props => [];
}

/// State to represent when there is no Update Available
class UpdateNotAvailable extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateNotAvailable';
  }
}

/// State to represent when an Update is Available
class UpdateAvailable extends UpdateCheckState {
  final UpdateInfo updateInfo;

  UpdateAvailable(this.updateInfo);

  @override
  List<Object> get props => [updateInfo];

  @override
  String toString() {
    return 'UpdateAvailable_${updateInfo.buildNumber}_${updateInfo.isOptional}';
  }
}

/// State to represent when Update Check was cancelled
class UpdateCancelled extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateCheckState(UpdateCancelled)';
  }
}

/// State to represent when Update alert was seen by user
class UpdateSeen extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateCheckState(UpdateSeen)';
  }
}
