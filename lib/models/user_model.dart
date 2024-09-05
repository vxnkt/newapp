import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String email;
  final String phone_no;
  final String uid;

  const User({
    required this.email,
    required this.name,
    required this.phone_no,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone_no": phone_no,
        "uid": uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        name: snapshot['name'],
        email: snapshot['email'],
        phone_no: snapshot['phone_no'],
        uid: snapshot['uid']);
  }
}
