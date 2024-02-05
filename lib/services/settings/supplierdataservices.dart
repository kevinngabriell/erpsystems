// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/suppliersettingslarge.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List<Map<String, dynamic>>> allSupplierDataService(companyId) async{
  final response = await http.get(
        Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/supplier/getallsupplier.php?company=$companyId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future<Map<String, dynamic>> getDetailSupplier(supplierId) async {
  final response = await http.get(
    Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/master/supplier/getsupplierdetail.php?supplier_id=$supplierId'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class SupplierData {
  final String supplierId;
  final String supplierName;
  final String supplierPhone;
  final String supplierAddress;
  final String supplierPICName;
  final String supplierPICContact;
  final String supplierOrigin;
  final String freeTradeArea;

  SupplierData({
    required this.supplierId,
    required this.supplierName,
    required this.supplierPhone,
    required this.supplierAddress,
    required this.supplierPICName,
    required this.supplierPICContact,
    required this.supplierOrigin,
    required this.freeTradeArea
  });

  factory SupplierData.fromJson(Map<String, dynamic> json) {
    return SupplierData(
      supplierId: json['supplier_id'] ?? 'N/A',
      supplierName: json['supplier_name'] ?? 'N/A',
      supplierPhone: json['supplier_phone'] ?? 'N/A',
      supplierAddress: json['supplier_address'] ?? 'N/A',
      supplierPICName: json['supplier_pic_name'] ?? 'N/A',
      supplierPICContact: json['supplier_pic_contact'] ?? 'N/A',
      supplierOrigin: json['supplier_origin'] ?? 'N/A',
      freeTradeArea: json['origin_is_free_trade'] ?? 'N/A'
    );
  }
}

Future <void> updateSupplier(supplierId, supplierName, supplierPhone, supplierAddress, supplierPICName, supplierPICContact, SupplierCountry, BuildContext context) async{
  
  if(supplierName.isEmpty || supplierName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier name cannot be blank. Please input supplier name !!'),
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
  } else if (supplierPhone.isEmpty || supplierPhone == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier phone cannot be blank. Please input supplier phone !!'),
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
  } else if (supplierAddress.isEmpty || supplierAddress == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier address cannot be blank. Please input supplier address !!'),
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
  } else if (supplierPICName.isEmpty || supplierPICName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier PIC Name cannot be blank. Please input supplier PIC name !!'),
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
  } else if (supplierPICContact.isEmpty || supplierPICContact == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier PIC contact cannot be blank. Please input supplier PIC contact !!'),
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
      String apiRegister = "https://kevinngabriell.com/erpAPI-v.1.0/master/supplier/updatesupplier.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "supplier_id" : supplierId,
          "supplier_name" : supplierName, 
          "supplier_phone" : supplierPhone,
          "supplier_address" : supplierAddress,
          "supplier_pic_name" : supplierPICName,
          "supplier_pic_contact" : supplierPICContact,
          "supplier_origin" : SupplierCountry
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your supplier has been updated in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const SupplierSettingLarge());
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

Future <void> insertSupplier(supplierName, supplierOrigin, supplierAddress, supplierPhone, supplierPICName, supplierPICContact, companyID, BuildContext context) async {
  
  if(supplierName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier name cannot be blank. Please input supplier name !!'),
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
  } else if (supplierPhone == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier phone cannot be blank. Please input supplier phone !!'),
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
  } else if (supplierAddress == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier address cannot be blank. Please input supplier address !!'),
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
  } else if (supplierPICName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier PIC Name cannot be blank. Please input supplier PIC name !!'),
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
  } else if (supplierPICContact == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier PIC contact cannot be blank. Please input supplier PIC contact !!'),
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
  } else if (supplierOrigin == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Supplier country cannot be blank. Please select supplier country !!'),
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
      String apiRegister = "https://kevinngabriell.com/erpAPI-v.1.0/master/supplier/insertsupplier.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "supplier_name" : supplierName,
          "supplier_origin" : supplierOrigin, 
          "supplier_address" : supplierAddress,
          "supplier_phone" : supplierPhone,
          "supplier_pic_name" : supplierPICName,
          "supplier_pic_contact"  : supplierPICContact,
          "company_id" : companyID
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your supplier has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const SupplierSettingLarge());
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