
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mvvm_demo/data/api_client.dart';
import 'package:mvvm_demo/modal/medicine_data.dart';

class HomeController extends GetxController{

  var className1 = <ClassName>[].obs;
  var className2 = <ClassName>[].obs;
  TextEditingController usernameController = TextEditingController();
  var username = "".obs;

  @override
  void onInit() {
    super.onInit();
    print("onInit called");
    getUserDetails();
  }

  void getUserDetails() async{
    // Get.dialog(Center(child: CircularProgressIndicator()),
    //     barrierDismissible: true);
    try{
      var result = await ApiClient().getData();
      Data data = Data.fromMap(result);
      print("Result => ${data.problems![0].diabetes![0].medications![0].medicationsClasses![0].className!.length}");
      className1.value = data.problems![0].diabetes![0].medications![0].medicationsClasses![0].className ?? [];
      className2.value = data.problems![0].diabetes![0].medications![0].medicationsClasses![0].className2 ?? [];
    }catch(e){
      print("Error => $e");
      Get.snackbar('Error', e.toString(), instantInit: false);
    }
  }
}