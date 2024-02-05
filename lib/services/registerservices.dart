import 'package:erpsystems/large/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Future <void> registerServices(String firstName, String lastName, String username, String password1, String password2, String refferalCode, BuildContext context) async {

  //Check if first name is null or not
  if(firstName == '' || firstName.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('First name must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if (lastName == '' || lastName.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Last name must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if(username == '' || username.isEmpty){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Username must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if(password1 == '' || password1.isEmpty) {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Password must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if(password2 == '' || password2.isEmpty) {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Confirm password must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if(refferalCode == '' || refferalCode.isEmpty) {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Refferal code must be filled. Please try again !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else if(password1 != password2){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: Text('Error'),
          content: Text('Your password is not match. Please try again'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: Text('Oke')
            )
          ],
        );
      }
    );
  } else {

    //Call the API
    try{
      String apiRegister = "https://kevinngabriell.com/erpAPI-v.1.0/user/createuser.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "first_name" : firstName,
          "last_name" : lastName, 
          "username" : username,
          "password" : password1,
          "unique_id" : refferalCode 
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your account has been registered. Please login to proceed'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(LoginLarge());
                  }, 
                  child: Text('Login')
                )
              ],
            );
          }
        );
      //Check if username is exist 
      } else if (response.statusCode == 203){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: Text('Error'),
              content: Text('Username is already exist. Please use another username'),
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
      //Check refferal code is valid
      }  else if (response.statusCode == 204){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please check your refferal code. Your refferal code might be wrong or user has reached limit. Please contact IT Support for help'),
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