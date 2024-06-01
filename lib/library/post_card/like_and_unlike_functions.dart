import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';


var _firebaseInstance = FirebaseFirestore.instance;

void like({required String documentId}){
  _firebaseInstance
      .collection('library')
      .doc(documentId)
      .update({
    'likes': FieldValue.increment(1),
    'likedBy': FieldValue.arrayUnion(
        [Hive.box('userInfo').get('uid')])
  });
  _firebaseInstance
      .collection('users')
      .doc(Hive.box('userInfo').get('uid'))
      .update({
    'reputation': FieldValue.increment(1),
  });
}

void unlike({required String documentId}){
  _firebaseInstance
      .collection('library')
      .doc(documentId)
      .update({
    'likes': FieldValue.increment(-1),
    'likedBy': FieldValue.arrayRemove(
        [Hive.box('userInfo').get('uid')])
  });
  _firebaseInstance
      .collection('users')
      .doc(Hive.box('userInfo').get('uid'))
      .update({
    'reputation': FieldValue.increment(-1),
  });
}