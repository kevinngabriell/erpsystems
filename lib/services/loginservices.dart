// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/medium/template/indextemplatemedium.dart';
import 'package:erpsystems/small/template/indextemplatesmall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../web-settings/responsive.dart';

Future <void> loginService(String username, String password, BuildContext context) async {
  if(username.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Username cannot be blank. Please input your username !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (password.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Password cannot be blank. Please input your password !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else {
    
    try{
      String apiLogin = "https://kevinngabriell.com/erpAPI-v.1.0/user/login.php";

      final response = await http.post(
        Uri.parse(apiLogin),
        body: {
          "username" : username,
          "password" : password, 
        }
      );

      if(response.statusCode == 203){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Invalid username'),
              content: const Text('Username is not found. Please check again your username'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.back();
                  }, 
                  child: const Text('Ok')
                )
              ],
            );
          }
        );
      } else if (response.statusCode == 204){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Invalid password'),
              content: const Text('Your password is not valid. Please check again your password !!'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.back();
                  }, 
                  child: const Text('Ok')
                )
              ],
            );
          }
        );
      } else if (response.statusCode == 200){
        var result = json.decode(response.body);
        GetStorage().write('username', result['username']);
        GetStorage().write('permissionAccess', result['permissionAccess']);
        GetStorage().write('companyId', result['companyId']);
        GetStorage().write('companyName', result['companyNameString']);
        GetStorage().write('firstName', result['firstName']);

        String companyName = result['companyNameString'];

        if(ResponsiveWidget.isLargeScreen(context)){
          Get.to(IndexLarge(companyName));
        } else if (ResponsiveWidget.isMediumScreen(context)){
          Get.to(const IndexTemplateMedium());
        } else if (ResponsiveWidget.isSmallScreen(context)){
          Get.to(const IndexTemplateSmall());
        }
      }
    } catch (e){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }

  }
  
  
}