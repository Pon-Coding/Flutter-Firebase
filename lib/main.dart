
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/Providers/notification_provider.dart';
import 'package:push_notification/Screens/splash_screen.dart';

import 'Pages/main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHanler);
  runApp(providerWithMyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHanler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print(message.notification!.title.toString());

}
Widget providerWithMyApp(){
  return MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>NotificationProvider()),
  ],
  child: MyApp(),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}