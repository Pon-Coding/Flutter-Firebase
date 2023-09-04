import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  final String id;
  const MessagePage({Key? key,required this.id}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message Screen ${widget.id}"),
        centerTitle: true,
      ),
    );
  }
}
