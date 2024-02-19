import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/login.dart';
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class NewPurchasingImportLarge extends StatefulWidget {
  const NewPurchasingImportLarge({super.key});

  @override
  State<NewPurchasingImportLarge> createState() => _NewPurchasingImportLargeState();
}

class _NewPurchasingImportLargeState extends State<NewPurchasingImportLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String companyId = '';
  String profileName = '';
  String companyName = '';
  bool showSuggestions = false;
  bool isLoading = false;
  String Years2Digit = '';
  String romanNumeral = '';

  List<Map<String, String>> listSuppliers = [];
  List<Map<String, String>> listSuppliersPICName = [];
  String selectedSupplier = '';
  List<Map<String, String>> listTerms = [];
  String selectedTerm = '';
  List<Map<String, String>> listOrigins = [];
  List<Map<String, String>> listOrigins1 = [];
  String selectedOrigin = '';
  String supplierPIC = '';

  List<Item> items = [
    Item(name: 'Item 1', quantity: 10, harga: 10000),
    Item(name: 'Item 2', quantity: 20, harga: 10000),
    Item(name: 'Item 3', quantity: 15, harga: 10000),
    // Add more items as needed
  ];

  List<Item> selectedItems = [];

  String convertToRoman(int number) {
    if (number < 1 || number > 12) {
      throw ArgumentError('Month should be between 1 and 12');
    }

    List<String> romanNumerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'];

    return romanNumerals[number - 1];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSupplier();
    getOrigin();
    getTerm();
  }

  //Services
  Future<void> getOrigin() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.apiCountry),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listOrigins = (data['Data'] as List)
                .map((origin) => Map<String, String>.from(origin))
                .toList();
          });
        } else {
          // Handle API error
          print('Failed to fetch data');
        }
      } else {
        // Handle HTTP error
        print('Failed to fetch data');
      }


    } catch (e){
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getTerm() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.termList),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listTerms = (data['Data'] as List)
                .map((term) => Map<String, String>.from(term))
                .toList();
            selectedTerm = listTerms[0]['term_id']!;
          });
        } else {
          // Handle API error
          print('Failed to fetch data');
        }
      } else {
        // Handle HTTP error
        print('Failed to fetch data');
      }


    } catch (e){
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getSupplier() async{
    try {
      companyId = storage.read('companyId').toString();

      // Set loading state before making the API call
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.listSupplier(companyId)),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listSuppliers = (data['Data'] as List)
                .map((supplier) => Map<String, String>.from(supplier))
                .toList();
            selectedSupplier = listSuppliers[0]['supplier_id']!;
            selectedOrigin = listSuppliers[0]['supplier_origin']!;
            supplierPIC = listSuppliers[0]['supplier_pic_name']!;
          });
        } else {
          // Handle API error
          print('Failed to fetch data');
        }
      } else {
        // Handle HTTP error
        print('Failed to fetch data');
      }
    } finally {
      // Set loading state to false when data fetching is completed
      setState(() {
        isLoading = false;
      });
    }
  }
  
  Future<void> getSupplierOrigin(supplierID) async {
    try{
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.supplierOrigin(supplierID)),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['StatusCode'] == 200) {
              setState(() {
                listOrigins1 = (data['Data'] as List)
                    .map((origin) => Map<String, String>.from(origin))
                    .toList();
                if (listOrigins1.isNotEmpty && listOrigins1[0]['supplier_origin'] != null) {
                  selectedOrigin = listOrigins1[0]['supplier_origin']!;
                } else {
                  // Handle the case where 'supplier_origin' is null or the list is empty
                  print('Error: Null value encountered while accessing supplier_origin');
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
        } else {
          // Handle API error
          print('Failed to fetch data');
        }

      } else {
        // Handle HTTP error
        print('Failed to fetch data');
      }

    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getSupplierPICName(supplierID) async {
    try{
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.supplierPICName(supplierID)),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            if (data['StatusCode'] == 200) {
              setState(() {
                listSuppliersPICName = (data['Data'] as List)
                    .map((origin) => Map<String, String>.from(origin))
                    .toList();
                if (listSuppliersPICName.isNotEmpty && listSuppliersPICName[0]['supplier_pic_name'] != null) {
                  supplierPIC = listSuppliersPICName[0]['supplier_pic_name']!;
                } else {
                  // Handle the case where 'supplier_origin' is null or the list is empty
                  print('Error: Null value encountered while accessing supplier_origin');
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
        } else {
          // Handle API error
          print('Failed to fetch data');
        }

      } else {
        // Handle HTTP error
        print('Failed to fetch data');
      }

    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();

    DateTime now = DateTime.now();
    int currentYear = now.year;
    Years2Digit = (currentYear % 100).toString();
    int currentMonth = now.month;
    romanNumeral = convertToRoman(currentMonth);

    return MaterialApp(
      home: Scaffold(
        body: isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
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
                          foregroundColor: const Color(0xFF2A85FF),
                          backgroundColor: const Color(0xfFF4F4F4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/PurchasingActive.png'),
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
                          foregroundColor: const Color(0xFF6F767E),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/SettingInactive.png'),
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
                          Get.off(const LoginLarge());
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
                              onChanged: (value){
                                setState(() {
                                });
                              },
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
                                ),
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
                    if(txtSearchText.text == '')
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF4F4F4)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.sp, top: 7.sp, bottom: 5.sp, right: 7.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Purchasing Module', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                              SizedBox(height: 10.h,),
                              //Card Overview
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Text and Filter Area
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Text('Purchase Order Import', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Purchase Order Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                Text('VIK/$Years2Digit/$romanNumeral/0001', style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w600,),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Date', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DateTimePicker(
                                                  dateHintText: 'Input purchase date',
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(2100),
                                                  initialDate: DateTime.now(),
                                                  dateMask: 'd MMM yyyy',
                                                  decoration: InputDecoration(
                                                    prefixIcon: Image.asset('Icon/CalendarIcon.png'),
                                                    hintText: 'Input purchase date',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // TanggalPulangAwal = DateFormat('yyyy-MM-dd').parse(value);
                                                      //selectedDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(txtTanggal);
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('To', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DropdownButtonFormField<String>(
                                                  value: selectedSupplier,
                                                  decoration: InputDecoration(
                                                    // prefixIcon: Image.asset('Icon/CalendarIcon.png'),
                                                    hintText: 'Select supplier',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  items: listSuppliers.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> supplier) {
                                                      return DropdownMenuItem<String>(
                                                        value: supplier['supplier_id'],
                                                        child: Text(supplier['supplier_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue){
                                                    selectedSupplier = newValue!;
                                                    getSupplierOrigin(selectedSupplier);
                                                    getSupplierPICName(selectedSupplier);
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Attn', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                TextFormField(
                                                  initialValue: supplierPIC,
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    // prefixIcon: Image.asset('Icon/CalendarIcon.png'),
                                                    hintText: 'Supplier PIC',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Shipment', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DateTimePicker(
                                                  dateHintText: 'Input shipment date',
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(2100),
                                                  initialDate: DateTime.now(),
                                                  dateMask: 'd MMM yyyy',
                                                  decoration: InputDecoration(
                                                    prefixIcon: Image.asset('Icon/ShipmentIcon.png'),
                                                    hintText: 'Input shipment date',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // TanggalPulangAwal = DateFormat('yyyy-MM-dd').parse(value);
                                                      //selectedDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(txtTanggal);
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Term', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DropdownButtonFormField<String>(
                                                  value: selectedTerm,
                                                  decoration: InputDecoration(
                                                    // prefixIcon: Image.asset('Icon/CalendarIcon.png'),
                                                    hintText: 'Select term',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  items: listTerms.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> term) {
                                                      return DropdownMenuItem<String>(
                                                        value: term['term_id'],
                                                        child: Text(term['term_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue){
                                                    selectedTerm = newValue!;
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Payment', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DateTimePicker(
                                                  dateHintText: 'Input shipment date',
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(2100),
                                                  initialDate: DateTime.now(),
                                                  dateMask: 'd MMM yyyy',
                                                  decoration: InputDecoration(
                                                    prefixIcon: Image.asset('Icon/ShipmentIcon.png'),
                                                    hintText: 'Input payment date',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      // TanggalPulangAwal = DateFormat('yyyy-MM-dd').parse(value);
                                                      //selectedDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(txtTanggal);
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 149.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Origin', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DropdownButtonFormField<String>(
                                                  value: selectedOrigin,
                                                  decoration: InputDecoration(
                                                    // prefixIcon: Image.asset('Icon/CalendarIcon.png'),
                                                    hintText: 'Select origin',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  items: listOrigins.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> origin) {
                                                      return DropdownMenuItem<String>(
                                                        value: origin['origin_id'],
                                                        child: Text(origin['origin_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue){
                                                    selectedOrigin = newValue!;
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Shipping marks', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                TextFormField(
                                                  maxLines: 3,
                                                  initialValue: 'Default value + .... \nDefault value + .... \nJakarta',
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(' ', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                TextFormField(
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    hintText: 'Remarks'
                                                  )
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        )
                      )
                    ,if(txtSearchText.text != '')
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF4F4F4)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.sp, top: 7.sp, bottom: 5.sp, right: 7.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Search Result', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                      )
                  ]
                )
              )
            ],
          )
        )
      )
    );
  }
}

class Item {
  String name;
  int quantity;
  int harga;

  Item({required this.name, required this.quantity, required this.harga});
}