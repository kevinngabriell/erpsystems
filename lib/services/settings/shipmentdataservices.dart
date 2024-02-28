// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/shippingsettings.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/web-settings/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List<Map<String, dynamic>>> allShipmentData() async{
  final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}master/shipping/getallshipping.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future <void> insertShipmentData(shippingName, BuildContext context) async {
  try{
    String apiInsertShipping = "${ApiEndpoints.baseUrl}/master/shipping/insertshipping.php";

    final response = await http.post(
      Uri.parse(apiInsertShipping),
      body: {
        "shipping_name" : shippingName
      }
    );

    //Check if true
    if(response.statusCode == 200){
      showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your shipment data has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    if(ResponsiveWidget.isLargeScreen(context)){
                      Get.to(const ShippingIndexLarge());
                    } else if (ResponsiveWidget.isMediumScreen(context)){
                      Get.to(const ShippingIndexLarge());
                    } else if (ResponsiveWidget.isSmallScreen(context)){
                      // Get.to(const IndexTemplateSmall());
                    }
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