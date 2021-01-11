import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

/// FirebaseDatabaseRepository
class FirebaseDatabaseRepository {
  /// FirebaseDatabaseRepository
  const FirebaseDatabaseRepository();

  /// Will fetch the update information from the database.
  Future<dynamic> fetchUpdateData() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance
        .reference()
        .child('build')
        .child(Platform.operatingSystem);
    return (await dbRef.once()).value;
  }
}
