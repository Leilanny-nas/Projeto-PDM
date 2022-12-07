import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uru_bank/model/user_model.dart';

class UserData with ChangeNotifier {
  UrubankUser? _user;

  Future<void> listen() async {
    if (_user != null) {
      FirebaseDatabase database = FirebaseDatabase.instance;

      database.ref("users").child(_user!.id.toString()).onValue.listen((event) {
        Map<String, dynamic>? data =
            jsonDecode(jsonEncode(event.snapshot.value));

        if (data != null) {
          _user = UrubankUser.fromJson(data);
          notifyListeners();
        }
      });
    }
  }

  UrubankUser? get user => _user;

  void clearState() => _user = null;

  void setUser(UrubankUser? user) {
    _user = user;

    notifyListeners();
  }
}
