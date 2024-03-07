import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Screens/Profile%20Screen/empty_user.dart';
import 'package:htg_smart_watch/Screens/Profile%20Screen/user_not_empty.dart';
import 'package:htg_smart_watch/Screens/Profile%20Screen/user_profile_details.dart';

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
      ),
      body: (FirebaseAuth.instance.currentUser != null) ? UserProfileDetails(user: _user!): EmptyUser()
    );
  }
}
