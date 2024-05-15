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
      _isLogin = '_isLogin',
      _isSignUp = '_isSignUp',
      _userId = '_userId',
      _userToken = '_userToken',
      _userEmail = '_userEmail',
      _userFullName = '_userFullName',
      _userDOB = '_userDOB',
      _userPhone = '_userPhone',
      _deviceId = '_deviceId',
      _userState = '_userState',
      _userCountry = '_userCountry',
      _userPinCode = '_userPinCode',
      _userAddress = '_userAddress',
      _userCity = '_userCity';

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

  Future<bool> setStudentId(String userId) =>
      _prefs!.setString(_userId, userId);

  String? getStudentId() => _prefs!.getString(_userId);

  Future<bool> setUserToken(String userToken) =>
      _prefs!.setString(_userToken, userToken);

  String? getUserToken() => _prefs!.getString(_userToken);

  Future<bool> setUserDob(String userDOB) =>
      _prefs!.setString(_userDOB, userDOB);

  String? getUserDob() => _prefs!.getString(_userDOB);

  Future<bool> setUserPhone(String userPhone) =>
      _prefs!.setString(_userPhone, userPhone);

  Future<bool> removeUserPhone() => _prefs!.remove(_userPhone);

  String? getUserPhone() => _prefs!.getString(_userPhone);

  ///------

  Future<bool> setUserAddress(String userAddress) =>
      _prefs!.setString(_userAddress, userAddress);

  String? getUserAddress() => _prefs!.getString(_userAddress);

  Future<bool> setUserCity(String city) => _prefs!.setString(_userCity, city);

  String? getUserCity() => _prefs!.getString(_userCity);

  Future<bool> setDeviceId(String deviceId) =>
      _prefs!.setString(_deviceId, deviceId);

  String? getDeviceId() => _prefs!.getString(_deviceId);

  Future<bool> setState(String state) => _prefs!.setString(_userState, state);

  String? getUserState() => _prefs!.getString(_userState);

  Future<bool> setCountry(String country) =>
      _prefs!.setString(_userCountry, country);

  String? getUserCountry() => _prefs!.getString(_userCountry);

  Future<bool> setUserPinCode(String pinCode) =>
      _prefs!.setString(_userPinCode, pinCode);

  String? getUserPinCode() => _prefs!.getString(_userPinCode);

  Future reset() async {
    Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    prefs.clear();
  }
}
