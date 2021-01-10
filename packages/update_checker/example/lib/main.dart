import 'package:flutter/material.dart';

import 'example_page.dart';

void main() => runApp(MyApp());

/// MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(title: 'Example', home: ExamplePage());
}
