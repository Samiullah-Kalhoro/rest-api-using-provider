import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<void> login(String email, String password) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/users?username=$password&email=$email'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        final user = User.fromJson(data.first);
        if (user.password == password) {
          _currentUser = user;
          notifyListeners();
        } else {
          throw Exception('Invalid credentials');
        }
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to log in');
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
