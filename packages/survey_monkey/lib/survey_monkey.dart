import 'dart:async';
import 'dart:convert';
import 'dart:developer' as logger;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'survey_monkey_response.dart';

/// SurveyMonkey plugin handles showing a survey for users to interact with and
/// returns success/failure result after the survey is submitted.
class SurveyMonkey {
  static const MethodChannel _channel = MethodChannel('survey_monkey');

  /// Call this function to load and display a survey. In order to achieve that
  /// a [surveyHash] is required which is a unique hash for each survey and can
  /// be obtained from `SurveyMonkey.com` dashboard.
  ///
  /// Upon completing and submitting the survey, this function returns a map of
  /// the following:
  ///
  /// 1- completionStatus, the value will be `completed` if survey completed
  /// without any issues. Otherwise, the status is `incomplete`.
  /// 2- respondentId, which is the id of the user who completed the survey.
  /// 3- error represents the error message if the survey was not completed
  /// successfully.
  static Future<SurveyMonkeyResponse> loadSurveyMonkey({
    @required String surveyHash,
  }) async {
    try {
      final String response =
          await _channel.invokeMethod<dynamic>('start', <String, dynamic>{
        'surveyHash': surveyHash,
      });

      final Map<String, dynamic> results = jsonDecode(response);
      final Map<String, dynamic> data = jsonDecode(results['response']);

      final String completionStatus = data['completion_status'];
      final String error = data['error'];
      final String respondentId = data['respondent_id'];

      final SurveyMonkeyResponse surveyMonkeyResponse =
          SurveyMonkeyResponse(completionStatus, respondentId, error);

      return surveyMonkeyResponse;
    } on PlatformException catch (e) {
      logger.log('${(SurveyMonkey).toString()}: ${e.message}');
    }

    return Future<SurveyMonkeyResponse>.value();
  }
}
