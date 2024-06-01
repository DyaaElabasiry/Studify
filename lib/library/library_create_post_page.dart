import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LibraryCreatePostPage extends StatefulWidget {
  const LibraryCreatePostPage({Key? key}) : super(key: key);

  @override
  _LibraryCreatePostPageState createState() => _LibraryCreatePostPageState();
}

class _LibraryCreatePostPageState extends State<LibraryCreatePostPage> {
  List<String> tags = ['communication', 'level3'];
  String tag = "";
  String postBody = "";
  var tagsController = TextEditingController();
  var postController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tagsController.dispose();
    postController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.08,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text(
                        "Tags shouldn't contain UPPER case letters or SPACES for better search",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          margin: const EdgeInsets.all(10),
                          width: screenSize.width - 68,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: tagsController,
                            onChanged: (value) {
                              tag = value;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Add a tag',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 30,
                          icon: const Icon(Icons.add),
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              if (tag != "") {
                                tags.add(tag);
                                tagsController.clear();
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    AnimatedSize(
                      alignment: Alignment.topCenter,
                      duration: const Duration(milliseconds: 200),
                      child: SizedBox(
                        width: screenSize.width - 20,
                        child: Wrap(
                          children: List.generate(
                              tags.length,
                              (index) => Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(5),
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Text(
                                            tags[index],
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color:  Color.fromRGBO(
                                                    0, 143, 201, 1)),
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  tags.removeAt(index);
                                                });
                                              },
                                              child: const Text(
                                                '    x',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color:  Color.fromRGBO(
                                                        0, 110, 160, 1)),
                                              ))
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(224, 246, 255, 1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10)),
                      child: RichText(text: const TextSpan(
                        children: [
                          TextSpan(text: "Links should start with ",style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w600),),
                           TextSpan(text: "https://",style: TextStyle(
                              color: Colors.deepPurpleAccent, fontWeight: FontWeight.w600), )
                        ]
                      )),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.all(10),
                      width: screenSize.width - 20,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: postController,
                        minLines: 13,
                        maxLines: null,
                        onChanged: (value) {
                          postBody = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Post',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: screenSize.width,
                height: screenSize.height * 0.07,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12.withOpacity(0.4),
                          blurRadius: 40)
                    ]),
                child: Row(
                  children: [
                    Expanded(
                        child: IconButton(
                            onPressed: () {

                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios_outlined))),
                    const Expanded(
                      child:  Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            'Create post',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                        child: GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: const FittedBox(
                          child: Text(
                            'Post',
                            style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (tags.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('You should put at least 4 tags'),
                          ));
                        } else if (postBody.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content:  Text('Post cannot be empty'),
                          ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Are you sure ?"),
                                  content: const Text(
                                      "you will upload or edit this post "),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        "cancel",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Post",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      onPressed: () async {
                                        try {
                                          await FirebaseFirestore.instance
                                              .collection('library')
                                              .add({
                                            'postBody': postBody,
                                            'tags': tags,
                                            'user':
                                                Hive.box('userInfo').get('uid'),
                                            'date': FieldValue.serverTimestamp(),
                                            'likes': 0,
                                            'comments': [],
                                            'firstName': Hive.box('userInfo')
                                                .get('firstName'),
                                            'lastName': Hive.box('userInfo')
                                                .get('lastName'),
                                            'likedBy': [],
                                            'profilePicture': '',
                                          });
                                          Navigator.of(context).pop();
                                          postController.clear();
                                          tagsController.clear();
                                          postBody = '';
                                          tags = ['communication', 'level3'];
                                          setState(() {});
                                        } on SocketException {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content:  Text(
                                                      'No internet connection')));
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
