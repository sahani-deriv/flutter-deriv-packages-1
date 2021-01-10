import 'package:flutter/material.dart';
import 'package:update_checker/update_checker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// UpdateCheckerProvider
class UpdateCheckerProvider extends StatelessWidget {
  /// UpdateCheckerProvider
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
