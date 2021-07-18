import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mvvm_demo/ui/home/home_page.dart';

class LoginPage extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

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

                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),/*FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')*/
                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                  textInputAction: TextInputAction.done,
                  maxLength: 16,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[200] ?? Colors.grey)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey)
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Phone Number"

                  ),
                  controller: _phoneController,
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
                      }else if(phoneNumber.length>0 && phoneNumber.length<=8){
                        print("Phone number should be atleast 8 char");
                      }else{
                        registerUser("+91${_phoneController.text.trim()}", context);
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

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential _credential){
          _auth.signInWithCredential(_credential).then((UserCredential result){
            Get.to(HomePage(user: result.user!));
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => HomePage(user: result.user!,)
            ));
          }).catchError((e){
            print(e);
          });
        },
        verificationFailed: (FirebaseAuthException authException){
          print("Exception => ${authException.message}");
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
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => HomePage(user: result.user!)
                        ));
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