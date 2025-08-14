// api_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class ApiService {
  static String get _baseUrl {
    if (kIsWeb) {
      // running in Chrome for flutter web
      return 'http://localhost:5000/auth';
    }
    // Order matters: only touch Platform.* when not on web
    if (Platform.isAndroid) return 'http://10.0.2.2:5000/auth'; // Android emulator bridge
    if (Platform.isIOS) return 'http://localhost:5000/auth';     // iOS simulator
    // For real devices on the same Wi-Fi: use your PC's LAN IP
    return 'http://YOUR_PC_LAN_IP:5000/auth';
  }

  static Map<String, String> get _json => {'Content-Type': 'application/json'};

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final uri = Uri.parse('$_baseUrl/register');
    final res = await http
        .post(uri, headers: _json, body: json.encode({'name': name, 'email': email, 'password': password}))
        .timeout(const Duration(seconds: 15));
    return json.decode(res.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/login');
    final res = await http
        .post(uri, headers: _json, body: json.encode({'email': email, 'password': password}))
        .timeout(const Duration(seconds: 15));
    return json.decode(res.body) as Map<String, dynamic>;
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
