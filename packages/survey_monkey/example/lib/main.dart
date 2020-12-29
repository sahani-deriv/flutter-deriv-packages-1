import 'dart:developer' as logger;
import 'package:flutter/material.dart';

import 'package:survey_monkey/survey_monkey.dart';
import 'package:survey_monkey/survey_monkey_response.dart';

void main() {
  runApp(MyApp());
}

/// App's main page
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: OutlinedButton(
              child: const Text(
                'Start the survey',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                final SurveyMonkeyResponse response =
                    await SurveyMonkey.loadSurveyMonkey(
                        surveyHash: 'YOUR_HASH');
                // Use values as follows;
                final SurveyCompletionStatus status = response.status;
                final String respondentId = response.respondentId;
                final String error = response.error;
                logger.log('status: $status');
                logger.log('respondentId: $respondentId');
                logger.log('error: $error');
              },
            ),
          ),
        ),
      );
}
