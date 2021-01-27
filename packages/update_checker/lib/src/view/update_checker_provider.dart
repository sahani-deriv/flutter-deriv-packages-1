import 'package:flutter/material.dart';
import 'package:update_checker/update_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// UpdateCheckerProvider is a higher-order widget to help providing the
/// UpdateBloc without dealing with bloc itself.
class UpdateCheckerProvider extends StatelessWidget {
  /// Provides the UpdateBloc for it's child widget.
  const UpdateCheckerProvider(
    this.child,
  );

  /// The [child] that update bloc will be provided to.
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider<UpdateBloc>(
        create: (_) => UpdateBloc(),
        child: child,
      );
}
