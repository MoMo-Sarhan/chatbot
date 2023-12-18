// ignore_for_file: prefer_const_constructors

import 'package:chatbot/auth/auth_gate.dart';
import 'package:chatbot/firebase_options.dart';
import 'package:chatbot/screens/loginPage.dart';
import 'package:chatbot/services/auth/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

bool notificationFlag = true;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => AuthService(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   _firebaseMessaging.requestPermission();
  //   _firebaseMessaging.getToken().then((token) {
  //     print('Firebase token:$token');
  //   });
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('recived message:$message');
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('recived message open app:$message');
  //   });
  // }

  // Future<void> _handleBackGroundMessage(RemoteMessage message) async {
  //   print('Handleing background message');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
