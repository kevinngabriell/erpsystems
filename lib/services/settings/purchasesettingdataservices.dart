// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/purchasesettings.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <void> insertPurchaseTypeData(purchaseType, BuildContext context) async {
  try{
    String apiInsertPurchaseType = "${ApiEndpoints.baseUrl}/master/purchaseType/insertpurchasetype.php";

    final response = await http.post(
      Uri.parse(apiInsertPurchaseType),
      body: {
        "purchase_type_name" : purchaseType
      }
    );

    //Check if true
    if(response.statusCode == 200){
      showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your purchase type data has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const PurchaseSettingLarge());
                  }, 
                  child: const Text('Oke')
                ),
              ],
            );
          }
        );
    } else {
      showDialog(
        context: context, 
        builder: (_){
          return const AlertDialog(
            title: Text('Error'),
            content:  Text('Contact IT Support for help !!'),
          );
        }
      );
    }

  } catch (e) {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
        );
      }
    );
  } finally {

  }
}

Future <void> insertPurchaseStatusData(purchaseStatus, BuildContext context) async {
  
  try{
    String apiInsertPurchaseStatus = "${ApiEndpoints.baseUrl}/master/purchaseStatus/insertpurchasestatus.php";

    final response = await http.post(
      Uri.parse(apiInsertPurchaseStatus),
      body: {
        "purchase_status_name" : purchaseStatus
      }
    );

    //Check if true
    if(response.statusCode == 200){
      showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your purchase status data has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const PurchaseSettingLarge());
                  }, 
                  child: const Text('Oke')
                ),
              ],
            );
          }
        );
    } else {
      showDialog(
        context: context, 
        builder: (_){
          return const AlertDialog(
            title: Text('Error'),
            content:  Text('Contact IT Support for help !!'),
          );
        }
      );
    }

  } catch (e) {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
        );
      }
    );
  } finally {

  }
}

Future <List<Map<String, dynamic>>> allPurchaseType() async{
 final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/master/purchaseType/getallpurchasetype.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future <List<Map<String, dynamic>>> allPurchaseStatus() async{
 final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}/master/purchaseStatus/getallpurchasestatus.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}
