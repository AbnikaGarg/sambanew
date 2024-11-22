import 'package:get/get.dart';
import 'package:sambanew/controller/eventController.dart';
import '../controller/homeController.dart';

class EventBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Eventcontroller>(() => Eventcontroller());
  }
}
