import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uru_bank/model/account_model.dart';

import 'package:uru_bank/model/user_model.dart';
import '../firebase_options.dart';

class FirebaseService {
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<List<UrubankUser>?> getUsers() async =>
      _getUsers().then((users) => users);

  Future<UrubankUser?> getUserById(String id) async {
    return _getUsers().then((users) => _filterBy(users, 'id', id));
  }

  Future<UrubankUser?> getUserByCpf(String cpf) async {
    return _getUsers().then((users) => _filterBy(users, 'cpf', cpf));
  }

  Future<UrubankUser?> getUserByEmail(String email) async {
    return _getUsers().then((users) => _filterBy(users, 'email', email));
  }

  Future<UrubankUser?> getUserByAccountNumber(String accountNumber) async {
    return _getUsers()
        .then((users) => _filterBy(users, 'account', accountNumber));
  }

  UrubankUser? _filterBy(List<UrubankUser> users, String filter, String value) {
    List<UrubankUser> filteredUsers = [];

    if (filter == "account") {
      filteredUsers = users
          .where((user) => user.toJson()[filter]["number"] == value)
          .toList();
    } else {
      filteredUsers =
          users.where((user) => user.toJson()[filter] == value).toList();
    }

    if (filteredUsers.isNotEmpty) {
      return filteredUsers.elementAt(0);
    }

    return null;
  }

  Future<List<UrubankUser>> _getUsers() async {
    List<UrubankUser> users = [];

    FirebaseDatabase dataBase = FirebaseDatabase.instance;
    DatabaseReference ref = dataBase.ref("users");
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      Map<String, dynamic> data = jsonDecode(jsonEncode(snapshot.value));

      for (final id in data.keys) {
        users.add(UrubankUser.fromJson(data[id]));
      }
    }
    return users;
  }

  Future<UrubankUser?> updateUserData(Map<String, dynamic> user) async {
    if (user['id'] != null) {
      FirebaseDatabase dataBase = FirebaseDatabase.instance;
      DatabaseReference ref = dataBase.ref("users").child(user['id']);

      await ref.update(user);
      final updatedUserData = await FirebaseService().getUserByCpf(user['cpf']);
      return updatedUserData;
    }

    return null;
  }

  Future<UrubankUser?> setUserData(Map<String, dynamic> user) async {
    FirebaseDatabase dataBase = FirebaseDatabase.instance;
    DatabaseReference ref = dataBase.ref("users").child(user['id']);

    await ref.set(user);
    final updatedUserData = await FirebaseService().getUserByCpf(user['cpf']);
    return updatedUserData;
  }
}
