import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Db{

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(data, context) async {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocRef = users.doc(userID);
    await userDocRef
      .set(data)
      .then((value) => print("User Added"))
      .catchError((error){
        showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text("Sign up Failed"),
                content: Text(error.toString()),
              );
            }
        );
      });
  }

  Future<void> addProperty(data) async{
    final userID = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDocRef = users.doc(userID);
    CollectionReference additionalCollection = userDocRef.collection('properties');

    QuerySnapshot querySnapshot = await additionalCollection.get();
    int propertyCount = querySnapshot.docs.length;


    String newPropertyName = 'property${propertyCount + 1}';

    await additionalCollection
        .doc(newPropertyName)
        .set(data)
        .then((value) => print("Data Added to Additional Collection"))
        .catchError((error) {
              print("Failed");
      });
  }

}