import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mvvm_demo/ui/auth/controller/login_controller.dart';
import 'package:mvvm_demo/ui/home/home_page.dart';
import 'package:mvvm_demo/utils/Gap.dart';
import 'package:mvvm_demo/utils/app_utils.dart';
import 'package:mvvm_demo/utils/color_helper.dart';

class LoginPage extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  String countryDialCode = "+91";
  String countryCode = "IN";
  final LoginController _loginController = Get.put(LoginController()); //Managing state using Getx pattern
  GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    // FirebaseCrashlytics.instance.crash();
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                SizedBox(height: 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        width: 120,
                        // height: 80,
                        child: CountryCodePicker(
                          onChanged: (e) {
                            print('countryCode :: ${e.code} :: ${e.dialCode} :: ${e.flagUri}');
                            countryDialCode = e.dialCode!;
                            countryCode = e.code!;
                          },
                          initialSelection: AppUtils.countryCode,
                          favorite: ['US', 'UK', 'AU' 'IN'],/*'+970'*/
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          showFlag: true,
                          alignLeft: false,
                        )),
                    Container(
                      width: 0.8,
                      color: hintColor.withOpacity(0.4),
                    ),
                    HorizontalGap(gap: 12),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.numberWithOptions(decimal: true),/*FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')*/
                        // inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                        textInputAction: TextInputAction.done,
                        maxLength: 16,
                        decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 5),
                            hintText: "Phone Number"

                        ),
                        controller: _phoneController,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text("Login"),
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16),
                    onPressed: (){
                      //code for sign in
                      String phoneNumber = _phoneController.text.trim();

                      if(phoneNumber.isEmpty){
                        print("Phone number is mandatory");
                        Get.snackbar('Error', "Phone number is mandatory", instantInit: false);
                      }else if(phoneNumber.length>0 && phoneNumber.length<=8){
                        print("Phone number should be atleast 8 char");
                        Get.snackbar('Error', "Phone number should be atleast 8 char", instantInit: false);
                      }else{
                        registerUser("$countryDialCode${_phoneController.text.trim()}", context);
                      }
                    },
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  Future registerUser(String mobile, BuildContext context) async{
    print("Mobile Number => $mobile");
    FirebaseAuth _auth = FirebaseAuth.instance;

    //Firebase auth using Phone Number authentication....
    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential _credential){
          _auth.signInWithCredential(_credential).then((UserCredential result){
            storage.write("userData", result.user);
            Get.to(HomePage(user: result.user!));
          }).catchError((e){
            print(e);
          });
        },
        verificationFailed: (FirebaseAuthException authException){
          print("Exception => ${authException.message}");
          Get.snackbar('Error', authException.message!, instantInit: false);
        },
        codeSent: (String verificationId, int? forceResendingToken){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter SMS Code"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _codeController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                    ),

                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Done"),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      String smsCode = _codeController.text.trim();

                      AuthCredential _credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                      auth.signInWithCredential(_credential).then((UserCredential result){

                        storage.write("userData", result.user);
                        Get.to(HomePage(user: result.user!)); // After code verification Navigate to Home page using getx library..

                       /* Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => HomePage(user: result.user!)
                        ));*/
                      }).catchError((e){
                        print(e);
                      });
                    },
                  )
                ],
              )
          );
        },
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        }
    );
  }
}