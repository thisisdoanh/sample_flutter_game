import 'package:injectable/injectable.dart';
import 'package:template_bloc/data/pref/pref_store.dart';
import 'package:template_bloc/shared/utils/share_preference_utils.dart';

@Singleton(as: PrefStore)
class PrefStoreHelper extends PrefStore {
  PrefStoreHelper(this._prefs);

  final PreferenceUtils _prefs;

  static const _accessTokenKey = 'access_token';
  static const _userIdKey = 'user_id';
  static const _darkModeKey = 'is_dark_mode';
  static const _languageKey = 'language_code';
  static const _firstLaunchDoneKey = 'first_launch_done';
  static const _balanceBallBestScoreKey = 'balance_ball_best_score';
  static const _catchTheButtonBestScoreKey = 'catch_the_button_best_score';

  // Auth
  @override
  String? getAccessToken() => _prefs.getString(_accessTokenKey);

  @override
  Future<bool> saveAccessToken(String token) => _prefs.setString(_accessTokenKey, token);

  @override
  Future<bool> clearAccessToken() => _prefs.remove(_accessTokenKey);

  // User
  @override
  String? getUserId() => _prefs.getString(_userIdKey);

  @override
  Future<bool> saveUserId(String id) => _prefs.setString(_userIdKey, id);

  @override
  Future<bool> clearUserId() => _prefs.remove(_userIdKey);

  // Settings
  @override
  bool isDarkMode() => _prefs.getBool(_darkModeKey) ?? false;

  @override
  Future<bool> setDarkMode(bool value) => _prefs.setBool(_darkModeKey, value);

  @override
  String getLanguage() => _prefs.getString(_languageKey) ?? 'en';

  @override
  Future<bool> setLanguage(String langCode) => _prefs.setString(_languageKey, langCode);

  // Onboarding
  @override
  bool isFirstLaunch() => !(_prefs.getBool(_firstLaunchDoneKey) ?? false);

  @override
  Future<bool> setFirstLaunchDone() => _prefs.setBool(_firstLaunchDoneKey, true);

  // Games
  @override
  int getBalanceBallBestScore() => _prefs.getInt(_balanceBallBestScoreKey) ?? 0;

  @override
  Future<bool> saveBalanceBallBestScore(int score) => _prefs.setInt(_balanceBallBestScoreKey, score);

  @override
  int getCatchTheButtonBestScore() => _prefs.getInt(_catchTheButtonBestScoreKey) ?? 0;

  @override
  Future<bool> saveCatchTheButtonBestScore(int score) =>
      _prefs.setInt(_catchTheButtonBestScoreKey, score);
}
