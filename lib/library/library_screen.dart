import 'package:flutter/material.dart';
import 'package:user_studify/drawer.dart';
import 'package:user_studify/library/body_of_posts_widget.dart';
import 'package:user_studify/library/global_variables_for_library.dart';


class LibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 244, 255, 1),
      resizeToAvoidBottomInset: false,
      drawer: CustomDrawer(),
      body: Builder(
        builder: (context) {
          return SafeArea(
            child: Stack(
              children: [
                BodyOfPosts(width: width,),

                //////  the appbar /////////

                Container(
                  padding: const EdgeInsets.only(top: 13,bottom: 13),
                  width: width,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                       BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 10),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(child: IconButton(icon:const Icon(Icons.notes), onPressed: (){ Scaffold.of(context).openDrawer(); },)),
                      const Expanded(child:  SizedBox()),
                      const Expanded(
                        child: FittedBox(child: Text('Library')),
                        flex: 3,
                      ),
                      Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.post_add,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              goToCreatePostPage(context);
                            },
                          )),
                      Expanded(
                          child: IconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              goToSearchPage(context);
                            },
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
