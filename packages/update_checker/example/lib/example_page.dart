import 'package:flutter/material.dart';
import 'package:update_checker/update_checker.dart';

/// ExamplePage
class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  UpdateState state;

  @override
  Widget build(BuildContext context) => Scaffold(
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
