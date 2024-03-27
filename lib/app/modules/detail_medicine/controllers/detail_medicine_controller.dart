import 'package:get/get.dart';
import 'package:tugas6_1lx/app/data/medicine.dart';
import 'package:tugas6_1lx/app/data/notification.dart';
import 'package:tugas6_1lx/app/modules/helper/db_helper.dart';
import 'package:tugas6_1lx/app/modules/home/controllers/home_controller.dart';
import 'package:tugas6_1lx/app/modules/home/utils/notification_api.dart';

class DetailMedicineController extends GetxController {
  var db = DbHelper();
  HomeController homeController = Get.put(HomeController());
  late List<Notification> listNotification;

  Future<Medicine> getMedicineData(int id) async {
    return await db.queryOneMedicine(id);
  }

  Future<List<Notification>> getNotificationData(int id) async {
    listNotification = await db.getNotificationsByMedicineId(id);
    return listNotification;
  }

  void deleteMedicine(int id) async {
    listNotification.forEach((element) {
      NotificationApi.cancelNotification(element.id!);
    });
    await db.deleteMedicine(id);
    await db.deleteNotificationByMedicineId(id);

    homeController.getAllMedicineData();
    Get.back();
  }
}