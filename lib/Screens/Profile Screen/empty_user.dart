import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Screens/create_new_account.dart';
import 'package:htg_smart_watch/Screens/login_screen.dart';

class EmptyUser extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You haven't login yet! Please Login"),
            SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login_Screen()));
                },
                child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewAccount()));
                },
                child: Text("Create New Account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

}