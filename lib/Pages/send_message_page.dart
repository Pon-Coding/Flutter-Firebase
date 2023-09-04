import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:push_notification/Models/notification_model.dart';
import 'package:push_notification/Services/notification_service.dart';
import 'package:http/http.dart' as http;

import '../Fonts/font_style.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  NotificationService notificationService = NotificationService();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  TextEditingController _toUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          width: 300,
          // color: Colors.red,
          alignment: Alignment.center,
          child: Image.asset('assets/images/sendMessage.png'),
        ),
      ),
      body: _buildBody,
    );
  }

  late String title;
  late String image;
  late String des;
  late String toUser;
  Widget get _buildBody {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTo(
              label: 'To',
              hint: 'Enter user token',
              icon: Icons.code_rounded),
          SizedBox(height: 15),
          _buildTitle(
              label: 'Title',
              hint: 'Enter your title',
              icon: Icons.title_rounded),
          SizedBox(height: 15),
          _buildImage(
              label: 'Image',
              hint: 'Enter your image link',
              icon: Icons.image_rounded),
          SizedBox(height: 15),
          _buildDes(
              label: 'Description',
              hint: 'Enter your description',
              icon: Icons.description_outlined),
          SizedBox(
            height: 15,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  notificationService.getDeviceToken().then((value) async {
                    var data = {
                      //We can replace here to the another token key for sent to another phone
                      'to': value.toString(),
                      'priority': 'high',
                      'notification': {
                        'title': '$title',
                        'body': '$des',
                      },
                      'data': {
                        'Name': 'Pon',
                        'Title' : '$title',
                        'Body' : '$des',
                        'Image' : '$image',
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
                  _titleController.clear();
                  _desController.clear();
                  _imageController.clear();
                },
                child: Text("SEND NOW", style: btnStyle)),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(
      {required String label, required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        
        onChanged: (value) {
          setState(() {
            title = value;
          });
        },
        
        controller: _titleController,
        keyboardType: TextInputType.text,
        maxLines: null,
        style: inputFieldStyle,
        decoration: InputDecoration(
          
          hintText: hint,
          hintStyle: hintFieldStyle,
          labelText: label,
          labelStyle: labelFieldStyle,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildImage(
      {required String label, required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) {
          setState(() {
            image = value;
          });
        },
        controller: _imageController,
        keyboardType: TextInputType.text,
        maxLines: null,
        style: inputFieldStyle,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintFieldStyle,
          labelText: label,
          labelStyle: labelFieldStyle,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildDes(
      {required String label, required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) {
          setState(() {
            des = value;
          });
        },
        controller: _desController,
        keyboardType: TextInputType.text,
        maxLines: null,
        style: inputFieldStyle,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintFieldStyle,
          labelText: label,
          labelStyle: labelFieldStyle,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildTo(
      {required String label, required String hint, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withOpacity(.1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) {
          setState(() {
            toUser = value;
          });
        },
        controller: _toUserController,
        keyboardType: TextInputType.text,
        maxLines: null,
        style: inputFieldStyle,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: hintFieldStyle,
          labelText: label,
          labelStyle: labelFieldStyle,
          border: InputBorder.none,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
