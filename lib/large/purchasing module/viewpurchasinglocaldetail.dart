// ignore_for_file: avoid_print, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors

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
import 'package:erpsystems/services/purchase/purchasedataservices.dart';
import 'package:erpsystems/services/settings/companydataservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ViewPurchasingLocalDetailLarge extends StatefulWidget {
  final PONumber;
  const ViewPurchasingLocalDetailLarge(this.PONumber);

  @override
  State<ViewPurchasingLocalDetailLarge> createState() => _ViewPurchasingLocalDetailLargeState();
}

class _ViewPurchasingLocalDetailLargeState extends State<ViewPurchasingLocalDetailLarge> {
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String permissionAccess = '';
  bool isLoading = false;
  TextEditingController txtSearchText = TextEditingController();
  List<Map<String, String>> listSuppliers = [];
  List<Map<String, String>> listShipments = [];
  List<Map<String, String>> listPayments = [];
  List<Map<String, String>> listCurrency= [];
  String companyId = '';
  double totalOne = 0;
  double totalTwo = 0;
  double totalThree = 0;
  double totalFour = 0;
  double totalFive = 0;
  double VAT = 0;
  double totalPrice = 0;
  TextEditingController txtExchangeValueThree = TextEditingController();
  TextEditingController txtExchangeValueOne = TextEditingController(text: '15663.45');
  TextEditingController txtExchangeValueTwo = TextEditingController();
  TextEditingController txtWeightValue = TextEditingController();
  TextEditingController txtWeightResult = TextEditingController();
  String selectedCurrency = '';
  String selectedExchangeCurrency = '';
  String selectedWeightUnit = 'Pounds';
  String selectedTargetWeightUnit = 'Kilograms';
  String shouldMentionOne = '';
  String shouldMentionTwo = '';
  String username = "";
  String statusPO = "";
  String insertDt = "";
  String supplierName = '';
  String paymentName = '';
  String deliveryName = '';

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

  //Value to be inserted
  String PONumber = '';
  String selectedSupplier = '';
  DateTime? PurchaseDate;
  String selectedShipment = '';
  String selectedPayment = '';
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
  TextEditingController txtVAT = TextEditingController();
  TextEditingController txtTotalPrice = TextEditingController();

  String formatCurrency(double value) {
    return NumberFormat.currency(locale: 'en_US', decimalDigits: 2, symbol: '').format(value);
  }

  @override
  void initState() {
    super.initState();
    getSupplier();
    getPayment();
    getShipping();
    getCurrency();
  }

  Future<void> getCurrency() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.currencyList),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listCurrency = (data['Data'] as List)
                .map((currency) => Map<String, String>.from(currency))
                .toList();
            selectedCurrency = listCurrency[4]['currency_id']!;
            selectedExchangeCurrency = listCurrency[0]['currency_id']!;
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
  
  @override
  Widget build(BuildContext context) {
    profileName = storage.read('firstName').toString();
    username = storage.read('username').toString();
    permissionAccess = storage.read('permissionAccess').toString();

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
                        child: FutureBuilder<PurchaseDetail>(
                          future: fetchDetailPurchase(widget.PONumber),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              PONumber = snapshot.data!.data['Details'][0]['PONumber'];
                              selectedSupplier = snapshot.data!.data['Details'][0]['POSupplier'];
                              String PODateString = snapshot.data!.data['Details'][0]['PODate'];
                              PurchaseDate = DateTime.parse(PODateString);
                              String PICName = snapshot.data!.data['Details'][0]['POSupplierPIC'];
                              selectedPayment = snapshot.data!.data['Details'][0]['POPayment'];
                              selectedShipment = snapshot.data!.data['Details'][0]['POShipment'];
                              statusPO = snapshot.data!.data['Details'][0]['POStatusName'];
                              insertDt = snapshot.data!.data['Details'][0]['InsertDt'];
                              supplierName = snapshot.data!.data['Details'][0]['SupplierName'];
                              paymentName = snapshot.data!.data['Details'][0]['PaymentName'];
                              deliveryName = snapshot.data!.data['Details'][0]['ShipmentName'];
                              txtProductNameOne.text = snapshot.data!.data['Items 1'][0]['POProductNameOne'] ?? '';
                              txtQuantityOne.text = snapshot.data!.data['Items 1'][0]['POQuantityOne'] ?? '';
                              txtPackagingSizeOne.text = snapshot.data!.data['Items 1'][0]['POPackagingSizeOne'] ?? '';
                              txtUnitPriceOne.text = snapshot.data!.data['Items 1'][0]['POUnitPriceOne'] ?? '';
                              txtProductNameTwo.text = snapshot.data!.data['Items 2'][0]['POProductNameTwo'] ?? '';
                              txtQuantityTwo.text = snapshot.data!.data['Items 2'][0]['POQuantityTwo'] ?? '';
                              txtPackagingSizeTwo.text = snapshot.data!.data['Items 2'][0]['POPackagingSizeTwo'] ?? '';
                              txtUnitPriceTwo.text = snapshot.data!.data['Items 2'][0]['POUnitPriceTwo'] ?? '';
                              txtProductNameThree.text = snapshot.data!.data['Items 3'][0]['POProductNameThree'] ?? '';
                              txtQuantityThree.text = snapshot.data!.data['Items 3'][0]['POQuantityThree'] ?? '';
                              txtPackagingSizeThree.text = snapshot.data!.data['Items 3'][0]['POPackagingSizeThree'] ?? '';
                              txtUnitPriceThree.text = snapshot.data!.data['Items 3'][0]['POUnitPriceThree'] ?? '';
                              txtProductNameFour.text = snapshot.data!.data['Items 4'][0]['POProductNameFour'] ?? '';
                              txtQuantityFour.text = snapshot.data!.data['Items 4'][0]['POQuantityFour'] ?? '';
                              txtPackagingSizeFour.text = snapshot.data!.data['Items 4'][0]['POPackagingSizeFour'] ?? '';
                              txtUnitPriceFour.text = snapshot.data!.data['Items 4'][0]['POUnitPriceFour'] ?? '';
                              txtProductNameFive.text = snapshot.data!.data['Items 5'][0]['POProductNameFive'] ?? '';
                              txtQuantityFive.text = snapshot.data!.data['Items 5'][0]['POQuantityFive'] ?? '';
                              txtPackagingSizeFive.text = snapshot.data!.data['Items 5'][0]['POPackagingSizeFive'] ?? '';
                              txtUnitPriceFive.text = snapshot.data!.data['Items 5'][0]['POUnitPriceFive'] ?? '';

                              if(txtQuantityOne.text.isEmpty == true || txtQuantityOne.text == '' || txtUnitPriceOne.text.isEmpty == true || txtUnitPriceOne.text == ''){
                                totalOne = 0;
                              } else {
                                totalOne = double.parse(txtQuantityOne.text) * double.parse(txtUnitPriceOne.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                txtTotalOne.text = formatCurrency(totalOne);
                              }
                            
                              if(txtQuantityTwo.text.isEmpty == true || txtQuantityTwo.text == '' || txtUnitPriceTwo.text.isEmpty == true || txtUnitPriceTwo.text == ''){
                                totalTwo = 0;
                              } else {
                                totalTwo = double.parse(txtQuantityTwo.text) * double.parse(txtUnitPriceTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                txtTotalTwo.text = formatCurrency(totalTwo);
                              }
                            
                              if(txtQuantityThree.text.isEmpty == true || txtQuantityThree.text == '' || txtUnitPriceThree.text.isEmpty == true || txtUnitPriceThree.text == ''){
                                totalThree = 0;
                              } else {
                                totalThree = double.parse(txtQuantityThree.text) * double.parse(txtUnitPriceThree.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                txtTotalThree.text = formatCurrency(totalThree);
                              }
                            
                              if(txtQuantityFour.text.isEmpty == true || txtQuantityFour.text == '' || txtUnitPriceFour.text.isEmpty == true || txtUnitPriceFour.text == ''){
                                totalFour = 0;
                              } else {
                                totalFour = double.parse(txtQuantityFour.text) * double.parse(txtUnitPriceFour.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                txtTotalFour.text = formatCurrency(totalFour);
                              }
                            
                              if(txtQuantityFive.text.isEmpty == true || txtQuantityFive.text == '' || txtUnitPriceFive.text.isEmpty == true || txtUnitPriceFive.text == ''){
                                totalFive = 0;
                              } else {
                                totalFive = double.parse(txtQuantityFive.text) * double.parse(txtUnitPriceFive.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                txtTotalFive.text = formatCurrency(totalFive);
                              }
                            
                              double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                              VAT = temp * (11/100);
                              totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                              txtVAT.text = formatCurrency(VAT);
                              txtTotalPrice.text = formatCurrency(totalPrice);

                              return Padding(
                                padding: EdgeInsets.only(left: 5.sp, top: 7.sp, bottom: 5.sp, right: 7.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Purchasing Module', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Status', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,),),
                                            SizedBox(height: 5.h,),
                                            Text(statusPO, style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w600,),),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Created Date', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,),),
                                            SizedBox(height: 5.h,),
                                            Text(insertDt, style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w600,),),
                                          ],
                                        ),
                                      ],
                                    ),
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
                                            child: Text('Purchase Order Local', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
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
                                                        }
                                                      )
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
                                                        readOnly: true,
                                                        initialValue: PODateString,
                                                        dateHintText: 'Input purchase date',
                                                        firstDate: DateTime(2023),
                                                        lastDate: DateTime(2100),
                                                        initialDate: PurchaseDate,
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
                            
                                                        },
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
                                                        initialValue: PICName,
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
                                                //Payment
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
                                          //Form Payment
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
                                                //Shipment Date
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
                                                                    totalOne = double.parse(txtQuantityOne.text) * double.parse(txtUnitPriceOne.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                    double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                    VAT = temp * (11/100);
                                                                    totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                    txtVAT.text = formatCurrency(VAT);
                                                                    txtTotalOne.text = formatCurrency(totalOne);
                                                                    txtTotalPrice.text = formatCurrency(totalPrice);
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
                                                                            child: Text('Weight Converter',
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
                                                                        double unitPrice = double.parse(value.replaceAll(',', ''));
                                          
                                                                        if(txtQuantityOne.text.isEmpty == true || txtQuantityOne.text == ''){
                                                                          txtQuantityOne.text = '1';
                                                                          totalOne = double.parse(txtQuantityOne.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalOne.text = formatCurrency(totalOne);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        } else {
                                                                          totalOne = double.parse(txtQuantityOne.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalOne.text = formatCurrency(totalOne);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        }
                            
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                        totalTwo = double.parse(txtQuantityTwo.text) * double.parse(txtUnitPriceTwo.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                        double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                        VAT = temp * (11/100);
                                                                        totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                        txtVAT.text = formatCurrency(VAT);
                                                                        txtTotalTwo.text = formatCurrency(totalTwo);
                                                                        txtTotalPrice.text = formatCurrency(totalPrice);
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
                                                                        double unitPrice = double.parse(value.replaceAll(',', ''));
                                          
                                                                        if(txtQuantityTwo.text.isEmpty == true || txtQuantityTwo.text == ''){
                                                                          txtQuantityTwo.text = '1';
                                                                          totalTwo = double.parse(txtQuantityTwo.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalTwo.text = formatCurrency(totalTwo);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        } else {
                                                                          totalTwo = double.parse(txtQuantityTwo.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalTwo.text = formatCurrency(totalTwo);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        }
                                                                        
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                        totalThree = double.parse(txtQuantityThree.text) * double.parse(txtUnitPriceThree.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                        double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                        VAT = temp * (11/100);
                                                                        totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                        txtVAT.text = formatCurrency(VAT);
                                                                        txtTotalThree.text = formatCurrency(totalThree);
                                                                        txtTotalPrice.text = formatCurrency(totalPrice);
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
                                                                        double unitPrice = double.parse(value.replaceAll(',', ''));
                                          
                                                                        if(txtQuantityThree.text.isEmpty == true || txtQuantityThree.text == ''){
                                                                          txtQuantityThree.text = '1';
                                                                          totalThree = double.parse(txtQuantityThree.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalThree.text = formatCurrency(totalThree);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        } else {
                                                                          totalThree = double.parse(txtQuantityThree.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalThree.text = formatCurrency(totalThree);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        }
                                                                        
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                        totalFour = double.parse(txtQuantityFour.text) * double.parse(txtUnitPriceFour.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                        double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                        VAT = temp * (11/100);
                                                                        totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                        txtVAT.text = formatCurrency(VAT);
                                                                        txtTotalFour.text = formatCurrency(totalFour);
                                                                        txtTotalPrice.text = formatCurrency(totalPrice);
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
                                                                        double unitPrice = double.parse(value.replaceAll(',', ''));
                                          
                                                                        if(txtQuantityFour.text.isEmpty == true || txtQuantityFour.text == ''){
                                                                          txtQuantityFour.text = '1';
                                                                          totalFour = double.parse(txtQuantityFour.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalFour.text = formatCurrency(totalFour);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        } else {
                                                                          totalFour = double.parse(txtQuantityFour.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalFour.text = formatCurrency(totalFour);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        }
                            
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                        totalFive = double.parse(txtQuantityFive.text) * double.parse(txtUnitPriceFive.text.replaceAll(RegExp(r'[^0-9.]'), ''));
                                                                        double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                        VAT = temp * (11/100);
                                                                        totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                        txtVAT.text = formatCurrency(VAT);
                                                                        txtTotalFive.text = formatCurrency(totalFive);
                                                                        txtTotalPrice.text = formatCurrency(totalPrice);
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
                                                                        double unitPrice = double.parse(value.replaceAll(',', ''));
                                          
                                                                        if(txtQuantityFive.text.isEmpty == true || txtQuantityFive.text == ''){
                                                                          txtQuantityFive.text = '1';
                                                                          totalFive = double.parse(txtQuantityFive.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalFive.text = formatCurrency(totalFive);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        } else {
                                                                          totalFive = double.parse(txtQuantityFive.text) * unitPrice;
                                                                          double temp = totalOne + totalTwo + totalThree + totalFour + totalFive;
                                                                          VAT = temp * (11/100);
                                                                          totalPrice = totalOne + totalTwo + totalThree + totalFour + totalFive + VAT;
                                                                          txtVAT.text = formatCurrency(VAT);
                                                                          txtTotalFive.text = formatCurrency(totalFive);
                                                                          txtTotalPrice.text = formatCurrency(totalPrice);
                                                                        }
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('VAT 11%', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600, color: const Color(0xFF787878))),
                                                                    SizedBox(height: 5.h,),
                                                                    TextFormField(
                                                                      readOnly: true,
                                                                      controller: txtVAT,
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 3.h,),
                                                                    Text(' ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w600, color: const Color(0xFF2A85FF)))
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
                                                                            items: listCurrency.map<DropdownMenuItem<String>>(
                                                                              (Map<String, String> currency) {
                                                                                return DropdownMenuItem<String>(
                                                                                  value: currency['currency_id'],
                                                                                  child: Text(currency['currency_name']!),
                                                                                );
                                                                              },
                                                                            ).toList(),
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
                                                                                                  items: listCurrency.map<DropdownMenuItem<String>>(
                                                                                                    (Map<String, String> currency) {
                                                                                                      return DropdownMenuItem<String>(
                                                                                                        value: currency['currency_id'],
                                                                                                        child: Text(currency['currency_name']!),
                                                                                                      );
                                                                                                    },
                                                                                                  ).toList(),
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
                                                                                                  items: listCurrency.map<DropdownMenuItem<String>>(
                                                                                                    (Map<String, String> currency) {
                                                                                                      return DropdownMenuItem<String>(
                                                                                                        value: currency['currency_id'],
                                                                                                        child: Text(currency['currency_name']!),
                                                                                                      );
                                                                                                    },
                                                                                                  ).toList(),
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
                                                                                                  items: listCurrency.map<DropdownMenuItem<String>>(
                                                                                                    (Map<String, String> currency) {
                                                                                                      return DropdownMenuItem<String>(
                                                                                                        value: currency['currency_id'],
                                                                                                        child: Text(currency['currency_name']!),
                                                                                                      );
                                                                                                    },
                                                                                                  ).toList(),
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
                                                                                                  items: listCurrency.map<DropdownMenuItem<String>>(
                                                                                                    (Map<String, String> currency) {
                                                                                                      return DropdownMenuItem<String>(
                                                                                                        value: currency['currency_id'],
                                                                                                        child: Text(currency['currency_name']!),
                                                                                                      );
                                                                                                    },
                                                                                                  ).toList(),
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
                                                          Text('Invoice Under :', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
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
                                                      child: const Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                    //Remarks
                                                    SizedBox(
                                                      width: (MediaQuery.of(context).size.width - 120.w) / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('Delivery Address :', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                                          SizedBox(height: 5.h,),
                                                          Text('Pergudangan Taman Tekno\nSektor XI Blok K3 No. 47, BSD - Tangerang\nTelp : 02175880017', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
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
                                                      if(permissionAccess == 'Full access'){
                                                        generatePOPDF(PONumber, shouldMentionOne, shouldMentionTwo, PurchaseDate!, PICName, supplierName, paymentName, deliveryName, txtProductNameOne.text, txtQuantityOne.text, txtPackagingSizeOne.text, txtUnitPriceOne.text, txtTotalOne.text, txtProductNameTwo.text, txtQuantityTwo.text, txtPackagingSizeTwo.text, txtUnitPriceTwo.text, txtTotalTwo.text, txtProductNameThree.text, txtQuantityThree.text, txtPackagingSizeThree.text, txtUnitPriceThree.text, txtTotalThree.text, txtProductNameFour.text, txtQuantityFour.text, txtPackagingSizeFour.text, txtUnitPriceFour.text, txtTotalFour.text, txtProductNameFive.text, txtQuantityFive.text, txtPackagingSizeFive.text, txtUnitPriceFive.text, txtTotalFive.text, txtVAT.text, txtTotalPrice.text);
                                                      } else {
                                                        showDialog(
                                                          context: context, 
                                                          builder: (_){
                                                            return const AlertDialog(
                                                              title: Text('Error'),
                                                              content: Text('You have no access to this feature. Please contact your administrator'),
                                                            );
                                                          }
                                                        );
                                                      }
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
                                                  if(statusPO == 'Approved')
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        if(permissionAccess == 'Full access'){
                                                          if(statusPO == 'Approved'){
                                                            approvePurchase(PONumber, username, context);
                                                          } else {
                                                            showDialog(
                                                              context: context, 
                                                              builder: (_){
                                                                return AlertDialog(
                                                                  title: const Text('Error'),
                                                                  content: const Text('This PO cannot be set on delivery !!'),
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
                                                          }
                                                        } else {
                                                          showDialog(
                                                            context: context, 
                                                            builder: (_){
                                                              return const AlertDialog(
                                                                title: Text('Error'),
                                                                content: Text('You have no access to this feature. Please contact your administrator'),
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
                                                        child: Text('On Delivery')
                                                      )
                                                    ),
                                                  if(statusPO == 'Draft')
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        if(permissionAccess == 'Full access'){
                                                          if(statusPO == 'Draft'){
                                                            approvePurchase(PONumber, username, context);
                                                          } else {
                                                            showDialog(
                                                              context: context, 
                                                              builder: (_){
                                                                return AlertDialog(
                                                                  title: const Text('Error'),
                                                                  content: const Text('This PO cannot be approve !!'),
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
                                                          }
                                                        } else {
                                                          showDialog(
                                                            context: context, 
                                                            builder: (_){
                                                              return const AlertDialog(
                                                                title: Text('Error'),
                                                                content: Text('You have no access to this feature. Please contact your administrator'),
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
                                                  
                                                  if(statusPO == 'Draft')
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        if(permissionAccess == 'Full access'){
                                                          if(statusPO == 'Draft'){
                                                            rejectPurchase(PONumber, username, context);
                                                          } else {
                                                            showDialog(
                                                              context: context, 
                                                              builder: (_){
                                                                return AlertDialog(
                                                                  title: const Text('Error'),
                                                                  content: const Text('This PO cannot be reject !!'),
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
                                                          }
                                                        } else {
                                                          showDialog(
                                                            context: context, 
                                                            builder: (_){
                                                              return const AlertDialog(
                                                                title: Text('Error'),
                                                                content: Text('You have no access to this feature. Please contact your administrator'),
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
                                                      if(permissionAccess == 'Full access'){
                                                        updatePurchaseLocal(PONumber, PurchaseDate.toString(), selectedSupplier, selectedShipment, selectedPayment, selectedCurrency, username, txtProductNameOne.text, txtQuantityOne.text, txtPackagingSizeOne.text, txtUnitPriceOne.text, txtProductNameTwo.text, txtQuantityTwo.text, txtPackagingSizeTwo.text, txtUnitPriceTwo.text, txtProductNameThree.text, txtQuantityThree.text, txtPackagingSizeThree.text, txtUnitPriceThree.text, txtProductNameFour.text, txtQuantityFour.text, txtPackagingSizeFour.text, txtUnitPriceFour.text, txtProductNameFive.text, txtQuantityFive.text, txtPackagingSizeFive.text, txtUnitPriceFive.text, context);
                                                      } else {
                                                        showDialog(
                                                          context: context, 
                                                          builder: (_){
                                                            return const AlertDialog(
                                                              title: Text('Error'),
                                                              content: Text('You have no access to this feature. Please contact your administrator'),
                                                            );
                                                          }
                                                        );
                                                      }
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
                                                      child: Text('Update')
                                                    )
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
                              );
                            }
                          }
                        ),
                      )
                    , if(txtSearchText.text != '')
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
                  ],
                )
              )
            ]
          )
        )
      )
    );
  }
}