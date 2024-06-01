import 'package:flutter/material.dart';
import 'package:user_studify/library/library_screen.dart';
import 'package:user_studify/user_schedule/schedule_user_screen.dart';




var currentScreen = "userSchedule";

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                if (currentScreen == "userSchedule") {}
                else {
                  currentScreen = "userSchedule" ;
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UserSchedule()));
                }
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: currentScreen == 'userSchedule'
                      ? const Color.fromRGBO(10, 141, 255, 0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.view_comfortable_rounded,
                      color: currentScreen == 'userSchedule'
                          ? const Color.fromRGBO(10, 141, 255, 1)
                          : Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Schedule',
                        style: TextStyle(
                          fontSize: 25,
                          color: currentScreen == 'userSchedule'
                              ? const Color.fromRGBO(10, 141, 255, 1)
                              : Colors.blueGrey,
                        )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async{
                if (currentScreen == "library") {}
                else {
                  currentScreen = "library";
                  Navigator.of(context).pop();
                  await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LibraryScreen()));
                }
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: currentScreen == 'library'
                      ? const Color.fromRGBO(10, 141, 255, 0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.book_sharp,
                      color: currentScreen == 'library'
                          ? const Color.fromRGBO(10, 141, 255, 1)
                          : Colors.blueGrey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text('Library',
                        style: TextStyle(
                          fontSize: 25,
                          color: currentScreen == 'library'
                              ? const Color.fromRGBO(10, 141, 255, 1)
                              : Colors.blueGrey,
                        )),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
