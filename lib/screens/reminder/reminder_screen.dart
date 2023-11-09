import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:propertypal/screens/reminder/reminder_details.dart';
import '../login_screens.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  var isLogoutLoading = false;



  // Function to handle navigation to the next page
  void navigateToRemindersDetails() {
    // Replace with your navigation logic
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RemindersDetails()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reminders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: Colors.black), // Set the indicator color
              ),// Tab label color
              tabs: [
                Tab(
                  child: Text(
                    "by Property",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    "by Status",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    // padding: const EdgeInsets.only(top: 16),
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
                              ),
                              child: const Align(
                                alignment: Alignment.centerLeft, // Left-align the text
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16), // Adjust the left padding
                                  child: Text(
                                    "544 Winchester - House",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Add more widgets to the list if needed

                      // Add a styled ListTile for navigation to another page
                      ListTile(
                        contentPadding: EdgeInsets.all(16), // Padding for ListTile content
                        title: Text("Outstanding/Late Rent Payment"),
                        trailing: Icon(Icons.navigate_next), // Add a ">" icon to the right
                        tileColor: Colors.grey, // Background color for the ListTile
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                Text(
                                  " \$1,600.00, 5 Days Late, James Richard",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: navigateToRemindersDetails,
                      )
                    ],
                  ),
                  const Center(
                    child: Text("Content for Status Tab"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

