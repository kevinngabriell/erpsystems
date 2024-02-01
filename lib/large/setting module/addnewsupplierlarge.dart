
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/services/settings/supplierdataservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../index.dart';
import '../template/analyticstemplatelarge.dart';
import '../template/documenttemplatelarge.dart';
import '../template/financetemplatelarge.dart';
import '../template/hrtemplatelarge.dart';
import '../template/warehousetemplatelarge.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AddSupplierSettingLarge extends StatefulWidget {
  const AddSupplierSettingLarge({super.key});

  @override
  State<AddSupplierSettingLarge> createState() => _AddSupplierSettingLargeState();
}

class _AddSupplierSettingLargeState extends State<AddSupplierSettingLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String companyId = '';
  TextEditingController txtSupplierName = TextEditingController();
  TextEditingController txtSupplierPhone = TextEditingController();
  TextEditingController txtSupplierAddress = TextEditingController();
  TextEditingController txtSupplierPICName = TextEditingController();
  TextEditingController txtSupplierPICContact = TextEditingController();

  //For country dropdown
  List<Map<String, String>> countries = [];
  String selectedCountry = '';

  @override
  void initState() {
    super.initState();
    fetchCountryList();
  }

  Future<void> fetchCountryList() async {
    final response = await http.get(
        Uri.parse(ApiEndpoints.apiCountry));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['StatusCode'] == 200) {
        setState(() {
          countries = (data['Data'] as List)
              .map((reason) => Map<String, String>.from(reason))
              .toList();
          if (countries.isNotEmpty) {
            selectedCountry = countries[0]['origin_id']!;
          }
        });
      } else {
        // Handle API error
        print('Failed to fetch data');
      }
    } else {
      // Handle HTTP error
      print('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();
    companyId = storage.read('companyId').toString();

    return MaterialApp(
      title: 'Supplier Configuration',
      home: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Menu
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 4.sp, right: 3.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h,),
                      //Dashboard Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(IndexLarge(companyName));
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/DashboardInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Dashboard', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Sales Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const SalesIndexLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/SalesInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Sales Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Purchasing Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const PurchasingIndexLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/PurchasingInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Purchasing Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Finance Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const FinanceTemplateLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/FinanceInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Finance Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Warehouse Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const WarehouseTemplateLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/WarehouseInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Warehouse Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //HR Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const HRTemplateLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/HRInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('HR Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Analytics Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const AnalyticsTemplateLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/AnalyticsInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Analytics Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Document Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const DocumentTemplateLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/DocumentInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Document Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 35.h,),
                      const Divider(),
                      //Setting Module Button
                      ElevatedButton(
                        onPressed: (){
                          Get.to(const SettingIndexLarge());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFF2A85FF),
                          backgroundColor: const Color(0xfFF4F4F4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/SettingActive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Setting Module', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                      SizedBox(height: 10.h,),
                      //Logout Button
                      ElevatedButton(
                        onPressed: (){
                          // Get.to(MainApp());
                        }, 
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(60.w, 55.h),
                          foregroundColor: const Color(0xFFE47E7E),
                          backgroundColor: const Color(0xFFF4F4F4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/Logout.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Logout', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                    ],
                  ),
                )
              ),
              //Content
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    //Search Bar and Profile
                    Padding(
                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 5.sp, right: 7.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Search Box
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: TextFormField(
                              controller: txtSearchText,
                              decoration: InputDecoration(
                                prefixIcon: Image.asset('Icon/Search.png'),
                                hintText: 'Search',
                                filled: true,
                                fillColor: const Color(0xFFF4F4F4),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                              ),
                            ),
                          ),
                          //Profile Name
                          GestureDetector(
                            onTap: () {
                              
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                              child: ListTile(
                                contentPadding: const EdgeInsets.only(left: 0, right: 0),
                                dense: true,
                                horizontalTitleGap: 0.0,
                                leading: Container(
                                  margin: const EdgeInsets.only(right: 12.0),
                                  child: Image.asset('Icon/Profile.png')
                                ),
                                title: Text(profileName, style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w300),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Content
                    Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height, // Set the minimal height
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F4F4)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.sp, top: 7.sp, bottom: 5.sp, right: 7.sp),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Text('Supplier settings', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 10.h,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Add New Supplier Information Title
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, right: 5.sp),
                                      child: Text('Add New Supplier', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                    ),
                                    SizedBox(height: 10.h,),
                                    //Text Form New Supplier
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 10.sp),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier Name'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtSupplierName,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: 'PT. AXX XXXX'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier Phone'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtSupplierPhone,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: '08xx xxxx xxxx'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier Address'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        maxLines: 3,
                                                        controller: txtSupplierAddress,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: 'Jl. AXX XXXX'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier PIC Name'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtSupplierPICName,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: 'PIC Name'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier PIC Contact'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtSupplierPICContact,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: 'Contact PIC'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Supplier Country'),
                                                      SizedBox(height: 5.h,),
                                                      DropdownButtonFormField<String>(
                                                        value: selectedCountry,
                                                        hint: Text('Choose country'),
                                                        onChanged: (String? newValue) {
                                                          selectedCountry = newValue!;
                                                        },
                                                        items: countries.map<DropdownMenuItem<String>>(
                                                          (Map<String, String> country) {
                                                            return DropdownMenuItem<String>(
                                                              value: country['origin_id'],
                                                              child: Text(country['origin_name']!),
                                                            );
                                                           },
                                                         ).toList(),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 50.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: (){
                                                    insertSupplier(txtSupplierName.text, selectedCountry, txtSupplierAddress.text, txtSupplierPhone.text, txtSupplierPICName.text, txtSupplierPICContact.text, companyId, context);
                                                  }, 
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    alignment: Alignment.centerLeft,
                                                    minimumSize: Size(20.w, 45.h),
                                                    foregroundColor: Colors.white,
                                                    backgroundColor: const Color(0xFF2A85FF),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                  ),
                                                  child: Text('Submit', style: TextStyle(fontSize: 4.sp),)
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                        
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}