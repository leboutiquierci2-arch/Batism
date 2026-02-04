import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool isAuthenticated = false;

  void signIn() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      isAuthenticated = true;
      notifyListeners();
    }
  }
}
