/// Survey monkey response.
class SurveyMonkeyResponse {
  /// Holds survey monkey response data.
  SurveyMonkeyResponse(
    this.status,
    this.respondentId,
    this.error,
  );

  /// The status of completion for the survey, it can be `completed` or
  /// `incomplete`
  final String status;

  /// The user id who completed the survey. Empty if the status is `incomplete`
  final String respondentId;

  /// The error description. Empty if no errors found.
  final String error;
}
