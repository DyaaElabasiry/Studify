import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_linkify/flutter_linkify.dart';


class Element_Container extends StatelessWidget {
  final Map<dynamic, dynamic> element;

  final double screenWidth;

  const Element_Container({required this.element, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    if (element['type'] == 'empty') {
      return SizedBox(
          width: screenWidth / 10 * element['period'],
          height: screenWidth / 10);
    } else if (element['enable'] == false) {
      return Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 2),
        width: screenWidth / 10 * element['period'],
        height: screenWidth / 10,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            border:
                const Border(left: BorderSide(width: 3, color: Colors.grey))),
        child: FittedBox(child: Text(element['name'])),
      );
    } else if (element['type'] == 'lab') {
      return Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 2),
        width: screenWidth / 10 * element['period'],
        height: screenWidth / 10,
        decoration: BoxDecoration(
            color: Colors.pinkAccent.withOpacity(0.2),
            border: const Border(
                left: BorderSide(width: 3, color: Colors.pinkAccent))),
        child: FittedBox(child: Text(element['name'])),
      );
    } else if (element['type'] == 'section') {
      return Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 2),
        width: screenWidth / 10 * element['period'],
        height: screenWidth / 10,
        decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            border:
                const Border(left: BorderSide(width: 3, color: Colors.orange))),
        child: FittedBox(child: Text(element['name'])),
      );
    } else if (element['type'] == 'lecture') {
      return Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 2),
        width: screenWidth / 10 * element['period'],
        height: screenWidth / 10,
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.2),
            border: const Border(
                left: BorderSide(width: 3, color: Colors.blueAccent))),
        child: FittedBox(child: Text(element['name'])),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9, left: 2),
        width: screenWidth / 10 * 2,
        height: screenWidth / 10,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            border:
                const Border(left: BorderSide(width: 3, color: Colors.grey))),
        child: const FittedBox(child: Text('Error')),
      );
    }
  }
}

//////////////////////////////////////////////////////////////////

class Stack_Card extends StatelessWidget {
  final String title;
  final String content;

  const Stack_Card({Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      Container(
        width: double.maxFinite,
        constraints: const BoxConstraints(minHeight: 100),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
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
            text: content,
            child: Linkify(
              text: content,
              onOpen: (link) {
                launchUrl(Uri.parse(link.url));
              },
            )),
      ),
      Container(
        height: 60,
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: FittedBox(
            child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        )),
      ),
    ]);
  }
}


