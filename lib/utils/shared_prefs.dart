import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  factory SharedPrefs() {
    if (_prefs == null) {
      throw Exception('Call SharedPrefs.init() before accessing it');
    }
    return _singleton;
  }

  SharedPrefs._internal();

  static void init(SharedPreferences sharedPreferences) =>
      _prefs ??= sharedPreferences;

  static final SharedPrefs _singleton = SharedPrefs._internal();

  static SharedPreferences? _prefs;

  static const String _tokenKey = '_tokenKey',
      _userEmail = '_userEmail',
      _onBoardingCompleted = '_onBoardingCompleted',
      _isLogin = '_isLogin',
      _verificationStatus = '_verificationStatus',
      _isSignUp = '_isSignUp',
      _userId = '_userId',
      _parentId = '_parentId',
      _userFullName = '_userFullName',
      _studentMomName = '_studentMomName',
      _studentCount = '_studentCount',
      _userDOB = '_userDOB',
      _userPhone = '_userPhone',
      _deviceId = '_deviceId',
      _oneDeviceAdded = '_oneDeviceAdded',
      _kLanguageCodeKey = 'languageCode',
      _kStudentKey = 'StudentKey',
      _isDeviceAdd = '_isDeviceAdd';

  ///* User SignIn/SignUp Detail*/
  Future<bool> setIsLogin([bool isLogin = false]) =>
      _prefs!.setBool(_isLogin, isLogin);

  bool isLogin() => _prefs!.getBool(_isLogin) ?? false;

  Future<bool> setIsSignUp([bool isSignUp = false]) =>
      _prefs!.setBool(_isSignUp, isSignUp);

  bool isSignUp() => _prefs!.getBool(_isSignUp) ?? false;

  Future<bool> setTokenKey(String token) => _prefs!.setString(_tokenKey, token);

  Future<bool> removeTokenKey() => _prefs!.remove(_tokenKey);

  String? getTokenKey() => _prefs!.getString(_tokenKey);

  Future<bool> setUserEmail(String email) =>
      _prefs!.setString(_userEmail, email);

  Future<bool> removeUserEmail() => _prefs!.remove(_userEmail);

  String? getUserEmail() => _prefs!.getString(_userEmail);

  Future<bool> setUserFullName(String userFullName) =>
      _prefs!.setString(_userFullName, userFullName);

  Future<bool> removeUserFullName() => _prefs!.remove(_userFullName);

  String? getUserFullName() => _prefs!.getString(_userFullName);

  Future<bool> setStudentId(String userId) => _prefs!.setString(_userId, userId);

  String? getStudentId() => _prefs!.getString(_userId);

  Future<bool> setParentId(String parentId) =>
      _prefs!.setString(_parentId, parentId);

  String? getParentId() => _prefs!.getString(_parentId);

  Future<bool> setStudentMomName(String studentMomName) =>
      _prefs!.setString(_studentMomName, studentMomName);

  String? getStudentMomName() => _prefs!.getString(_studentMomName);

  Future<bool> setStudentCount(String studentCount) =>
      _prefs!.setString(_studentCount, studentCount);

  String? getStudentMomCount() => _prefs!.getString(_studentCount);

  Future<bool> setUserDob(String userDOB) =>
      _prefs!.setString(_userDOB, userDOB);

  String? getUserDob() => _prefs!.getString(_userDOB);

  Future<bool> setUserPhone(String userPhone) =>
      _prefs!.setString(_userPhone, userPhone);

  Future<bool> removeUserPhone() => _prefs!.remove(_userPhone);

  String? getUserPhone() => _prefs!.getString(_userPhone);

  ///------

  Future<bool> setDeviceId(String deviceId) =>
      _prefs!.setString(_deviceId, deviceId);

  String? getDeviceId() => _prefs!.getString(_deviceId);

  ///---set/get locale code
  Locale getLocale() {
    final languageCode = _prefs?.getString(_kLanguageCodeKey) ?? 'en';
    return Locale(languageCode, '');
  }

  Future<void> setLocale(String languageCode) async {
    await _prefs?.setString(_kLanguageCodeKey, languageCode);
  }





  // Save the JSON array as a string in shared preferences
   Future<void> saveStudents(List<Map<String, dynamic>> students) async {
    final prefs = await SharedPreferences.getInstance();
    final studentsJson = jsonEncode(students);
    await prefs.setString(_kStudentKey, studentsJson);
  }

  // Retrieve the JSON array string from shared preferences
   Future<List<Map<String, dynamic>>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final studentsJson = prefs.getString(_kStudentKey);

    if (studentsJson != null) {
      final students = jsonDecode(studentsJson) as List;
      return students.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }





  Future reset() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    prefs.clear();
  }
}
