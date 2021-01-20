import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:update_checker/update_checker.dart';

/// UpdateBlocPage
class UpdateBlocPage extends StatefulWidget {
  @override
  _UpdateBlocPageState createState() => _UpdateBlocPageState();
}

class _UpdateBlocPageState extends State<UpdateBlocPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('UpdateBloc'),
        ),
        body: BlocProvider<UpdateBloc>(
          create: (_) => UpdateBloc()..add(UpdateFetchEvent()),
          child: BlocBuilder<UpdateBloc, UpdateState>(
            builder: (_, UpdateState state) => Center(
              child: Text('${state.runtimeType}'),
            ),
          ),
        ),
      );
}
