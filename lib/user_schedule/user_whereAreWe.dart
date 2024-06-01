import 'package:flutter/material.dart';
import 'package:user_studify/custom_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



CollectionReference whereAreWe = FirebaseFirestore.instance.collection('communication').doc('23').collection('weeks');

////////////////////////////////////////////////////////////////////////////

void userWhereAreWeModalBottomSheet({
  required BuildContext context,
  required height,
  required toppadding,
  required whereAreWeContent,
}) {
  showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints(
          maxHeight: height - toppadding, minHeight: height - toppadding),
      builder: (context) {
        return WhereAreWeUser(
          whereAreWeContent: whereAreWeContent,
        );
      });
}

class WhereAreWeUser extends StatelessWidget {
  final Map<String, dynamic> whereAreWeContent;

  const WhereAreWeUser({Key? key, required this.whereAreWeContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(
            height: 30,
          ),
          ...whereAreWeContent.entries
              .map((e) => (e.key == 'lastUpdated'
              ? const SizedBox()
              : Stack_Card(title: e.key, content: e.value)))
              .toList(),
        ]),
      ),
      Container(
        height: 27,
        color: Colors.white,
        child: Center(
          child: Container(
            alignment: Alignment.center,

            width: 60,
            height: 8,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(231, 228, 228, 1.0),
                borderRadius: BorderRadius.circular(10)
            ),

          ),
        ),
      )
    ]);
  }
}
