import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:push_notification/Pages/detail_page.dart';
import 'package:push_notification/Providers/notification_provider.dart';
import '../Models/notification_model.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 0,
        centerTitle: true,
        title: Container(
            width: 300,
            // color: Colors.red,
            alignment: Alignment.centerLeft,
            child: Image.asset('assets/images/Notifications.png')),
        actions: [
          Icon(
            Icons.search_rounded,
            color: Colors.black54,
            size: 30,
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
    if (context.watch<NotificationProvider>().notificationStoreList.isEmpty) {
      return Center(
        child: Text(
          "No Notification",
          style: TextStyle(
              fontFamily: 'Ropon',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey),
        ),
      );
    } else {
      return _builGridView;
    }
  }

  Widget get _builGridView {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: context.watch<NotificationProvider>().notificationStoreList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 80,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(context.watch<NotificationProvider>().notificationStoreList[index]);
      },
    );
  }

  Widget _buildItem(NotificationModel item) {
    return InkWell(
      onTap: () {
        Get.to(() => DetailPage(message: item),
            transition: Transition.fade, duration: Duration(seconds: 1));
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
        onPressed: (context){
          setState(() {
            context.read<NotificationProvider>().removeList(item);
          });
        },
        backgroundColor: Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Delete',
      ),
          ],
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: .1,
                offset: Offset(.1, .1),
                color: Colors.black.withOpacity(.1),
                blurRadius: .1,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Text(item.title),
            subtitle: Text(
              item.description,
              overflow: TextOverflow.ellipsis,
            ),
            leading: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: NetworkImage(item.image),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
