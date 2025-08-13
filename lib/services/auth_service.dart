import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userEmailKey = 'userEmail';
  static const String _onboardingCompletedKey = 'onboardingCompleted';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _prefs.getBool(_isLoggedInKey) ?? false;
  bool get onboardingCompleted =>
      _prefs.getBool(_onboardingCompletedKey) ?? false;
  String? get userEmail => _prefs.getString(_userEmailKey);

  Future<void> login(String email) async {
    await _prefs.setBool(_isLoggedInKey, true);
    await _prefs.setString(_userEmailKey, email);
  }

  Future<void> logout() async {
    await _prefs.setBool(_isLoggedInKey, false);
    await _prefs.remove(_userEmailKey);
  }

  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingCompletedKey, true);
  }

  Future<void> signUp(String email, String password) async {
    await _prefs.setBool(_isLoggedInKey, true);
    await _prefs.setString(_userEmailKey, email);
  }

  Future<bool> verifyEmail(String email) async {
    // Mock verification - always returns true
    return true;
  }

  Future<bool> resetPassword(String email) async {
    // Mock reset - always returns true
    return true;
  }
}
