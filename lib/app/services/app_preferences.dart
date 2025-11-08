import 'package:hi_net/app/supported_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

abstract class AbstractAppPreferences {
  Future<bool> setSkippedOnBoarding();
  Future<bool> resetOnBoarding();

  Future<void> setToken(String token);
  Future<void> setRefreshToken(String token);
  Future<void> setIdToken(String token);
  Future<void> setUserId(String userId);
  Future<void> setTheme(bool isDark);

  Future<void> setLanguage(SupportedLocales language);

  Future<void> clearAllTokens();

  Future<void> reload();

  Future<void> saveUserData({
    String? name,
    String? phone,
    String? email,
    String? image,
  });

  Future<void> deleteUserData();

  Future<void> saveLocationData({
    required double latitude,
    required double longitude,
    required String address,
  });

  Future<({
    double? latitude,
    double? longitude,
    String? address,
  })> getLocationData();

  bool get isLocationSelected;

  Future<
      ({
        String? name,
        String? phone,
        String? email,
        String? image,
      })> getUserData();

  String? get token;

  String? get refreshToken;

  String? get idToken;

  String? get userId;

  bool get isSkippedOnBoarding;

  bool get isUserRegistered;

  SupportedLocales? get language;

  bool get isDark;
}

class AppPreferences implements AbstractAppPreferences {
  final SharedPreferences _sharedPreferences;

  const AppPreferences(this._sharedPreferences);

  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  Future<bool> resetOnBoarding() async =>
      await _sharedPreferences.setBool(Constants.skippedOnBoarding, false);

  @override
  Future<bool> setSkippedOnBoarding() async =>
      await _sharedPreferences.setBool(Constants.skippedOnBoarding, true);

  @override
  bool get isSkippedOnBoarding =>
      _sharedPreferences.getBool(Constants.skippedOnBoarding) ?? false;

  @override
  Future<void> setToken(String token) async =>
      await _sharedPreferences.setString(Constants.accessToken, token);

  @override
  Future<void> setRefreshToken(String token) async =>
      await _sharedPreferences.setString(Constants.refreshToken, token);

  @override
  bool get isUserRegistered =>
      _sharedPreferences.getString(Constants.accessToken) != null;

  @override
  Future<void> clearAllTokens() async {
    await _sharedPreferences.remove(Constants.accessToken);
    await _sharedPreferences.remove(Constants.refreshToken);
    await _sharedPreferences.remove(Constants.idToken);
    await _sharedPreferences.remove(Constants.userId);
  }

  @override
  String? get token => _sharedPreferences.getString(Constants.accessToken);

  @override
  String? get refreshToken =>
      _sharedPreferences.getString(Constants.refreshToken);

  @override
  String? get idToken => _sharedPreferences.getString(Constants.idToken);

  @override
  Future<void> setIdToken(String token) async =>
      _sharedPreferences.setString(Constants.idToken, token);

  @override
  SupportedLocales? get language {
    String? lan = _sharedPreferences.getString(Constants.language);
    if (lan == null) return null;
    return SupportedLocales.fromString(lan);
  }

  @override
  Future<void> setLanguage(SupportedLocales language) async =>
      _sharedPreferences.setString(Constants.language, language.name);

  @override
  Future<void> setUserId(String userId) async =>
      _sharedPreferences.setString(Constants.userId, userId);

  @override
  String? get userId => _sharedPreferences.getString(Constants.userId);

  @override
  bool get isDark => _sharedPreferences.getBool(Constants.isDark) ?? false;

  @override
  Future<void> setTheme(bool isDark) async =>
      _sharedPreferences.setBool(Constants.isDark, isDark);

  @override
  Future<void> reload() async => await _sharedPreferences.reload();

  @override
  Future<void> saveUserData({
    String? name,
    String? phone,
    String? email,
    String? image,
  }) async {
    if (name != null) {
      await _sharedPreferences.setString('user-name', name);
    }

    if (phone != null) {
      await _sharedPreferences.setString('user-phone', phone);
    }

    if (email != null) {
      await _sharedPreferences.setString('user-email', email);
    }

    if (image != null) {
      await _sharedPreferences.setString('user-image', image);
    }
  }

  @override
  Future<void> deleteUserData() async {
    await _sharedPreferences.remove('user-name');
    await _sharedPreferences.remove('user-phone');
    await _sharedPreferences.remove('user-email');
    await _sharedPreferences.remove('user-image');
  }

  @override
  Future<
      ({
        String? name,
        String? phone,
        String? email,
        String? image,
      })> getUserData() async {
    final name = _sharedPreferences.getString('user-name');
    final phone = _sharedPreferences.getString('user-phone');
    final email = _sharedPreferences.getString('user-email');
    final image = _sharedPreferences.getString('user-image');

    return (
      name: name,
      phone: phone,
      email: email,
      image: image,
    );
  }

  @override
  Future<void> saveLocationData({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    await _sharedPreferences.setDouble('user-latitude', latitude);
    await _sharedPreferences.setDouble('user-longitude', longitude);
    await _sharedPreferences.setString('user-address', address);
  }

  @override
  Future<({
    double? latitude,
    double? longitude,
    String? address,
  })> getLocationData() async {
    final latitude = _sharedPreferences.getDouble('user-latitude');
    final longitude = _sharedPreferences.getDouble('user-longitude');
    final address = _sharedPreferences.getString('user-address');

    return (
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  @override
  bool get isLocationSelected {
    final latitude = _sharedPreferences.getDouble('user-latitude');
    final longitude = _sharedPreferences.getDouble('user-longitude');
    final address = _sharedPreferences.getString('user-address');
    
    // Return true if all location data is available
    return latitude != null && longitude != null && address != null && address.isNotEmpty;
  }
}
