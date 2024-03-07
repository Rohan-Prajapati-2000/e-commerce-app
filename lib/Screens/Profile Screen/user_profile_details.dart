import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htg_smart_watch/main.dart';

class UserProfileDetails extends StatelessWidget {
  final User user;

  const UserProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 15,
              child: FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Text('No data found');
                  }
              
                  // Data found, display user details
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return ListView(
                    children: [
                      ListTile(title: Text('Full Name: ${data['fullName']}')),
                      ListTile(title: Text('Address Line 1: ${data['addressLine1']}')),
                      ListTile(title: Text('Address Line 2: ${data['addressLine2']}')),
                      ListTile(title: Text('State: ${data['state']}')),
                      ListTile(title: Text('Pin Code: ${data['pinCode']}')),
                      ListTile(title: Text('Email: ${data['emailId']}')),
                      ListTile(title: Text('Contact Number: ${data['contactNumber']}')),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
                child: Text("Sign Out")),

            SizedBox(height: 60)
          ],
        ),
      ),
    );
  }
}
