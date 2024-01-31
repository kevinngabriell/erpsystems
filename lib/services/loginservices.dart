import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/medium/template/indextemplatemedium.dart';
import 'package:erpsystems/small/template/indextemplatesmall.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../web-settings/responsive.dart';

Future <void> loginService(String username, String password, BuildContext context) async {
  if(username.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Username cannot be blank. Please input your username !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Ok')
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
          title: Text('Error'),
          content: Text('Password cannot be blank. Please input your password !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Ok')
            )
          ],
        );
      }
    );
  } else {
    
    try{
      String apiLogin = "http://localhost/erpAPI-v.1.0/user/login.php";

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
              title: Text('Invalid username'),
              content: Text('Username is not found. Please check again your username'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.back();
                  }, 
                  child: Text('Ok')
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
              title: Text('Invalid password'),
              content: Text('Your password is not valid. Please check again your password !!'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.back();
                  }, 
                  child: Text('Ok')
                )
              ],
            );
          }
        );
      } else if (response.statusCode == 200){
        if(ResponsiveWidget.isLargeScreen(context)){
          Get.to(const IndexLarge());
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
            title: Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }

  }
  
  
}