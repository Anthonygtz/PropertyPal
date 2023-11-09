import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key});

  @override
  State<AccountScreen> createState() => _AccountState();
}

class _AccountState extends State<AccountScreen> {
  late User? _user;
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: _user != null
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildListTile("Change Password", () {
            showChangePasswordDialog(context, _authService);
          }),
          buildListTile("Delete Account", () {
            showDeleteConfirmationDialog(context, _authService);
          }),
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildListTile(String title, VoidCallback onTap) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          onTap: onTap,
          trailing: Icon(Icons.chevron_right),
        ),
        Divider(
          color: Colors.grey.shade500,
          height: 0,
          thickness: 1,
        ),
      ],
    );
  }

  void showChangePasswordDialog(BuildContext context, AuthService authService) {
    TextEditingController newPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                String newPassword = newPasswordController.text;
                await authService.changePassword(context, newPassword);
                Navigator.of(context).pop();
              },
              child: Text("Change Password"),
            ),
          ],
        );
      },
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Account"),
          content: Text("Are you sure you want to delete your account?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await authService.deleteAccount(context);
              },
              child: Text("Delete Account"),
            ),
          ],
        );
      },
    );
  }
}