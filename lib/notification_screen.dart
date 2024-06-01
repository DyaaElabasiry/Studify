import 'package:flutter/material.dart';
import 'package:auto_direction/auto_direction.dart';

class NotificationScreen extends StatefulWidget {
  final String title ;
  final String body ;

  const NotificationScreen({Key? key, required this.title, required this.body}) : super(key: key);
  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.4),
      body: Stack(
        children: [
          SizedBox(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      child:  Text(
                        widget.title,
                        style:
                        const TextStyle(fontWeight: FontWeight.w400, fontSize: 23,color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: double.maxFinite,
                        child:  AutoDirection(
                          text: widget.body,
                          child: Text(
                            widget.body,
                            style: const TextStyle(
                                fontSize: 17),
                          ),
                        )),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}