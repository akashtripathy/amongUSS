import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:vtogethernew/src/pages/splashScreen.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification.body}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  /*SharedPreferences pref=await SharedPreferences.getInstance();
  Widget x= LoginScreen();
  if(pref.containsKey("loggedin") && pref.getBool("loggedin"))
    {
      x=Pages();
    }*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   /* Widget x;
  MyApp(this.x);*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'amongUSS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreenPage(),
    );
  }
}
