import 'package:equatable/equatable.dart';
import 'package:update_checker/update_info.dart';

abstract class UpdateCheckState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateNotAvailable extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateNotAvailable';
  }
}

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

class UpdateCancelled extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateCheckState(UpdateCancelled)';
  }
}

class UpdateSeen extends UpdateCheckState {
  @override
  String toString() {
    return 'UpdateCheckState(UpdateSeen)';
  }
}
