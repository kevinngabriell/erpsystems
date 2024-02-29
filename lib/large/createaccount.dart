import 'package:erpsystems/large/login.dart';
import 'package:erpsystems/services/registerservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccountLarge extends StatefulWidget {
  const CreateAccountLarge({super.key});

  @override
  State<CreateAccountLarge> createState() => _CreateAccountLargeState();
}

class _CreateAccountLargeState extends State<CreateAccountLarge> {
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword1 = TextEditingController();
  TextEditingController txtPassword2 = TextEditingController();
  TextEditingController txtReferalCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Account',
      home: Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset('Assets/login.png'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Login Title
                  Center(
                    child: Text('Signup your account', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600,),)
                  ),
                  Center(
                    child: Text('Create your account now', style: TextStyle(fontSize: 4.sp,fontWeight: FontWeight.w500, color: const Color.fromRGBO(129, 131, 133, 1)),)
                  ),
                  SizedBox(height: 20.h,),
                  //First name input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        controller: txtFirstName,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'First name'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Last name input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        controller: txtLastName,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Last name'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Username input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        controller: txtUsername,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Username'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Password input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        obscureText: true,
                        controller: txtPassword1,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Password'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Confirm password input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        obscureText: true,
                        controller: txtPassword2,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Confirm password'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Refferal input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: TextFormField(
                        controller: txtReferalCode,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Message.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Referral code'
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  //Register Button
                  Center(
                    child: ElevatedButton(
                      onPressed: (){
                        registerServices(txtFirstName.text, txtLastName.text, txtUsername.text, txtPassword1.text, txtPassword2.text, txtReferalCode.text, context);
                      }, 
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        alignment: Alignment.center,
                        minimumSize: Size(60.w, 50.h),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(110, 46, 253, 0.8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Register', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w700,),)
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  //Create Account
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const LoginLarge());
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Do you have an account?",
                              style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color.fromRGBO(111, 118, 126, 1))
                            ),
                            TextSpan(
                              text: "Login to Account",
                              style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color.fromRGBO(110, 46, 253, 1))
                            ),
                          ]
                        )
                      ),
                    ),
                  )                                    
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}