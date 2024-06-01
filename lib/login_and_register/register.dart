import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_studify/user_schedule/schedule_user_screen.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_studify/library/library_screen.dart';
class RegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  bool obscureTextForPassword = true;
  bool obscureTextForPasswordConfirmation = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Register new\naccount',
                  style:  TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 110,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: (screenWidth - 60) / 2,
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) {
                          firstName = value;
                        },
                        validator: (value) {
                          if (value != null) {
                            if (value.length < 3) {
                              return 'At least 3 letters';
                            } else {
                              return null;
                            }
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'First name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: (screenWidth - 60) / 2,
                      padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) {
                          lastName = value;
                        },
                        validator: (value) {
                          if (value != null) {
                            if (value.length < 3) {
                              return 'At least 3 letters';
                            } else {
                              return null;
                            }
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value != null) {
                        if (value != email) {
                          return "Emails don't match";
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email confirmation',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    obscureText: obscureTextForPassword,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration:  InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureTextForPassword = !obscureTextForPassword;
                            });
                          },
                          child: Icon(obscureTextForPassword
                              ? Icons.visibility_off
                              : Icons.visibility)),

                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    obscureText: obscureTextForPasswordConfirmation,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value != null) {
                        if (value != password) {
                          return "Passwords don't match";
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration:  InputDecoration(
                      hintText: 'Password confirmation',
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureTextForPasswordConfirmation = !obscureTextForPasswordConfirmation;
                            });
                          },
                          child: Icon(obscureTextForPasswordConfirmation
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    if (firstName.length < 3 || lastName.length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:  Text(
                              'first and last name should be at least 3 letters')));
                    } else {
                      try {
                        var Auth = FirebaseAuth.instance;
                        await Auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                        var snackBar = const SnackBar(content: Text('signed in'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(Auth.currentUser!.uid)
                            .set({
                          'email': email,
                          'firstName': firstName,
                          'lastName': lastName,
                          'uid': Auth.currentUser!.uid,
                          'type': 'user',
                          'reputation': 0,
                        });
                        Hive.box('userInfo').putAll({
                          'email': email,
                          'firstName': firstName,
                          'lastName': lastName,
                          'uid': Auth.currentUser!.uid,
                          'type': 'user',});
                        Hive.box('settings').put('weekIndex', '1') ;
                        Hive.box('settings').put('adminWeekIndex','default') ;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserSchedule()));
                      } on FirebaseAuthException catch (e) {
                        var snackBar = SnackBar(content: Text(e.code));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?  ",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
