import 'package:flutter/material.dart';

class SessionStore with ChangeNotifier {
  dynamic _user;

  dynamic get user => _user;

  void setUser(dynamic user) {
    // _user['id'] = user['id'];
    // _user['username'] = user['username'];
    // _user['email'] = user['email'];
    // _user['phone'] = user['phone'];
    // _user['date_of_birth'] = user['date_of_birth'];
    // _user['address'] = user['address'];
    // _user['thumbnail'] = user['thumbnail'];
    // _user['gender'] = user['gender'];
    // _user['institution_id'] = user['institution_id'];

    print(_user);
    notifyListeners();
  }
  
}
