import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'example_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

/// MyApp
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Example',
        home: ExamplePage(),
      );
}
