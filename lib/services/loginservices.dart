import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/medium/template/indextemplatemedium.dart';
import 'package:erpsystems/small/template/indextemplatesmall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../web-settings/responsive.dart';

Future <void> loginService(String username, String password, BuildContext context) async {
  // Get.snackbar('Title', '$username, $password');
  
  if(ResponsiveWidget.isLargeScreen(context)){
    Get.to(const IndexLarge());
  } else if (ResponsiveWidget.isMediumScreen(context)){
    Get.to(const IndexTemplateMedium());
  } else if (ResponsiveWidget.isSmallScreen(context)){
    Get.to(const IndexTemplateSmall());
  }
}