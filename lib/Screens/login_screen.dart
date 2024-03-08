import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:htg_smart_watch/Screens/create_new_account.dart';
import 'package:htg_smart_watch/Utils/utils.dart';
import 'package:htg_smart_watch/main.dart';

class Login_Screen extends StatefulWidget{
  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void logIn() async{
    if(emailController.text.trim() == "" || passwordController.text.trim() == ""){
      Utils().toastMessage("Please fill in all the fields.");
    }else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(), password: passwordController.text.trim());
        if (userCredential.user != null){
          //After login Navigating to Home Screen
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      } on FirebaseAuthException catch (error){
        Utils().toastMessage(error.toString());
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
        title: Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.red,
                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    height: 350,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "HTG (Smart)",
                            style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 50,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "Email_Id",
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 50,
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  filled: true,
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade900,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                onPressed: () {
                                  logIn();
                                },
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Text(
                                    "Forget Password",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateNewAccount()));
                                  },
                                  child: Text(
                                    "Create new account",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                              onTap: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}