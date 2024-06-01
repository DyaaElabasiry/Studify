
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:user_studify/main.dart';
import 'package:user_studify/user_schedule/show_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';


void userModalBottomSheet({required BuildContext context,required double height,required double width,required dynamic element,required String day,required int elementIndex}) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      constraints:
      const BoxConstraints(minHeight: 250),
      builder: (context) {
        return UserModalBottomSheetWidget(element: element,width: width, elementIndex: elementIndex, day: day,);
      });
}

class UserModalBottomSheetWidget extends StatefulWidget{
  final dynamic element ;
  final double width ;
  final String day ;
  final int elementIndex;
  UserModalBottomSheetWidget({Key? key, this.element,required this.width, required this.day, required this.elementIndex}) : super(key: key);
  @override
  State<UserModalBottomSheetWidget> createState() => _UserModalBottomSheetWidgetState();
}

class _UserModalBottomSheetWidgetState extends State<UserModalBottomSheetWidget> {
  bool editEnable = false ;
  String editedNotes = '' ;
  String weekIndex = Hive.box('settings').get('weekIndex').toString();
  @override
  Widget build(BuildContext context) {
    var _date = DateTime.parse(widget.element['date']);

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onLongPress: (){
                  Clipboard.setData(ClipboardData(text: widget.element['notes'])) ;
                  Navigator.of(context).pop();
                  var snackBar = const SnackBar(content:  Text('text copied'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.fromLTRB(15, 12, 15, 22),
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 255, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: widget.width - 50,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/profile-avatar.png',
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${widget.element['firstName']} ${widget.element['lastName']}',
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 17, fontWeight: FontWeight.bold)),
                                Text(
                                  '${_date.day}/${_date.month}/${_date.year}',
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            const Text('Edit'),
                            CupertinoSwitch(value: editEnable, onChanged: (value) {
                              editEnable = value ;
                              setState((){});
                            }),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      /////////////////  bodyText  /////////////////
                      AutoDirection(
                          text: widget.element['notes'],
                          child: Linkify(
                            text: widget.element['notes'],
                            overflow: TextOverflow.fade,
                            onOpen: (link) {
                              launchUrl(Uri.parse(link.url),mode: LaunchMode.externalApplication);
                            },
                          )),
                    ],
                  ),
                ),
              ),

              ///////////   edit area   //////////
              ////   when edit is true open edit things   /////
              !editEnable?const SizedBox():Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(
                      left: 13,
                      right: 13,
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(230, 230, 255, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: AutoDirection(
                      text: widget.element['notes'],
                      child: TextFormField(
                        initialValue: widget.element['notes'],
                        minLines: 9,
                        maxLines: null,
                        onChanged: (value) {
                          editedNotes = value ;
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                      showDialogScreen(context: context, elementIndex: widget.elementIndex, day: widget.day, editedNotes: editedNotes, title: widget.element['name'],);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Text('Submit',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
                ],
              )
            ],
          ),
        ),
        Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Color.fromRGBO(227, 234, 253, 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: widget.element['name'] == ''
                        ? const SizedBox()
                        : FittedBox(
                      child: Text(widget.element['name']),
                    ),
                  )),
              Container(
                margin: const EdgeInsets.all(7),
                width: 2,
                decoration: BoxDecoration(
                    color: Colors.indigoAccent.withOpacity(0.2)),
              ),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: widget.element['location'] == ''
                        ? const SizedBox()
                        : FittedBox(
                      child: Text(widget.element['location']),
                    ),
                  )),
            ],
          ),
        )
      ],
    ) ;
  }
}