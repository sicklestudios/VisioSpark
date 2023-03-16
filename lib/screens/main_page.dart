import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:safewalk/screens/Home_page.dart';


import '../util/const.dart';
import 'login.dart';


class Wrapper extends StatefulWidget {
  static const routeName = "/wrapper";

  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var loading = true;
  bool loginSelected = true;

  bool registerSelected = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Constant.setupSize(context);

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Home();

            // FirebaseAuth.instance.signOut();
          } else {
            return const LoginScreen();
          }
        }),
      ),
    );

    // loading?return Scaffold(body: Center(child: CircularProgressIndicator(),),):
  }
}
