import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FireAuth = StateProvider((ref)=>FirebaseAuth.instance);
final Firestore = StateProvider((ref)=>FirebaseFirestore.instance);

var users = FirebaseFirestore.instance.collection('users') ;