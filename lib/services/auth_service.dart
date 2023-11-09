import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propertypal/screens/dashboard.dart';
import 'package:propertypal/screens/login_screens.dart';

import 'db.dart';

class AuthService{
  var db = Db();
  createUser(data, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Sign up Failed"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  login(data, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text("Login Error"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance.collection('users').doc(userID);


    User user = FirebaseAuth.instance.currentUser!;
    try {
      await user.delete();
      await documentReference.delete();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Account Deletion Failed"),
            content: Text(e.toString()),
          );
        },
      );
    }
  }

  Future<void> changePassword(BuildContext context, String newPassword) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Change the password in Firebase Authentication
        await user.updatePassword(newPassword);

        // Update the password in Firestore for the current user
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'password': newPassword})
            .then((_) {
          // Show a success dialog
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Password Changed"),
                content: Text("Your password has been changed successfully."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }).catchError((error) {
          // Show a dialog if there's an error updating Firestore
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Password Change Failed"),
                content: Text(error.toString()),
              );
            },
          );
        });
      } catch (e) {
        // Show a dialog if there's an error changing the password in Firebase Authentication
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Password Change Failed"),
              content: Text(e.toString()),
            );
          },
        );
      }
    }
  }


}