import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notification/Models/notification_model.dart';
import 'package:get/get.dart';

import '../Providers/notification_provider.dart';

class DetailPage extends StatefulWidget {
  final NotificationModel message;
  const DetailPage({Key? key, required this.message}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        actions: [
          InkWell(
            onTap: () {
              context.read<NotificationProvider>().removeList(widget.message);
              Get.back();
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(50),
                  image: DecorationImage(
                    image: NetworkImage(widget.message.image),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.message.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ropon',
                fontSize: 20,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(.1,.1),
                blurRadius: .1,
                color: Color.fromARGB(82, 0, 0, 0).withOpacity(.1),
                spreadRadius: .1,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(
            widget.message.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
