import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  String companyName = '';
  String address = '';
  String contact = '';
  String currency = 'FCFA';

  void save() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      notifyListeners();
    }
  }
}
