import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvvm_demo/ui/home/home_page.dart';

class LoginController extends GetxController{

  @override
  void onInit() {
    super.onInit();

    GetStorage storage = GetStorage();
    dynamic user = storage.read("userData");
    print("User => $user");
    if(user != null){
      Get.to(HomePage(user: user));
    }
  }
}