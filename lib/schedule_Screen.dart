import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'user_schedule/user_table.dart';
import 'where_are_we_user.dart';
import 'custom_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewScreen extends StatefulWidget {
  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  late ScrollController scrollcontroller;
  CollectionReference firebaseInstance =
  FirebaseFirestore.instance.collection('communication').doc('23').collection('weeks');
  String weeks = '3';
  Map<String, dynamic> week = {};

  @override
  void initState() {
    scrollcontroller = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenDimensions = MediaQuery.of(context);
    double width = screenDimensions.size.width;
    double height = screenDimensions.size.height;
    double toppadding = screenDimensions.padding.top;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 244, 255, 1),
      body: Stack(
        children: [
          FutureBuilder<List<DocumentSnapshot>>(
              future: Future.wait([
                firebaseInstance.doc('whereAreWe').get(),
                firebaseInstance.doc(weeks).get()
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapShot) {
                if (snapShot.hasData) {

                  if (snapShot.data![1].data() != null) {
                    week = snapShot.data![1].data() as Map<String, dynamic>;
                  } else {
                    week = {};
                  }
                  var whereAreWeContent =
                  snapShot.data![0].data() as Map<String, dynamic>;
                  return ListView(
                    controller: scrollcontroller,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height:kIsWeb?height*0.08: screenDimensions.padding.top + 20,
                      ),
                      Container(
                          width: screenDimensions.size.width - 54,
                          margin: const EdgeInsets.all(27),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                )
                              ],
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(68.0)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        userWhereAreWeModalBottomSheet(
                                            context: context,
                                            height: height,
                                            toppadding: toppadding,
                                            whereAreWeContent:
                                            whereAreWeContent);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 13,
                                            bottom: 13),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                          color: Colors.indigoAccent,
                                        ),
                                        child: Column(
                                          children: [
                                            const FittedBox(
                                              child:  Text(
                                                "Where are we",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            FittedBox(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.access_time,
                                                    color: Colors.white70,
                                                    size: 17,
                                                  ),
                                                  Text(
                                                    whereAreWeContent[
                                                    'lastUpdated'],
                                                    style: const TextStyle(
                                                        color: Colors.white70),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Center(
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 100,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(100),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Colors.indigoAccent
                                                          .withOpacity(0.2))),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Week",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.blueGrey),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    height: 35,
                                                    child: DropdownButton(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      elevation: 1,
                                                      menuMaxHeight: 400,
                                                      isExpanded: true,
                                                      underline: const SizedBox(),
                                                      value: weeks,
                                                      items: [
                                                        ...List.generate(
                                                            14,
                                                                (index) =>
                                                                DropdownMenuItem(
                                                                  child: Text(
                                                                    '${index + 1}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                        25,
                                                                        color: Colors
                                                                            .indigoAccent,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                                  ),
                                                                  value:
                                                                  '${index + 1}',
                                                                ))
                                                      ],
                                                      onChanged: (newvalue) {
                                                        weeks = newvalue.toString();
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                height: 2,
                                decoration: BoxDecoration(
                                    color:
                                    Colors.indigoAccent.withOpacity(0.08)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Lectures",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: -0.2),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 8),
                                            height: 4,
                                            width: 70,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                                gradient: LinearGradient(colors: [
                                                  Color.fromRGBO(9, 171, 230, 1),
                                                  Color.fromRGBO(71, 206, 255, 1)
                                                ])),
                                          )
                                        ],
                                      )),
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Labs",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.2),
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.only(top: 8),
                                                height: 4,
                                                width: 70,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4)),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(
                                                              255, 117, 168, 1),
                                                          Color.fromRGBO(
                                                              255, 166, 199, 1)
                                                        ])),
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Sections",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: -0.2),
                                              ),
                                              Container(
                                                margin:
                                                const EdgeInsets.only(top: 8),
                                                height: 4,
                                                width: 70,
                                                decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(4)),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Color.fromRGBO(
                                                              255, 204, 133, 1),
                                                          Color.fromRGBO(
                                                              255, 221, 173, 1)
                                                        ])),
                                              )
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              )
                            ],
                          )),

                      //////////////////////////////////////////////////////////////////////

                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenDimensions.size.width / 40,
                            right: screenDimensions.size.width / 40),
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 7)
                            ]),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: screenDimensions.size.width / 10 * 1.5,
                              child:  FittedBox(
                                child: Text(
                                  "Period",

                                ),
                              ),
                            ),
                            ...List.generate(
                                8,
                                    (index) => Container(
                                  width: screenDimensions.size.width / 10,
                                  height: screenDimensions.size.width / 20,
                                  alignment: Alignment.center,

                                  child: FittedBox(
                                    child: Text(
                                      "${index + 1}",

                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),

                      week == {}
                          ? const SizedBox()
                          : DayInTable(
                        width: width,
                        week: week,
                        height: height,
                        c: context,
                      ),

                    ],
                  );
                }
                return const Center(
                  child: SpinKitDoubleBounce(
                    color: Colors.deepOrange,
                    size: 100,
                  ),
                );
              }),
          Container(
            padding: EdgeInsets.only(top: toppadding + 10, bottom: 10),
            width: width,
            height:kIsWeb?height*0.08: 90,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.only(bottomLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.4), blurRadius: 40)
                ]),
            child: FittedBox(
              child: Text(
                'Comm 23',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
