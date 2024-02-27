import 'package:erpsystems/services/loginservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginMedium extends StatefulWidget {
  const LoginMedium({super.key});

  @override
  State<LoginMedium> createState() => _LoginMediumState();
}

class _LoginMediumState extends State<LoginMedium> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venken ERP Systems',
      home: Scaffold(
        body: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   //Login Title
                  Center(
                    child: Text('Login', style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600,),)
                  ),
                  Center(
                    child: Text('Login to access ERP Systems', style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500, color: const Color.fromRGBO(129, 131, 133, 1)),)
                  ),
                  SizedBox(height: 20.h,),
                  //Username Input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
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
                          hintText: 'Input your username'
                        ),    
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  //Password Input
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextFormField(
                        controller: txtPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset('Icon/Lock.png'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Input your password'
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  //Forgot Password
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text('Forgot Password?', style: TextStyle(fontSize: 7.sp,fontWeight: FontWeight.w500, color: const Color.fromRGBO(167, 128, 255, 1)),)
                    ),
                  ),
                  SizedBox(height: 25.h,),
                  //Login Button
                  Center(
                    child: ElevatedButton(
                      onPressed: (){
                        loginService(txtUsername.text, txtPassword.text, context);
                      }, 
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        alignment: Alignment.center,
                        minimumSize: Size(60.w, 50.h),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(110, 46, 253, 0.8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w700,),)
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  //Create Account
                  Center(
                    child: GestureDetector(
                      onTap: () {
                            
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600, color: const Color.fromRGBO(111, 118, 126, 1))
                            ),
                            TextSpan(
                              text: "Create Account",
                              style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600, color: const Color.fromRGBO(110, 46, 253, 1))
                            )
                          ]
                        )
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}