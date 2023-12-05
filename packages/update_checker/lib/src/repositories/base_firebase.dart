/// Firebase base repository will help to fetch the update information from
/// the firebase system.
abstract class BaseFireBase {
  /// Fetches the update information from the firebase system.
  Future<dynamic> fetchUpdateData();
}
