import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_studify/user_schedule/send_notification_to_admins.dart';

showDialogScreen({required BuildContext context,required String day,required String editedNotes,required int elementIndex ,required String title}){
  showDialog(context: context, builder: (context)=>AlertDialog(
    title:  Text("Are you sure ?"),
    content:
    Text("you will upload this suggestion"),
    actions: [
      GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5)
          ),
          child: const Text('cancel',style: TextStyle(color: Colors.black),),
        ),
      ),
      GestureDetector(
        onTap:(){
          String weekIndex = Hive.box('settings').get('weekIndex').toString();
          FirebaseFirestore.instance.collection('communication').doc('23').collection('weeks').doc(weekIndex).get().then((value) {
            if (value.exists) {
              var week = value.data();
              List suggestions= week![day][elementIndex]['suggestions'] ;
              suggestions.add({
                'notes': editedNotes,
                'firstName':Hive.box('userInfo').get('firstName').toString(),
                'lastName':Hive.box('userInfo').get('lastName').toString(),
                'date': DateTime.now().toString(),});

              week[day][elementIndex]['suggestions'] = suggestions ;
              FirebaseFirestore.instance.collection('communication').doc('23').collection('weeks').doc(weekIndex).update(week) ;
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              sendNotificationToAdmins(day: day, weekIndex: weekIndex, title: title);

            }

          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(5)
          ),
          child: const Text('Submit',style: TextStyle(color: Colors.white),),
        ),
      )
    ],
  ));
}