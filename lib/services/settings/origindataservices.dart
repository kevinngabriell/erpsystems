// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/originsettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List<Map<String, dynamic>>> allOriginDataService() async{
  final response = await http.get(
        Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/origin/getorigin.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future<Map<String, dynamic>> getDetailOrigin(originId) async {
  final response = await http.get(
    Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/origin/getdetailorigin.php?origin_id=$originId'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class Origin {
  final String origin_name;
  final String origin_is_free_trade;
  final String region_name;

  Origin({
    required this.origin_name,
    required this.origin_is_free_trade,
    required this.region_name
  });

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(
      origin_name: json['origin_name'] ?? 'N/A',
      origin_is_free_trade: json['origin_is_free_trade'] ?? 'N/A',
      region_name: json['region_name'] ?? 'N/A',
    );
  }
}

Future <void> updateoriginData(originId, originName, originIsFreeTrade, BuildContext context) async {
  if(originName.isEmpty || originName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Origin name cannot be blank. Please input origin name !!'),
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
  } else if (originIsFreeTrade.isEmpty || originIsFreeTrade == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Free trade cannot be blank. Please input free trade !!'),
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
    //Call the API
    try{
      String apiRegister = "https://kevinngabriell.com/erpAPI-v.1.0/master/origin/updateorigin.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "origin_name" : originName,
          "origin_is_free_trade" : originIsFreeTrade, 
          "origin_id" : originId,
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your origin data has been updated in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const OriginSettingLarge());
                  }, 
                  child: const Text('Oke')
                ),
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
              title: const Text('Error'),
              content: const Text('Username is already exist. Please use another username'),
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
      //Check refferal code is valid
      }  else if (response.statusCode == 204){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Please check your refferal code. Your refferal code might be wrong or user has reached limit. Please contact IT Support for help'),
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