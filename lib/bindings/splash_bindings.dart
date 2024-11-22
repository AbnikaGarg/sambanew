import 'package:get/get.dart';
import 'package:sambanew/controller/splashController.dart';
import '../controller/homeController.dart';


class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  
  }
}