// ignore_for_file: use_build_context_synchronously
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/medium/setting/settingindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/web-settings/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future <void> insertTargeting(companyID, targetYear, targetValue, BuildContext context) async{
  try {
    String apiURL = '${ApiEndpoints.baseUrl}company/targeting/inserttargeting.php';

    final response = await http.post(
      Uri.parse(apiURL),
      body: {
        "company_id" : companyID,
        "target_year" : targetYear, 
        "target_value" : targetValue
      }
    );

    if(response.statusCode == 200){
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your target has been updated in our systems'),
          actions: [
            TextButton(
              onPressed: (){
                if(ResponsiveWidget.isLargeScreen(context)){
                  Get.to(const SettingIndexLarge());
                } else if (ResponsiveWidget.isMediumScreen(context)){
                  Get.to(const SettingMediumIndex());
                } else if (ResponsiveWidget.isSmallScreen(context)){
                  // Get.to(const IndexTemplateSmall());
                }
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    } else {
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: (){
                Get.to(const SettingIndexLarge());
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    }

  } catch (e) {

  }
}

Future <void> updatePermission(permissionID, username, BuildContext context) async {
  try{
    String updatePermissionURL = '${ApiEndpoints.baseUrl}company/permission/updatepermission.php';

    final response = await http.post(
      Uri.parse(updatePermissionURL),
      body: {
        "permission_id" : permissionID,
        "username" : username
      }
    );

    if(response.statusCode == 200){
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your user permission has been updated in our systems'),
          actions: [
            TextButton(
              onPressed: (){
                if(ResponsiveWidget.isLargeScreen(context)){
                  Get.to(const SettingIndexLarge());
                } else if (ResponsiveWidget.isMediumScreen(context)){
                  Get.to(const SettingMediumIndex());
                } else if (ResponsiveWidget.isSmallScreen(context)){
                  // Get.to(const IndexTemplateSmall());
                }
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    } else {
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: (){
                Get.to(const SettingIndexLarge());
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    }

  } catch (e){

  }
}

Future<void> updateUserLimit(userLimit, refferalCode, context) async {
  try{
    String updateUserLimit = '${ApiEndpoints.baseUrl}company/permission/updateuserlimit.php';
    print(userLimit);
    print(refferalCode);
    final response = await http.post(
      Uri.parse(updateUserLimit),
      body: {
        "userLimit" : userLimit,
        "refferalCode" : refferalCode
      }
    );

    if(response.statusCode == 200){
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your user limit has been updated in our systems'),
          actions: [
            TextButton(
              onPressed: (){
                if(ResponsiveWidget.isLargeScreen(context)){
                  Get.to(const SettingIndexLarge());
                } else if (ResponsiveWidget.isMediumScreen(context)){
                  Get.to(const SettingMediumIndex());
                } else if (ResponsiveWidget.isSmallScreen(context)){
                  // Get.to(const IndexTemplateSmall());
                }
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    } else {
      showDialog(
        context: context, 
        builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: Text(response.body),
          actions: [
            TextButton(
              onPressed: (){
                Get.to(const SettingIndexLarge());
              }, 
              child: const Text('Oke')
            ),
          ],
        );}
      );
    }

  } catch (e){

  }
}