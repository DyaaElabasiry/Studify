
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:user_studify/library/post_card/like_and_unlike_functions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCard extends StatefulWidget {
  final double width;
  final Map post;
  final String documentId;

  const PostCard(
      {Key? key,
      required this.width,
      required this.post,
      required this.documentId})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = widget.post['date'] ;
    DateTime date = timestamp.toDate();
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 22),
      width: widget.width,
      decoration: BoxDecoration(
        color: Colors.white,
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
                        '${widget.post['firstName']} ${widget.post['lastName']}',
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    Text(
                      '${date.day}/${date.month}/${date.year}',
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                LikeButton(
                  size: 30,
                  likeCount: widget.post['likes'],
                  isLiked: widget.post['likedBy']
                      .contains(Hive.box('userInfo').get('uid')),
                  onTap: (bool isLiked) async {
                    if (!isLiked) { // if not liked then like
                      like(documentId: widget.documentId);
                    } else {  // else if liked then unlike
                      unlike(documentId: widget.documentId);
                    }
                    return !isLiked;
                  },
                )
              ],
            ),
          ),

          ////////// tags row  //////////
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  widget.post['tags'].length,
                  (index) => Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(224, 246, 255, 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          widget.post['tags'][index],
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:  Color.fromRGBO(0, 143, 201, 1)),
                        ),
                      )),
            ),
          ),
          const SizedBox(
            height: 18,
          ),

          /////////////////  bodyText  /////////////////
          GestureDetector(
            onTap: () {
              isExpanded = !isExpanded;
              setState(() {});
            },
            child: AnimatedSize(
                alignment: Alignment.topCenter,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: AutoDirection(
                    text: widget.post['postBody'],
                    child: Linkify(
                      text: widget.post['postBody'],
                      maxLines: isExpanded ? null : 15,
                      overflow: TextOverflow.fade,
                      onOpen: (link) {
                        launchUrl(Uri.parse(link.url),mode: LaunchMode.externalApplication);
                      },
                    ))

                ),
          ),
        ],
      ),
    );
  }
}
