// ignore_for_file: use_build_context_synchronously

import 'package:erpsystems/large/setting%20module/termsetting.dart';
import 'package:erpsystems/medium/setting/termindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/web-settings/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future <List<Map<String, dynamic>>> allTermData() async{
  final response = await http.get(
        Uri.parse('${ApiEndpoints.baseUrl}master/term/getallterm.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['Data'];
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
}

Future <void> insertTermData(termName, BuildContext context) async {
  try{
    String apiInsertTerm = "${ApiEndpoints.baseUrl}/master/term/insertterm.php";

    final response = await http.post(
      Uri.parse(apiInsertTerm),
      body: {
        "term_name" : termName
      }
    );

    //Check if true
    if(response.statusCode == 200){
      showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your term data has been added in our systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    if(ResponsiveWidget.isLargeScreen(context)){
                      Get.to(const TermSettingLarge());
                    } else if (ResponsiveWidget.isMediumScreen(context)){
                      Get.to(const TermIndexMedium());
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