import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_studify/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_studify/library/global_variables_for_library.dart';
import 'package:user_studify/library/library_create_post_page.dart';
import 'package:user_studify/library/library_screen.dart';
import 'package:user_studify/library/library_search_page.dart';
import 'package:user_studify/login_and_register/login.dart';
import 'package:user_studify/login_and_register/register.dart';
import 'package:user_studify/notification_screen.dart';
import 'package:user_studify/user_schedule/schedule_user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  BuildContext? context = navigatorKey.currentContext;
  if (context != null) {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Text('notification received'),
            ));
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return UserSchedule();
    }));
  }

  print('Handling a background message ${message.messageId}');
}

// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox('userInfo');
  await Hive.openBox('settings');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    navigatorKey.currentState!.push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return NotificationScreen(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    ));
  });
  // channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     description: 'This channel is used for important notifications.', // description
  //   importance : Importance.high
  // );
  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  FirebaseMessaging.instance.subscribeToTopic('all');
  // FirebaseMessaging.instance.subscribeToTopic('admins');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser ;
    FirebaseAuth.instance.authStateChanges().listen((event) {
      setState((){
          user =  event;
      });
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Studify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user == null
          ? RegisterScreen()
          : UserSchedule(),
    );
  }
}

