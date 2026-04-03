import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'bn';
  bool _isLoggedIn = false;
  String _userName = '';
  String _userPhone = '';
  String _userEmail = '';
  List<String> _bookmarks = [];
  final List<String> _notifications = [];

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userPhone => _userPhone;
  String get userEmail => _userEmail;
  List<String> get bookmarks => _bookmarks;
  List<String> get notifications => _notifications;

  AppProvider() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _language = prefs.getString('language') ?? 'bn';
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _userName = prefs.getString('userName') ?? '';
    _userPhone = prefs.getString('userPhone') ?? '';
    _userEmail = prefs.getString('userEmail') ?? '';
    _bookmarks = prefs.getStringList('bookmarks') ?? [];
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    _language = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    notifyListeners();
  }

  Future<void> login(String name, String phone, {String email = ''}) async {
    _isLoggedIn = true;
    _userName = name;
    _userPhone = phone;
    _userEmail = email;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', name);
    await prefs.setString('userPhone', phone);
    await prefs.setString('userEmail', email);
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _userName = '';
    _userPhone = '';
    _userEmail = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userName');
    await prefs.remove('userPhone');
    await prefs.remove('userEmail');
    notifyListeners();
  }

  Future<void> toggleBookmark(String serviceId) async {
    if (_bookmarks.contains(serviceId)) {
      _bookmarks.remove(serviceId);
    } else {
      _bookmarks.add(serviceId);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('bookmarks', _bookmarks);
    notifyListeners();
  }

  void addNotification(String notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  void clearNotifications() {
    _notifications.clear();
    notifyListeners();
  }
}
