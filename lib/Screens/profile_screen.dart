import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Screens/Profile%20Screen/empty_user.dart';
import 'package:htg_smart_watch/Screens/Profile%20Screen/user_profile_details.dart';
import 'package:htg_smart_watch/Screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Profile"),
        elevation: 2,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Screen()));
          },
              icon: Icon(Icons.logout))
        ],
      ),
      body: (FirebaseAuth.instance.currentUser != null) ? UserProfileDetails(user: _user!): EmptyUser()
    );
  }
}
