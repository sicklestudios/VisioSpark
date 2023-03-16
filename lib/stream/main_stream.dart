// ignore_for_file: prefer_typing_uninitialized_variables, unused_import, camel_case_types, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructorsimport 'dart:async';

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:path/path.dart';



class mainStream extends StatefulWidget {
  mainStream({Key? key}) : super(key: key);
  @override
  State<mainStream> createState() => _mainStreamState();
}

class _mainStreamState extends State<mainStream> {
  var loading = true;
  late String clas;

  final myStream = FirebaseFirestore.instance
      .collection('users')
      .snapshots(includeMetadataChanges: false);

  @override
  initState() {
    final user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (int x = 1; x < querySnapshot.docs.length; x++) {
        // if (querySnapshot.docs[x]['Role'] == 'Admin' &&
        //     querySnapshot.docs[x].id == user.email) {
        //   setState(() {
        //     loading = false;
        //     clas = 'xyz';
        //   });
        // } else
        if (querySnapshot.docs[x].id == user.email) {
          clas = querySnapshot.docs[x]['ref'];

          setState(() {
            loading = false;
          });
        }
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    if (loading == false) {}
    return Scaffold(
        body: loading
            ? Center(child: CircularProgressIndicator())
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(clas)
                    .snapshots(includeMetadataChanges: false),

                // _products.snapshots(), //build connection
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
               
    ));
                  }
                }
 