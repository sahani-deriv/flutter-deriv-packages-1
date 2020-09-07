import 'package:equatable/equatable.dart';

/// Abstract Event class for being used in [UpdateCheckBloc]
abstract class UpdateCheckEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Start checking the if Update is available or not
class UpdateCheckStart extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckStart)';
  }
}

/// Update availability is being checked
class UpdateCheckInProgress extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckInProgress)';
  }
}

/// Cancel the request to check for update availability
class UpdateCheckCancel extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckCancel)';
  }
}

/// Mark Update check as seen by user
class UpdateCheckMarkSeen extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckMarkSeen)';
  }
}
