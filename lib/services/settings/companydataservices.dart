import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <Map<String, dynamic>> CompanyDataService(company_id) async{
  final response = await http.get(
        Uri.parse('http://localhost/erpAPI-v.1.0/company/companyData/getdetailcompany.php?company_id=$company_id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
}

class CompanyData {
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String companyWeb;
  final String companyIndustry;
  final String companyEmail;

  CompanyData({
    required this.companyName,
    required this.companyAddress,
    required this.companyPhone,
    required this.companyWeb,
    required this.companyIndustry,
    required this.companyEmail
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      companyName: json['company_name'] ?? 'N/A',
      companyAddress: json['company_address'] ?? 'N/A',
      companyPhone: json['company_phone'] ?? 'N/A',
      companyWeb: json['company_web'] ?? 'N/A',
      companyIndustry: json['company_industry'] ?? 'N/A',
      companyEmail: json['company_email'] ?? 'N/A'
    );
  }
}

Future <void> updateCompanyData(companyID, companyName, companyAddress, companyPhoneNumber, companyWebsite, companyIndustry, companyEmail, BuildContext context) async{
  
  if(companyName.isEmpty || companyName == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company name cannot be blank. Please input company name !!'),
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
  } else if (companyAddress.isEmpty || companyAddress == '') {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company address cannot be blank. Please input company address !!'),
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
  } else if (companyPhoneNumber.isEmpty || companyPhoneNumber == '') {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company phone number cannot be blank. Please input company phone number !!'),
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
  } else if (companyWebsite.isEmpty || companyWebsite == '') {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company website cannot be blank. Please input company website !!'),
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
  } else if (companyIndustry.isEmpty || companyIndustry == '') {
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company industry cannot be blank. Please input company industry !!'),
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
  } else if (companyEmail.isEmpty || companyEmail == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Company email cannot be blank. Please input company email !!'),
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
      String apiRegister = "http://localhost/erpAPI-v.1.0/company/companyData/updatedetailcompany.php";

      final response = await http.post(
        Uri.parse(apiRegister),
        body: {
          "company_id" : companyID,
          "company_name" : companyName, 
          "company_address" : companyAddress,
          "company_phone" : companyPhoneNumber,
          "company_web" : companyWebsite,
          "company_industry"  : companyIndustry,
          "company_email" : companyEmail
        }
      );

      //Check if true
      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your company has been updated in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const SettingIndexLarge());
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