import 'package:equatable/equatable.dart';

abstract class UpdateCheckEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UpdateCheckStart extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckStart)';
  }
}

class UpdateCheckInProgress extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckInProgress)';
  }
}

class UpdateCheckCancel extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckCancel)';
  }
}

class UpdateCheckMarkSeen extends UpdateCheckEvent {
  @override
  String toString() {
    return 'UpdateCheckEvent(UpdateCheckMarkSeen)';
  }
}
