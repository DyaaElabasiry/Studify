import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_studify/library/global_variables_for_library.dart';

class LibrarySearchPage extends StatefulWidget {
  @override
  State<LibrarySearchPage> createState() => _LibrarySearchPageState();
}

class _LibrarySearchPageState extends State<LibrarySearchPage> {
  var tagController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tagController.dispose();
  }

  List<String> tags = [];
  String tag='';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: (width -20),
                  height: 50,
                  decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: (width - 116),
                        height: 50,
                        decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(7)),
                        child: TextField(
                          controller: tagController,
                          onChanged: (value) {
                              tag = value;
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add the tags then click on search',
                            hintStyle: TextStyle(color: Colors.grey.shade500),

                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            tags.add(tag);
                            tagController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.blue,
                        ),
                      ),
                      Consumer(
                        builder: (context,ref,_) {
                          return IconButton(
                            onPressed: () {
                              ref.read(searchTagsProvider.state).state = tags;
                              getSearchPosts(width: width, ref: ref);
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.blue,
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
                AnimatedSize(
                  alignment: Alignment.topCenter,
                  duration: const Duration(milliseconds: 200),

                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding:tags.isEmpty?const EdgeInsets.all(0): const EdgeInsets.only(top: 10,bottom: 10),
                    width: width - 20,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Wrap(
                      children: [

                        ...List.generate(
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
                                              color: Color.fromRGBO(
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
                                              style:  TextStyle(
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
                                ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
