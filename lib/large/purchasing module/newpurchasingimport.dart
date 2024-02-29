// ignore_for_file: non_constant_identifier_names, avoid_print

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
import 'package:erpsystems/services/settings/companydataservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

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
  String permissionAccess = '';
  List<Map<String, String>> listSuppliers = [];
  List<Map<String, String>> listShipments = [];
  List<Map<String, String>> listPayments = [];
  List<Map<String, String>> listSuppliersPICName = [];
  List<Map<String, String>> listTerms = [];
  List<Map<String, String>> listOrigins = [];
  List<Map<String, String>> listOrigins1 = [];
  String selectedCurrency = 'USD';
  String selectedExchangeCurrency = 'IDR';
  String selectedWeightUnit = 'Pounds';
  String selectedTargetWeightUnit = 'Kilograms';
  String temporary1 = '';
  double totalOne = 0;
  double totalTwo = 0;
  double totalThree = 0;
  double totalFour = 0;
  double totalFive = 0;
  double totalPrice = 0;
  TextEditingController txtExchangeValueThree = TextEditingController();
  TextEditingController txtExchangeValueOne = TextEditingController(text: '15663.45');
  TextEditingController txtExchangeValueTwo = TextEditingController();
  TextEditingController txtWeightValue = TextEditingController();
  TextEditingController txtWeightResult = TextEditingController();
  String shouldMentionOne = '';
  String shouldMentionTwo = '';

  //Value to be inserted
  String PONumber = '';
  DateTime? PurchaseDate;
  String selectedSupplier = '';
  String supplierPIC = '';
  String selectedShipment = '';
  String selectedTerm = '';
  String selectedPayment = '';
  String selectedOrigin = '';
  TextEditingController txtProductNameOne = TextEditingController();
  TextEditingController txtQuantityOne = TextEditingController();
  TextEditingController txtPackagingSizeOne = TextEditingController();
  TextEditingController txtUnitPriceOne = TextEditingController();
  TextEditingController txtTotalOne = TextEditingController();
  TextEditingController txtProductNameTwo = TextEditingController();
  TextEditingController txtQuantityTwo = TextEditingController();
  TextEditingController txtPackagingSizeTwo = TextEditingController();
  TextEditingController txtUnitPriceTwo = TextEditingController();
  TextEditingController txtTotalTwo = TextEditingController();
  TextEditingController txtProductNameThree = TextEditingController();
  TextEditingController txtQuantityThree = TextEditingController();
  TextEditingController txtPackagingSizeThree = TextEditingController();
  TextEditingController txtUnitPriceThree = TextEditingController();
  TextEditingController txtTotalThree = TextEditingController();
  TextEditingController txtProductNameFour = TextEditingController();
  TextEditingController txtQuantityFour = TextEditingController();
  TextEditingController txtPackagingSizeFour = TextEditingController();
  TextEditingController txtUnitPriceFour = TextEditingController();
  TextEditingController txtTotalFour = TextEditingController();
  TextEditingController txtProductNameFive = TextEditingController();
  TextEditingController txtQuantityFive = TextEditingController();
  TextEditingController txtPackagingSizeFive = TextEditingController();
  TextEditingController txtUnitPriceFive = TextEditingController();
  TextEditingController txtTotalFive = TextEditingController();
  TextEditingController txtTotalPrice = TextEditingController();

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '').format(value);
  }

  String formatThousand(double value) {
    return NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '').format(value);
  }

  // Function to convert weight
  double convertWeight(double value, String fromUnit, String toUnit) {
    if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
      return value * 0.453592;
    } else if (fromUnit == 'Ounces' && toUnit == 'Grams') {
      return value * 28.3495;
    } else if (fromUnit == 'Gallons' && toUnit == 'Liters') {
      return value * 3.78541;
    } else {
      return value; // Default to no conversion
    }
  }

  // Function to format the weight
  String formatWeight(double weight) {
    return weight.toStringAsFixed(2);
  }

  String convertToRoman(int number) {
    if (number < 1 || number > 12) {
      throw ArgumentError('Month should be between 1 and 12');
    }

    List<String> romanNumerals = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII'];

    return romanNumerals[number - 1];
  }

  @override
  void initState() {
    super.initState();
    getSupplier();
    getOrigin();
    getTerm();
    getShipping();
    getPayment();
  }

  //Services
  Future<void> getPayment() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.paymentList),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listPayments = (data['Data'] as List)
                .map((payment) => Map<String, String>.from(payment))
                .toList();
            selectedPayment = listPayments[0]['payment_id']!;
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

  Future<void> getShipping() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.shippingList),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listShipments = (data['Data'] as List)
                .map((shipment) => Map<String, String>.from(shipment))
                .toList();
            selectedShipment = listShipments[0]['shipment_id']!;
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
    permissionAccess = storage.read('permissionAccess').toString();

    DateTime now = DateTime.now();
    int currentYear = now.year;
    Years2Digit = (currentYear % 100).toString();
    int currentMonth = now.month;
    romanNumeral = convertToRoman(currentMonth);

    PONumber = 'VIK/$Years2Digit/$romanNumeral/0001';

    return MaterialApp(
      title: 'Purchasing',
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
                                    //Form PO Number, Purchase Date, Supplier Data
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //PO Number
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Purchase Order Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                Text(PONumber, style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w600,),),
                                              ],
                                            ),
                                          ),
                                          //Purchase Date
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
                                                      PurchaseDate = DateFormat('yyyy-MM-dd').parse(value);
                                                    });
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                          //Supplier Data
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
                                    //Form Supplier PIC Name, Shipment Date, Term
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Supplier PIC Name
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
                                          //Shipment Date
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Shipment', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DropdownButtonFormField<String>(
                                                  value: selectedShipment,
                                                  decoration: InputDecoration(
                                                    hintText: 'Select shipment',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  items: listShipments.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> shipment) {
                                                      return DropdownMenuItem<String>(
                                                        value: shipment['shipment_id'],
                                                        child: Text(shipment['shipment_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue){
                                                    selectedShipment = newValue!;
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                          //Term
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
                                    //Form Payment, Origin
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Payment
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Payment', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                DropdownButtonFormField<String>(
                                                  value: selectedPayment,
                                                  decoration: InputDecoration(
                                                    hintText: 'Select payment',
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: const BorderSide(width: 0.0),
                                                      borderRadius: BorderRadius.circular(10.0),
                                                    )
                                                  ),
                                                  items: listPayments.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> payment) {
                                                      return DropdownMenuItem<String>(
                                                        value: payment['payment_id'],
                                                        child: Text(payment['payment_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue){
                                                    selectedPayment = newValue!;
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                          //Origin
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
                                          //Kosong
                                          // SizedBox(
                                          //   width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          //   child: const Column(
                                          //     crossAxisAlignment: CrossAxisAlignment.start,
                                          //     children: [
                                                
                                          //     ],
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    //Product 1-5
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width - 50.w,
                                        child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 7.sp, bottom: 7.sp),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Product 1 #1
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Product Name #1
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtProductNameOne,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert product name',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                    //Quantity #1
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Quantity (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtQuantityOne,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert quantity (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                            onChanged: (value){
                                                              setState(() {
                                                                totalOne = double.parse(txtQuantityOne.text) * double.parse(txtUnitPriceOne.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                txtTotalOne.text = formatCurrency(totalOne);
                                                                txtTotalPrice.text = formatCurrency(totalPrice);
                                                              });
                                                            }
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Change the AlertDialog title
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    title: Center(
                                                                      child: Text(
                                                                        'Weight Converter',
                                                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600)
                                                                      ),
                                                                    ),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightValue,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = convertWeight(double.parse(value), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                      txtWeightResult.text = formatWeight(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Enter weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightResult,
                                                                                  readOnly: true,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Converted weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedTargetWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedTargetWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for target weight units
                                                                                        items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: const Text('Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Weight calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Packaging #1
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Packaging size (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtPackagingSizeOne,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert packaging size (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.h,),
                                                 //Product 1 #2
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Unit Price #1
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Unit price', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtUnitPriceOne,
                                                            onChanged: (value){
                                                              setState(() {
                                                                double unitPrice = double.parse(value.replaceAll(',', ''));

                                                                if(txtQuantityOne.text.isEmpty == true || txtQuantityOne.text == ''){
                                                                  txtQuantityOne.text = '1';
                                                                  totalOne = double.parse(txtQuantityOne.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalOne.text = formatCurrency(totalOne);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                } else {
                                                                  totalOne = double.parse(txtQuantityOne.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalOne.text = formatCurrency(totalOne);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                }

                                                              });
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}(,\d{3})*')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert unit price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Total Price #1
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalOne,
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                        ],
                                                      ),
                                                    ),
                                                    
                                                  ],
                                                ),
                                                SizedBox(height: 25.h,),
                                                const Divider(),
                                                SizedBox(height: 25.h,),
                                                //Product 2 #1
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Product Name #2
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtProductNameTwo,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert product name',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                    //Quantity #2
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Quantity (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtQuantityTwo,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert quantity (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                            onChanged: (value){
                                                              setState(() {
                                                                totalTwo = double.parse(txtQuantityTwo.text) * double.parse(txtUnitPriceTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                txtTotalTwo.text = formatCurrency(totalTwo);
                                                                txtTotalPrice.text = formatCurrency(totalPrice);
                                                              });
                                                            }
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Change the AlertDialog title
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    title: Center(
                                                                      child: Text(
                                                                        'Weight Converter',
                                                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600)
                                                                      ),
                                                                    ),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightValue,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = convertWeight(double.parse(value), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                      txtWeightResult.text = formatWeight(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Enter weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightResult,
                                                                                  readOnly: true,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Converted weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedTargetWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedTargetWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for target weight units
                                                                                        items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: const Text('Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Weight calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Packaging Size #2
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Packaging size (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtPackagingSizeTwo,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert packaging size (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.h,),
                                                //Product 2 #2
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Unit Price #2
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Unit price', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtUnitPriceTwo,
                                                            onChanged: (value){
                                                              setState(() {
                                                                double unitPrice = double.parse(value.replaceAll(',', ''));

                                                                if(txtQuantityTwo.text.isEmpty == true || txtQuantityTwo.text == ''){
                                                                  txtQuantityTwo.text = '1';
                                                                  totalTwo = double.parse(txtQuantityTwo.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalTwo.text = formatCurrency(totalTwo);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                } else {
                                                                  totalTwo = double.parse(txtQuantityTwo.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalTwo.text = formatCurrency(totalTwo);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                }

                                                              });
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}(,\d{3})*')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert unit price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Total #2
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalTwo,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: Color(0xFF787878))),
                                                          // Text('data1'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 25.h,),
                                                const Divider(),
                                                SizedBox(height: 25.h,),
                                                //Product 3 #1
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Product Name #3
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtProductNameThree,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert product name',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                    //Quantity #3
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Quantity (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtQuantityThree,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert quantity (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                            onChanged: (value){
                                                              setState(() {
                                                                totalThree = double.parse(txtQuantityThree.text) * double.parse(txtUnitPriceThree.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                txtTotalThree.text = formatCurrency(totalThree);
                                                                txtTotalPrice.text = formatCurrency(totalPrice);
                                                              });
                                                            }
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Change the AlertDialog title
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    title: Center(
                                                                      child: Text(
                                                                        'Weight Converter',
                                                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600)
                                                                      ),
                                                                    ),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightValue,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = convertWeight(double.parse(value), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                      txtWeightResult.text = formatWeight(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Enter weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightResult,
                                                                                  readOnly: true,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Converted weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedTargetWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedTargetWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for target weight units
                                                                                        items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: const Text('Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Weight calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Packaging Size #3
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Packaging size (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtPackagingSizeThree,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert packaging size (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.h,),
                                                //Product 3 #2
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Unit Price #3
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Unit price', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtUnitPriceThree,
                                                            onChanged: (value){
                                                              setState(() {
                                                                double unitPrice = double.parse(value.replaceAll(',', ''));

                                                                if(txtQuantityThree.text.isEmpty == true || txtQuantityThree.text == ''){
                                                                  txtQuantityThree.text = '1';
                                                                  totalThree = double.parse(txtQuantityThree.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalThree.text = formatCurrency(totalThree);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                } else {
                                                                  totalThree = double.parse(txtQuantityThree.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalThree.text = formatCurrency(totalThree);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                }

                                                              });
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}(,\d{3})*')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert unit price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Total Price #3
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalThree,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: Color(0xFF787878))),
                                                          // Text('data1'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 25.h,),
                                                const Divider(),
                                                SizedBox(height: 25.h,),
                                                //Product 4 #1
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Product Name #4
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtProductNameFour,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert product name',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                    //Quantity #4
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Quantity (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtQuantityFour,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert quantity (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                            onChanged: (value){
                                                              setState(() {
                                                                totalFour = double.parse(txtQuantityFour.text) * double.parse(txtUnitPriceFour.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                txtTotalFour.text = formatCurrency(totalFour);
                                                                txtTotalPrice.text = formatCurrency(totalPrice);
                                                              });
                                                            }
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Change the AlertDialog title
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    title: Center(
                                                                      child: Text(
                                                                        'Weight Converter',
                                                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600)
                                                                      ),
                                                                    ),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightValue,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = convertWeight(double.parse(value), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                      txtWeightResult.text = formatWeight(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Enter weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightResult,
                                                                                  readOnly: true,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Converted weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedTargetWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedTargetWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for target weight units
                                                                                        items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: const Text('Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Weight calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Packaging Size #4
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Packaging size (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtPackagingSizeFour,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert packaging size (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.h,),
                                                //Product 4 #2
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Unit Price #4
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Unit price', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtUnitPriceFour,
                                                            onChanged: (value){
                                                              setState(() {
                                                                double unitPrice = double.parse(value.replaceAll(',', ''));

                                                                if(txtQuantityFour.text.isEmpty == true || txtQuantityFour.text == ''){
                                                                  txtQuantityFour.text = '1';
                                                                  totalFour = double.parse(txtQuantityFour.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalFour.text = formatCurrency(totalFour);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                } else {
                                                                  totalFour = double.parse(txtQuantityFour.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalFour.text = formatCurrency(totalFour);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                }

                                                              });
                                                            },
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}(,\d{3})*')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert unit price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Total Price #4
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalFour,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: Color(0xFF787878))),
                                                          // Text('data1'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 25.h,),
                                                const Divider(),
                                                SizedBox(height: 25.h,),
                                                //Product 5 #1
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Product Name #5
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtProductNameFive,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert product name',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                    //Quantity #5
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Quantity (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtQuantityFive,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert quantity (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                            onChanged: (value){
                                                              setState(() {
                                                                totalFive = double.parse(txtQuantityFive.text) * double.parse(txtUnitPriceFive.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                txtTotalFive.text = formatCurrency(totalFive);
                                                                txtTotalPrice.text = formatCurrency(totalPrice);
                                                              });
                                                            }
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Change the AlertDialog title
                                                              showDialog(
                                                                context: context,
                                                                builder: (_) {
                                                                  return AlertDialog(
                                                                    title: Center(
                                                                      child: Text(
                                                                        'Weight Converter',
                                                                        style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600)
                                                                      ),
                                                                    ),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightValue,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = convertWeight(double.parse(value), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                      txtWeightResult.text = formatWeight(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Enter weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for weight units
                                                                                        items: ['Pounds', 'Ounces', 'Gallons'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h),
                                                                          Row(
                                                                            children: [
                                                                              // 3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtWeightResult,
                                                                                  readOnly: true,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Converted weight',
                                                                                    // Update the prefixIcon DropdownButtonFormField items
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedTargetWeightUnit,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedTargetWeightUnit = newValue!;
                                                                                            double result = convertWeight(double.parse(txtWeightValue.text), selectedWeightUnit, selectedTargetWeightUnit);
                                                                                            txtWeightResult.text = formatWeight(result);
                                                                                          });
                                                                                        },
                                                                                        // Update the items for target weight units
                                                                                        items: ['Kilograms', 'Grams', 'Liters'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                        child: const Text('Ok'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Text('Weight calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Packaging Size #5
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Packaging size (Kg)', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtPackagingSizeFive,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                                                            ],
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert packaging size (Kg)',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              )
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15.h,),
                                                //Product 5 #2
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //Unit Price #5
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Unit price', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            controller: txtUnitPriceFive,
                                                            onChanged: (value){
                                                              setState(() {
                                                                double unitPrice = double.parse(value.replaceAll(',', ''));

                                                                if(txtQuantityFive.text.isEmpty == true || txtQuantityFive.text == ''){
                                                                  txtQuantityFive.text = '1';
                                                                  totalFive = double.parse(txtQuantityFive.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalFive.text = formatCurrency(totalFive);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                } else {
                                                                  totalFive = double.parse(txtQuantityFive.text) * unitPrice;
                                                                  totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;

                                                                  txtTotalFive.text = formatCurrency(totalFive);
                                                                  txtTotalPrice.text = formatCurrency(totalPrice);
                                                                }

                                                              });
                                                            },
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert unit price',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    //Total Price #5
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalFive,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          // Text('Product Name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: Color(0xFF787878))),
                                                          // Text('data1'),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 25.h,),
                                                const Divider(),
                                                SizedBox(height: 25.h,),
                                                //Row for Total Price
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 140.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Total', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                          SizedBox(height: 5.h,),
                                                          TextFormField(
                                                            readOnly: true,
                                                            controller: txtTotalPrice,
                                                            decoration: InputDecoration(
                                                              hintText: 'Insert total',
                                                              enabledBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderSide: const BorderSide(width: 0.0),
                                                                borderRadius: BorderRadius.circular(10.0),
                                                              ),
                                                              prefixIcon: SizedBox(
                                                                width: 25.w,
                                                                child: DropdownButtonFormField<String>(
                                                                  value: selectedCurrency,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      selectedCurrency = newValue!;
                                                                    });
                                                                  },
                                                                  decoration: InputDecoration(
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                      borderSide: BorderSide.none,
                                                                      borderRadius: BorderRadius.circular(4.0),
                                                                    )
                                                                  ),
                                                                  items: ['USD', 'EUR', 'GBP', 'JPY', 'IDR'].map<DropdownMenuItem<String>>((String value) {
                                                                    return DropdownMenuItem<String>(
                                                                      value: value,
                                                                      child: Text(value),
                                                                    );
                                                                  }).toList(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 3.h,),
                                                          //Exhange Rate Button
                                                          GestureDetector(
                                                            onTap: () {
                                                              txtExchangeValueTwo.text = formatCurrency(totalPrice);
                                                              double result = double.parse(txtExchangeValueOne.text) * double.parse(txtExchangeValueTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                              txtExchangeValueThree.text = formatCurrency(result);
                                                              showDialog(
                                                                context: context, 
                                                                builder: (_){
                                                                  return AlertDialog(
                                                                    title: Center(child: Text('Exchange rate calculator', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w800))),
                                                                    content: SizedBox(
                                                                      height: MediaQuery.of(context).size.height * 0.25,
                                                                      child: Column(
                                                                        children: [
                                                                          SizedBox(height: 15.h,),
                                                                          Row(
                                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              // 1
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  initialValue: '1',
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Insert total',
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedCurrency,
                                                                                        onChanged: null,
                                                                                        decoration: InputDecoration(
                                                                                          enabledBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          )
                                                                                        ),
                                                                                        items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w,),
                                                                              // 2
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtExchangeValueOne,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = double.parse(txtExchangeValueOne.text) * double.parse(txtExchangeValueTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                                      txtExchangeValueThree.text = formatCurrency(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Exchange rate',
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedExchangeCurrency,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedExchangeCurrency = newValue!;
                                                                                          });
                                                                                        },
                                                                                        decoration: InputDecoration(
                                                                                          enabledBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          )
                                                                                        ),
                                                                                        items: ['USD', 'EUR', 'GBP', 'JPY', 'IDR'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(height: 15.h,),
                                                                          const Divider(),
                                                                          SizedBox(height: 15.h,),
                                                                          Row(
                                                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              //3
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  controller: txtExchangeValueTwo,
                                                                                  onChanged: (value) {
                                                                                    setState(() {
                                                                                      double result = double.parse(txtExchangeValueOne.text) * double.parse(txtExchangeValueTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                                      txtExchangeValueThree.text = formatCurrency(result);
                                                                                    });
                                                                                  },
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Exchange rate',
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedCurrency,
                                                                                        onChanged: null,
                                                                                        decoration: InputDecoration(
                                                                                          enabledBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          )
                                                                                        ),
                                                                                        items: ['USD', 'EUR', 'GBP', 'JPY'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: 20.w,),
                                                                              SizedBox(
                                                                                width: 100.w,
                                                                                child: TextFormField(
                                                                                  readOnly: true,
                                                                                  controller: txtExchangeValueThree,
                                                                                  decoration: InputDecoration(
                                                                                    hintText: 'Exchange rate',
                                                                                    enabledBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    focusedBorder: OutlineInputBorder(
                                                                                      borderSide: const BorderSide(width: 0.0),
                                                                                      borderRadius: BorderRadius.circular(10.0),
                                                                                    ),
                                                                                    prefixIcon: SizedBox(
                                                                                      width: 25.w,
                                                                                      child: DropdownButtonFormField<String>(
                                                                                        value: selectedExchangeCurrency,
                                                                                        onChanged: (newValue) {
                                                                                          setState(() {
                                                                                            selectedExchangeCurrency = newValue!;
                                                                                          });
                                                                                        },
                                                                                        decoration: InputDecoration(
                                                                                          enabledBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          )
                                                                                        ),
                                                                                        items: ['USD', 'EUR', 'GBP', 'JPY', 'IDR'].map<DropdownMenuItem<String>>((String value) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: value,
                                                                                            child: Text(value),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Get.back();
                                                                        }, 
                                                                        child: const Text('Oke')
                                                                      )
                                                                    ],
                                                                  );
                                                                }
                                                              );
                                                            },
                                                            child: Text('Exchange rate calculator', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    //Mention and Remarks
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Should Mention
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Should mention name : ', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                SizedBox(height: 5.h,),
                                                FutureBuilder(
                                                  future: CompanyDataService(companyId),
                                                  builder: (context, snapshot){
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot.hasError) {
                                                      return Text('Error: ${snapshot.error}');
                                                    } else {
                                                      Map<String, dynamic> apiResponse = snapshot.data!;
                                                      List<dynamic> data = apiResponse['Data'];
                                                      CompanyData company = CompanyData.fromJson(data[0]);

                                                      shouldMentionOne = company.companyName;
                                                      shouldMentionTwo = company.companyAddress;

                                                      return Text('$shouldMentionOne\n$shouldMentionTwo', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w700,));
                                                    }
                                                  }
                                                )
                                              ],
                                            ),
                                          ),
                                          //Shipping Remarks
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
                                          //Remarks
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
                              ),
                              SizedBox(height: 10.h,),
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp, left: 5.sp, right: 5.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: (){
                                  
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          minimumSize: Size(60.w, 55.h),
                                          foregroundColor: const Color(0xFF2A85FF),
                                          backgroundColor: Colors.transparent,
                                          side: const BorderSide(
                                            color: Color(0xFF2A85FF), // Choose your desired border color
                                            width: 1.0, // Choose the border width
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Text('Export to PDF')
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          if(permissionAccess == 'Full access'){

                                          } else {
                                            showDialog(
                                              context: context, 
                                              builder: (_){
                                                return const AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('Anda tidak memiliki akses'),
                                                );
                                              }
                                            );
                                          }
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          minimumSize: Size(60.w, 55.h),
                                          foregroundColor: const Color(0xFF1F9F61),
                                          backgroundColor: Colors.transparent,
                                          side: const BorderSide(
                                            color: Color(0xFF1F9F61), // Choose your desired border color
                                            width: 1.0, // Choose the border width
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Center(
                                          child: Text('Approve')
                                        )
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          if(permissionAccess == 'Full access'){

                                          } else {
                                            showDialog(
                                              context: context, 
                                              builder: (_){
                                                return const AlertDialog(
                                                  title: Text('Error'),
                                                  content: Text('Anda tidak memiliki akses'),
                                                );
                                              }
                                            );
                                          }
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          minimumSize: Size(60.w, 55.h),
                                          foregroundColor: const Color(0xFFE47E7E),
                                          backgroundColor: Colors.transparent,
                                          side: const BorderSide(
                                            color: Color(0xFFE47E7E), // Choose your desired border color
                                            width: 1.0, // Choose the border width
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Center(
                                          child: Text('Reject')
                                        )
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                  
                                        }, 
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          alignment: Alignment.center,
                                          minimumSize: Size(60.w, 55.h),
                                          foregroundColor: const Color(0xFFFFFFFF),
                                          backgroundColor: const Color(0xFF2A85FF),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        child: const Center(
                                          child: Text('Submit')
                                        )
                                      )
                                    ],
                                  ),
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