
// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/customersettings.dart';
import 'package:erpsystems/medium/setting/customerindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/web-settings/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List<Map<String, dynamic>>> allCustomerDataService(company_id) async{
  final response = await http.get(
        Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/customer/getallcustomer.php?company=$company_id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future <void> insertCustomerData(customerName, customerAddress, customerPhone, customerPICName, customerPICContact, companyId, BuildContext context) async {
  
  if(customerName.isEmpty || customerName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer name cannot be blank. Please input customer name !!'),
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
  } else if (customerAddress.isEmpty || customerAddress == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer address cannot be blank. Please input customer address !!'),
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
  } else if (customerPhone.isEmpty || customerPhone == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer phone cannot be blank. Please input customer phone !!'),
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
      String apiRegister = "${ApiEndpoints.baseUrl}/master/customer/insertcustomer.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "company_name" : customerName,
          "company_address" : customerAddress, 
          "company_phone" : customerPhone,
          "company_pic_name" : customerPICName,
          "company_pic_contact" : customerPICContact,
          "company_id"  : companyId
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your customer has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    if(ResponsiveWidget.isLargeScreen(context)){
                      Get.to(CustomerSettingLarge());
                    } else if (ResponsiveWidget.isMediumScreen(context)){
                      Get.to(const CustomerMediumIndex());
                    } else if (ResponsiveWidget.isSmallScreen(context)){
                      // Get.to(const IndexTemplateSmall());
                    }
                    // Get.to(const CustomerSettingLarge());
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

Future<Map<String, dynamic>> getDetailCustomerData(customerId) async {
  final response = await http.get(
    Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/customer/getdetailcustomer.php?company_id=$customerId'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class CustomerData {
  final String customerID;
  final String customerName;
  final String companyAddress;
  final String companyPhone;
  final String companyPicName;
  final String companyPicContact;

  CustomerData({
    required this.customerID,
    required this.customerName,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyPicName,
    required this.companyPicContact,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      customerID: json['company_id'] ?? 'N/A',
      customerName: json['company_name'] ?? 'N/A',
      companyAddress: json['company_address'] ?? 'N/A',
      companyPhone: json['company_phone'] ?? 'N/A',
      companyPicName: json['company_pic_name'] ?? 'N/A',
      companyPicContact: json['company_pic_contact'] ?? 'N/A',
    );
  }
}

Future <void> updateCustomerData(customerId, customerName, customerAddress, customerPhone, customerPICName, customerPICContact,  BuildContext context) async {
  if(customerName.isEmpty || customerName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer name cannot be blank. Please input customer name !!'),
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
  } else if (customerAddress.isEmpty || customerAddress == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer address cannot be blank. Please input customer address !!'),
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
  } else if (customerPhone.isEmpty || customerPhone == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Customer phone cannot be blank. Please input customer phone !!'),
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
      String apiRegister = "https://kevinngabriell.com/erpAPI-v.1.0/master/customer/updatecustomer.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "company_name" : customerName,
          "company_address" : customerAddress, 
          "company_phone" : customerPhone,
          "company_pic_name" : customerPICName,
          "company_pic_contact" : customerPICContact,
          "company_id"  : customerId
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your customer has been updated in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const CustomerSettingLarge());
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
