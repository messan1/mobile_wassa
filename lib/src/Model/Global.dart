import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ucolis/src/Model/User.dart';
import 'package:ucolis/src/services/dbservice.dart';

/// Static global state. Immutable services that do not care about build context.
class Global {
  // App Data
  static final String title = 'Wassa wassa';

  // Services
  static final FirebaseAnalytics analytics = FirebaseAnalytics();

  // Data Models
  static final Map models = {
    User: (data) => User.fromMap(data),
  };

  // Firestore References for Writes
  //static final Collection<Topic> topicsRef = Collection<Topic>(path: 'topics');
  static final UserData<User> reportRef =
      UserData<User>(collection: 'user_data');
}
