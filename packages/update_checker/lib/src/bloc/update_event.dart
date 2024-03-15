part of 'update_bloc.dart';

/// Abstract class for update event
abstract class UpdateEvent {}

/// Start fetching update information from the server.
class UpdateFetchEvent extends UpdateEvent {
  @override
  String toString() => 'UpdateEvent(UpdateFetchEvent)';
}
