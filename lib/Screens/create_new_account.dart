import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Utils/input_text_field.dart';
import 'package:htg_smart_watch/Utils/utils.dart';
import 'package:htg_smart_watch/main.dart';

class CreateNewAccount extends StatefulWidget {
  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  var nameController = TextEditingController();
  var address1Controller = TextEditingController();
  var address2Controller = TextEditingController();
  var stateController = TextEditingController();
  var pinCodeController = TextEditingController();
  var emailController = TextEditingController();
  var contactNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();

  void _registerUser() async {
    if (nameController.text.trim() == "" ||
        address1Controller.text.trim() == "" ||
        address2Controller.text.trim() == "" ||
        stateController.text.trim() == "" ||
        pinCodeController.text.trim() == "" ||
        emailController.text.trim() == "" ||
        contactNumberController.text.trim() == "" ||
        passwordController.text.trim() == "" ||
        confirmPassController.text.trim() == ""){
      Utils().toastMessage("Please fill in all the feilds");
      return;
    } else
    if (passwordController.text.trim() != confirmPassController.text.trim()) {
      Utils().toastMessage("Password doesn't match");
      return;
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailController.text.trim(),
            password: passwordController.text.trim());

        //Saving additional details to firestore
        await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
          'fullName': nameController.text.trim(),
          'addressLine1': address1Controller.text.trim(),
          'addressLine2': address2Controller.text.trim(),
          'state': stateController.text.trim(),
          'pinCode': pinCodeController.text.trim(),
          'emailId': emailController.text.trim(),
          'contactNumber': contactNumberController.text.trim(),
        });

        // Navigation after successfully registration
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));

      }on FirebaseAuthException catch (error){
        Utils().toastMessage("$error");
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 2,
        title: Text("Create New Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please fill the all details",
                        style: TextStyle(color: Colors.black, fontSize: 20)),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        hintText: "FullName"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: address1Controller,
                        keyboardType: TextInputType.text,
                        hintText: "Address Line 1"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: address2Controller,
                        keyboardType: TextInputType.text,
                        hintText: "Address Line 2"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: stateController,
                        keyboardType: TextInputType.text,
                        hintText: "State"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: pinCodeController,
                        keyboardType: TextInputType.text,
                        hintText: "Pin Code"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        hintText: "Email-id"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: contactNumberController,
                        keyboardType: TextInputType.text,
                        hintText: "Contact Number"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        hintText: "Password"),
                    SizedBox(height: 10),
                    CustomTextField(
                        controller: confirmPassController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "Confirm Password"),
                    SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade900),
                        onPressed: () {
                          _registerUser();
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
