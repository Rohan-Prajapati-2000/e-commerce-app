import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileDetails extends StatelessWidget {
  final User user;

  const UserProfileDetails({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: Center(
        child: Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15)
          ),
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
                    // return Container(
                    //   color: Colors.white,
                    //   child: ListView(
                    //     children: [
                    //       ListTile(title: Text('Full Name: ${data['fullName']}')),
                    //       ListTile(title: Text('Address Line 1: ${data['addressLine1']}')),
                    //       ListTile(title: Text('Address Line 2: ${data['addressLine2']}')),
                    //       ListTile(title: Text('State: ${data['state']}')),
                    //       ListTile(title: Text('Pin Code: ${data['pinCode']}')),
                    //       ListTile(title: Text('Email: ${data['emailId']}')),
                    //       ListTile(title: Text('Contact Number: ${data['contactNumber']}')),
                    //     ],
                    //   ),
                    // );

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        shadowColor: Colors.blue,
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${data['fullName']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                                  Text('${data['addressLine1']}', style: TextStyle(fontSize: 17)),
                                  Text('${data['addressLine2']}', style: TextStyle(fontSize: 17)),
                                  Text('${data['state']}', style: TextStyle(fontSize: 17)),
                                  Text('${data['pinCode']}', style: TextStyle(fontSize: 17)),
                                  Text('${data['emailId']}', style: TextStyle(fontSize: 17)),
                                  Text('${data['contactNumber']}', style: TextStyle(fontSize: 17)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
