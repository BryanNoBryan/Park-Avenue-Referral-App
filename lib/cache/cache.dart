
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {

  static const String doctorName = "doctorName";
  static const String doctorPhone = "doctorPhone";
  static const String doctorEmail = "doctorEmail";

  //initialzation of SharedPreferencesWithCache
  static final Future<SharedPreferencesWithCache> _prefsWithCache = SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{doctorName, doctorPhone, doctorEmail}, // Allowed keys
      ),
    );

  // Checking the stored cache value to set the initial field
  static Future<String?> getValue(String key) async {
    try {
      SharedPreferencesWithCache prefsWithCache = await _prefsWithCache;
      return  prefsWithCache.getString(key); //nullable
    } catch (e) {
      return null;
    }
  }

  // Updating the stored cache value
  static Future<bool> setValue(String key, String value) async {
    try {
      SharedPreferencesWithCache prefsWithCache = await _prefsWithCache;
      await prefsWithCache.setString(key, value);
      return true;
    } catch (e) {
      return false; //failed somehow
    }
  }
}