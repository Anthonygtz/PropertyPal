import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/add_property_form.dart';
import 'login_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Login()),
    );

    setState(() {
      isLogoutLoading = false;
    });
  }

  final userID = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPropertyForm()));
        } ,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text(
          "All Properties",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: HouseWidget(userId: userID)
    );
  }
}

class HouseWidget extends StatelessWidget {
  HouseWidget({
    super.key,
    required this.userId
  });

  final String? userId;

  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream = FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists){
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading");
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Houses(
          data: data, heading: 'Home',
        );
      },
    );
  }
}

class Houses extends StatelessWidget {
  const Houses({
    super.key, required this.data, required this.heading,
  });

  final Map data;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Change this to the number of containers you want
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          height: 210,
          color: Colors.blue.shade200,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                    child: CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 8, right: 8),
                        child: Row(
                          children: [
                            Icon(Icons.home_filled, color: Colors.black54),
                            SizedBox(width: 8),
                            Text("${data['propertyName']}",
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${data['propertyAddress']}",
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12, top: 35),
                        child: Transform.rotate(
                          angle: -90 * 3.1415926535 / 180,
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              heading,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 356,
                        height: 102,
                        color: Colors.white,
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${data['propertyName']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.key, color: Colors.grey),
                                        Text(
                                          "  10/01/2023 - 10/31/2023",
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Text("${data['rent']}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0, top: 7),
                                    child: Row(
                                      children: [
                                        Text('Tenant Balance',
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
