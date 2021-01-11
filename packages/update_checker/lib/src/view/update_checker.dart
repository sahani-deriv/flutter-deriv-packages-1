import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../update_checker.dart';

/// UpdateChecker
class UpdateChecker extends StatefulWidget {
  /// UpdateChecker
  const UpdateChecker({
    this.child,
    this.onAvailable,
    this.onNotAvailable,
    this.onStateChange,
  });

  /// The [child] that UpdateChecker widget will wrap it.
  final Widget child;

  /// [onAvailable] will be called when there is an update available.
  final Function(UpdateInfo) onAvailable;

  /// [onNotAvailable] will be called when there no update available.
  final Function onNotAvailable;

  /// [onStateChange] will be called when there is a change in the state.
  final Function(UpdateState) onStateChange;

  @override
  _UpdateCheckerState createState() => _UpdateCheckerState();
}

class _UpdateCheckerState extends State<UpdateChecker> {
  UpdateBloc _updateBloc;
  StreamSubscription<UpdateState> _updateBlocSubscription;

  @override
  void initState() {
    super.initState();
    _setListener();
  }

  void _setListener() {
    _updateBloc = context.read<UpdateBloc>();
    _updateBlocSubscription =
        _updateBloc.startWith(_updateBloc.state).listen((UpdateState state) {
      widget.onStateChange?.call(state);
      if (state is UpdateNotAvailableState) {
        widget.onNotAvailable?.call();
      } else if (state is UpdateAvailableState) {
        widget.onAvailable?.call(state.updateInfo);
      }
    });
  }

  @override
  Widget build(_) => widget.child ?? const SizedBox.shrink();

  @override
  void dispose() {
    _updateBlocSubscription?.cancel();
    super.dispose();
  }
}
