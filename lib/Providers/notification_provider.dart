import 'package:flutter/material.dart';

import '../Models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notificationStoreList = [];
  List<NotificationModel> get notificationStoreList => _notificationStoreList;

  void removeList(NotificationModel item) {
    _notificationStoreList.remove(item);
    notifyListeners();
  }

  void addList(NotificationModel item) {
    _notificationStoreList.add(item);
    notifyListeners();
  }
}
