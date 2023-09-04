import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:push_notification/Pages/notification_page.dart';
import 'package:push_notification/Pages/send_message_page.dart';
import 'package:push_notification/Services/notification_service.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit(context);
    notificationService.setupInteractMessage(context);
    notificationService.getDeviceToken().then((value) => {
          print("Token Value : $value"),
        });
    notificationService.isTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Flutter Push Notification"),
      // ),
      // body: _buildBody,
      bottomNavigationBar: _buildBottomNavigationBar,
    );
  }
  int pageIndex = 0;

  final pages = [
    const SendMessagePage(),
    const NotificationPage(),
  ];

  // Widget get _buildAppBar{
  //   return
  // }

  Widget get _buildBottomNavigationBar{
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.message_rounded,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.message_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            
          ],
        ),
      );
  }

  Widget get _buildBody {
    return Center(
      child: TextButton(
          onPressed: () {
            notificationService.getDeviceToken().then((value) async {
              var data = {
                //We can replace here to the another token key for sent to another phone 
                'to': value.toString(),
                'priority': 'high',
                'notification': {
                  'title': 'Pon',
                  'body': 'Good Morning',
                },
                'data' : {
                  'Name' : 'Pon',
                  'Id' : '12082002',
                }
              };
              await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Authorization':
                      'key=AAAAIHu7xZQ:APA91bEMEYFU_670dD44uJq8M6eF1LG6LoWIeDEoGe7ITFFVkLCnS8PUcUn_4G8G4qRJtOi77ExlAMSJYtjvE7s0EBLG4iVqTTYmiSS1L2GE_D6daM-DVfB0uUjEkUXpytuzl_iMp4z2',
                },
              );
            });
          },
          child: Text(
            "Sent Notification",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }
}
