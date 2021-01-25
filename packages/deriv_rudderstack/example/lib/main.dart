import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:deriv_rudderstack/deriv_rudderstack.dart';

void main() {
  runApp(MyApp());
}

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _enabled;

  @override
  void initState() {
    super.initState();

    DerivRudderstack().disable();
    _enabled = false;
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Rudderstack example app'),
          ),
          body: Column(
            children: <Widget>[
              _enableController(),
              const Divider(),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(16),
                children: _eventsList(),
              )
            ],
          ),
        ),
      );

  List<Widget> _eventsList() => <Widget>[
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'Identify',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.teal[100],
          ),
          onTap: () {
            DerivRudderstack()
                .setContext(token: 'xxx-xxxx-xxxx-xxxxx-xxxx-test');
            DerivRudderstack().identify(userId: '998');
          },
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'Track',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.blue[100],
          ),
          onTap: () => DerivRudderstack().track(
              eventName: 'Application Opened',
              properties: <String, dynamic>{
                'entry1': 'test1',
                'entry2': 'test2'
              }),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'Screen',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.orange[100],
          ),
          onTap: () => DerivRudderstack().screen(
              screenName: 'main',
              properties: <String, dynamic>{
                'entry1': 'test1',
                'entry2': 'test2'
              }),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'group',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.indigo[100],
          ),
          onTap: () => DerivRudderstack().group(
              groupId: 'Group-id-test',
              traits: <String, dynamic>{'entry1': 'test1', 'entry2': 'test2'}),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'alias',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.purple[100],
          ),
          onTap: () => DerivRudderstack().alias(alias: 'Alias-test'),
        ),
        InkWell(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: const Center(
                child: Text(
              'reset',
              style: TextStyle(fontSize: 18),
            )),
            color: Colors.deepOrange[100],
          ),
          onTap: () => DerivRudderstack().reset(),
        ),
      ];

  Widget _enableController() => SwitchListTile(
        title: const Text('Enable RudderStack'),
        value: _enabled,
        onChanged: (bool newValue) {
          setState(() => _enabled = newValue);

          if (_enabled) {
            DerivRudderstack().enable();
          } else {
            DerivRudderstack().disable();
          }
        },
      );
}
