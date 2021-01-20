import 'package:flutter/material.dart';
import 'package:update_checker/update_checker.dart';

/// UpdateCheckerPage
class UpdateCheckerPage extends StatefulWidget {
  @override
  _UpdateCheckerPageState createState() => _UpdateCheckerPageState();
}

class _UpdateCheckerPageState extends State<UpdateCheckerPage> {
  UpdateState state;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('UpdateChecker'),
        ),
        body: UpdateCheckerProvider(
          UpdateChecker(
            onStateChange: (UpdateState state) => setState(() {
              this.state = state;
            }),
            child: Center(child: Text('${state.runtimeType}')),
          ),
        ),
      );
}
