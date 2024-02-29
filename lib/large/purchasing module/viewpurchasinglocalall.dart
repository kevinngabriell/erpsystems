// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/login.dart';
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/large/purchasing%20module/viewpurchasinglocaldetail.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/services/purchase/purchasedataservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ViewPurchasingLocalAllLarge extends StatefulWidget {
  const ViewPurchasingLocalAllLarge({super.key});

  @override
  State<ViewPurchasingLocalAllLarge> createState() => _ViewPurchasingLocalAllLargeState();
}

class _ViewPurchasingLocalAllLargeState extends State<ViewPurchasingLocalAllLarge> {
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String permissionAccess = '';
  bool isLoading = false;
  TextEditingController txtSearchText = TextEditingController();
  bool isSearch = false;

  late Future<List<Map<String, dynamic>>> AllPOLocalList;
  List<Map<String, String>> listMonths = [];
  List<Map<String, String>> listYears = [];
  String selectedMonth = '';
  String selectedYear = '';

  List<String> poNumbers = [];
  List<String> poDate = [];
  List<String> poStatus = [];
  List<String> poSupplier = [];
  List<String> poShipmentDate = [];
  List<String> poPayment = [];
  List<String> poProductName1 = [];
  List<String> poUnitPrice1 = [];
  List<String> poQuantity1 = [];
  List<String> poPackagingSize1 = [];
  List<String> poProductName2 = [];
  List<String> poUnitPrice2 = [];
  List<String> poQuantity2 = [];
  List<String> poPackagingSize2 = [];
  List<String> poProductName3 = [];
  List<String> poUnitPrice3 = [];
  List<String> poQuantity3 = [];
  List<String> poPackagingSize3 = [];
  List<String> poProductName4 = [];
  List<String> poUnitPrice4 = [];
  List<String> poQuantity4 = [];
  List<String> poPackagingSize4 = [];
  List<String> poProductName5 = [];
  List<String> poUnitPrice5 = [];
  List<String> poQuantity5 = [];
  List<String> poPackagingSize5 = [];
  List<double> Total1 = [];
  List<double> Total2 = [];
  List<double> Total3 = [];
  List<double> Total4 = [];
  List<double> Total5 = [];
  List<double> VAT = [];
  List<double> TotalPrice = [];

  @override
  void initState() {
    super.initState();
    AllPOLocalList = allPurchaseLocal();
    getMonth();
    getYear();
  }

  Future<void> getYear() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.listYear),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listYears = (data['Data'] as List)
                .map((year) => Map<String, String>.from(year))
                .toList();
            selectedYear = listYears[0]['year']!;
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

  Future<void> getMonth() async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.get(
        Uri.parse(ApiEndpoints.listMonth),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['StatusCode'] == 200) {
          setState(() {
            listMonths = (data['Data'] as List)
                .map((month) => Map<String, String>.from(month))
                .toList();
            selectedMonth = listMonths[0]['month_id']!;
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
  
  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();
    
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
                              Text('All Purchase Local', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Month'),
                                            SizedBox(height: 10.h,),
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width - 250.w) / 3,
                                              child: DropdownButtonFormField<String>(
                                                value: selectedMonth,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedMonth = newValue!;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                ),
                                                items: listMonths.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> month) {
                                                      return DropdownMenuItem<String>(
                                                        value: month['month_id'],
                                                        child: Text(month['month_name']!),
                                                      );
                                                    },
                                                  ).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 5.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Year'),
                                            SizedBox(height: 10.h,),
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width - 250.w) / 3,
                                              child: DropdownButtonFormField<String>(
                                                value: selectedYear,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    selectedYear = newValue!;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: const BorderSide(width: 0.0),
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                ),
                                                items: listYears.map<DropdownMenuItem<String>>(
                                                    (Map<String, String> year) {
                                                      return DropdownMenuItem<String>(
                                                        value: year['year'],
                                                        child: Text(year['year']!),
                                                      );
                                                    },
                                                  ).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 5.w,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Purchase Order Number'),
                                            SizedBox(height: 10.h,),
                                            SizedBox(
                                              width: (MediaQuery.of(context).size.width - 250.w) / 2,
                                              child: TextFormField(
                                                controller: txtSearchText,
                                                decoration: InputDecoration(
                                                  hintText: 'Purchase Order Number',
                                                  filled: false,
                                                  enabledBorder: OutlineInputBorder(
                                                    // borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    // borderSide: BorderSide.none,
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  )
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 15.w,),
                                        ElevatedButton(
                                          onPressed: (){
                                            setState(() {
                                              isSearch = true;
                                            });
                                          }, 
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            alignment: Alignment.centerLeft,
                                            minimumSize: Size(20.w, 55.h),
                                            foregroundColor: Colors.white,
                                            backgroundColor: const Color(0xFF2A85FF),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8)
                                            ),
                                          ),
                                          child: Text('Search', style: TextStyle(fontSize: 4.sp))
                                        )
                                      ],
                                    )
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 9,
                                    child: ElevatedButton(
                                      onPressed: (){
                                        createExcelLocal(poNumbers, poDate, poStatus, poSupplier, poShipmentDate, poPayment, poProductName1, poQuantity1, poPackagingSize1, poUnitPrice1, Total1, poProductName2, poQuantity2, poPackagingSize2, poUnitPrice2, Total2 ,poProductName3, poQuantity3, poPackagingSize3, poUnitPrice3, Total3 ,poProductName4, poQuantity4, poPackagingSize4, poUnitPrice4, Total4,  poProductName5, poQuantity5, poPackagingSize5, poUnitPrice5, Total5, VAT, TotalPrice);
                                      }, 
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        alignment: Alignment.centerLeft,
                                        minimumSize: Size(20.w, 55.h),
                                        foregroundColor: const Color(0xFF1F9F61),
                                        backgroundColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        side: const BorderSide(
                                          color: Color(0xFF1F9F61), // Choose your desired border color
                                          width: 1.0, // Choose the border width
                                        ),
                                      ),
                                      child: Text('Export to Excel', style: TextStyle(fontSize: 4.sp))
                                    )
                                  )
                                ],
                              ),
                              SizedBox(height: 45.h,),
                              if(isSearch == true)
                                const Text('ble'),
                              if(isSearch == false)
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: (MediaQuery.of(context).size.height - 433.h),
                                  child: FutureBuilder<List<Map<String, dynamic>>>(
                                    future: AllPOLocalList,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return ListView.builder(
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context, int index) {
                                          Color backgroundColor = index.isOdd ? const Color(0xFFF8F8F8) : const Color(0xFFF7F6FA);
                                                
                                          return Container(
                                            width: MediaQuery.of(context).size.width,
                                            color: backgroundColor,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 3.sp, bottom: 3.sp),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('VK/--/--/----', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600,)),
                                                      SizedBox(height: 3.h,),
                                                      Text('Purchase date  - ', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400,)),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (){

                                                    }, 
                                                    style: ElevatedButton.styleFrom(
                                                      elevation: 0,
                                                      alignment: Alignment.centerLeft,
                                                      minimumSize: Size(20.w, 40.h),
                                                      foregroundColor: Colors.white,
                                                      backgroundColor: const Color(0xFF2A85FF),
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                    ),
                                                    child: Text('Detail', style: TextStyle(fontSize: 4.sp))
                                                  )
                                                ],
                                              ),
                                            )
                                          );}
                                        );
                                      } else if (snapshot.hasData) {
                                        List<Map<String, dynamic>> data = snapshot.data!;
                                        
                                        return ListView.builder(
                                          itemCount: data.length,
                                            itemBuilder: (BuildContext context, int index){
                                            Color backgroundColor = index.isOdd ? const Color(0xFFF8F8F8) : const Color(0xFFF7F6FA);
                                            poNumbers.add(data[index]['PONumber']);
                                            poDate.add(data[index]['PODate']);
                                            poSupplier.add(data[index]['supplier_name']);
                                            poStatus.add(data[index]['PO_Status_Name']);
                                            poShipmentDate.add(data[index]['shipment_name']);
                                            poPayment.add(data[index]['payment_name']);
                                            poProductName1.add(data[index]['ProductName1'] ?? '');
                                            poUnitPrice1.add(data[index]['UnitPrice1'] ?? '');
                                            poQuantity1.add(data[index]['Quantity1'] ?? '');
                                            poPackagingSize1.add(data[index]['PackagingSize1'] ?? '');
                                            poProductName2.add(data[index]['ProductName2'] ?? '');
                                            poUnitPrice2.add(data[index]['UnitPrice2'] ?? '0');
                                            poQuantity2.add(data[index]['Quantity2'] ?? '0');
                                            poPackagingSize2.add(data[index]['PackagingSize2'] ?? '');
                                            poProductName3.add(data[index]['ProductName3'] ?? '');
                                            poUnitPrice3.add(data[index]['UnitPrice3'] ?? '0');
                                            poQuantity3.add(data[index]['Quantity3'] ?? '0');
                                            poPackagingSize3.add(data[index]['PackagingSize3'] ?? '');
                                            poProductName4.add(data[index]['ProductName4'] ?? '');
                                            poUnitPrice4.add(data[index]['UnitPrice4'] ?? '0');
                                            poQuantity4.add(data[index]['Quantity4'] ?? '0');
                                            poPackagingSize4.add(data[index]['PackagingSize4'] ?? '');
                                            poProductName5.add(data[index]['ProductName5'] ?? '');
                                            poUnitPrice5.add(data[index]['UnitPrice5'] ?? '0');
                                            poQuantity5.add(data[index]['Quantity5'] ?? '0');
                                            poPackagingSize5.add(data[index]['PackagingSize5'] ?? '');
                                            Total1.add(double.parse(data[index]['Quantity1']) * double.parse(data[index]['UnitPrice1']));
                                            Total2.add((double.parse(data[index]['Quantity2'] ?? '0') * double.parse(data[index]['UnitPrice2'] ?? '0')));
                                            Total3.add(double.parse(data[index]['Quantity3'] ?? '0') * double.parse(data[index]['UnitPrice3'] ?? '0'));
                                            Total4.add(double.parse(data[index]['Quantity4'] ?? '0') * double.parse(data[index]['UnitPrice4'] ?? '0'));
                                            Total5.add(double.parse(data[index]['Quantity5'] ?? '0') * double.parse(data[index]['UnitPrice5'] ?? '0'));
                                            double itemVAT = (Total1[index] + Total2[index] + Total3[index] + Total4[index] + Total5[index]) * 0.11;
                                            VAT.add(itemVAT);
                                            double total = Total1[index] + Total2[index] + Total3[index] + Total4[index] + Total5[index] + VAT[index];
                                            TotalPrice.add(total);
                                            return Container(
                                              width: MediaQuery.of(context).size.width,
                                              color: backgroundColor,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 3.sp, bottom: 3.sp),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(data[index]['ProductName1'] + ' | ' + data[index]['PONumber'], style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600,)),
                                                        SizedBox(height: 3.h,),
                                                        // ignore: prefer_interpolation_to_compose_strings
                                                        Text('Purchase date ' + data[index]['PODate'], style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400,)),
                                                      ],
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        Get.to(ViewPurchasingLocalDetailLarge(data[index]['PONumber']));
                                                      }, 
                                                      style: ElevatedButton.styleFrom(
                                                        elevation: 0,
                                                        alignment: Alignment.center,
                                                        minimumSize: Size(35.w, 50.h),
                                                        foregroundColor: Colors.white,
                                                        backgroundColor: const Color(0xFF2A85FF),
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      ),
                                                      child: Text(data[index]['PO_Status_Name'], style: TextStyle(fontSize: 4.sp))
                                                    )
                                                  ],
                                                ),
                                              )
                                            );}
                                          );
                                      } else {
                                        return const Center(
                                          child: Text('There is no data for local purchasing'),
                                        );
                                      }    
                                    }   
                                  )
                                ),
                              SizedBox(height: 10.h,),
                            ],
                          ),
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