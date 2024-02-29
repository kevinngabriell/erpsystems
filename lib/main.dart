import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/login.dart';
import 'package:erpsystems/medium/login.dart';
import 'package:erpsystems/web-settings/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      checkDevice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void checkDevice() {

    if(ResponsiveWidget.isLargeScreen(context)){
      final storage = GetStorage();
      String profileName = storage.read('firstName').toString();
      String companyName = storage.read('companyName').toString();

      if(profileName.isEmpty || profileName == 'null'){
        Get.to(const LoginLarge());
      } else {
        Get.to(IndexLarge(companyName));
      }

      // if(profileName != null){
      //   Get.to(IndexLarge(companyName));
      // } else if (profileName == null){
      //   Get.to(LoginLarge());
      // }
      
    } else {
      Get.to(const LoginMedium());
    }
      
    
  }
}

