import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/resources/dio/custom_intercepter.dart';

class CommonProvider extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final dio = Dio();
  late DocumentReference<Map<String, dynamic>> userDB;
  late DocumentReference<Map<String, dynamic>> characterDB;
  bool isLoading = false;

  CommonProvider() {
    dio.interceptors.add(CustomIntercepter());
  }

  void onLoad() {
    isLoading = true;
    notifyListeners();
  }

  void offLoad() {
    isLoading = false;
    notifyListeners();
  }

  getUserReference() async {
    userDB = (await db
            .collection('users')
            .where('uid', isEqualTo: auth.currentUser!.uid)
            .get())
        .docs
        .first
        .reference;
  }

  selectCharacterDB(String characterName) async {
    characterDB = (await userDB
            .collection('characters')
            .where('characterName', isEqualTo: characterName)
            .get())
        .docs
        .first
        .reference;
  }
}
