import 'package:erpsystems/large/login.dart';
import 'package:erpsystems/large/purchasing%20module/newpurchasingimport.dart';
import 'package:erpsystems/large/purchasing%20module/newpurchasinglocal.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../index.dart';


class PurchasingIndexLarge extends StatefulWidget {
  const PurchasingIndexLarge({super.key});

  @override
  State<PurchasingIndexLarge> createState() => _PurchasingIndexLargeState();
}

class _PurchasingIndexLargeState extends State<PurchasingIndexLarge> {
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  TextEditingController txtSearchText = TextEditingController();
  int jumlahpendingPurchase = 4;
  int jumlahOrderInTransit = 2;
  String TopItem = 'ABC';
  
  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();

    // print(txtSearchText.text);
    return MaterialApp(
      title: 'Purchasing',
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
                          Get.to(SalesIndexLarge());
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
                          Get.off(LoginLarge());
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Purchasing Module', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2A85FF),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: DropdownButtonFormField(
                                      dropdownColor: Colors.white,
                                      value: null,
                                      hint: Text('Create New', style: TextStyle(color: Colors.white),),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'NEW-PO-002',
                                          child: Text('Purchase Import', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                        ),
                                        DropdownMenuItem(
                                          value: 'NEW-PO-003',
                                          child: Text('Purchase Local', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                        ),
                                      ], 
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(3.sp)
                                      ),
                                      icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                      onChanged: (value){
                                        if(value == 'NEW-PO-002'){
                                          Get.to(NewPurchasingImportLarge());
                                        } else if (value == 'NEW-PO-003'){
                                          Get.to(NewPurchasingLocalLarge());
                                        }
                                      }
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              //Card Overview
                              Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(12))
                                ),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    //Text and Filter Area
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Overview', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 9,
                                            child: DropdownButtonFormField(
                                              value: '001',
                                              items: const [
                                                DropdownMenuItem(
                                                  value: '001',
                                                  child: Text('This week', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                )
                                              ], 
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
                                              onChanged: (value){
                                            
                                              }
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //4 Card in a Row
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //Attandance Card
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              color: const Color.fromARGB(255, 220, 240, 229),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                    child: Row(
                                                      children: [
                                                        Image.asset('Icon/Attandance.png'),
                                                        SizedBox(width: 2.w,),
                                                        Text('Pending Purchase', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahpendingPurchase.toString(), style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Late Card
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              color: const Color.fromARGB(255, 237, 198, 198),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                    child: Row(
                                                      children: [
                                                        Image.asset('Icon/Late.png'),
                                                        SizedBox(width: 2.w,),
                                                        Text('Order In Transit', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahOrderInTransit.toString(), style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Absent Card
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              color: const Color.fromARGB(255, 240, 226, 191),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                    child: Row(
                                                      children: [
                                                        Image.asset('Icon/Absent.png'),
                                                        SizedBox(width: 2.w,),
                                                        Text('Top Item', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahOrderInTransit.toString(), style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Leave Card
                                          SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              color: const Color.fromARGB(255, 194, 202, 242),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                    child: Row(
                                                      children: [
                                                        Image.asset('Icon/Leave.png'),
                                                        SizedBox(width: 2.w,),
                                                        Text('Remaining Leave', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(TopItem, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12))
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Item in Transit', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(SeeAllSalesOrder());
                                            },
                                            child: Text('See All', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400, color: Color(0xFF2A85FF)))
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: (MediaQuery.of(context).size.height - 433.h),
                                      child: ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (BuildContext context, int index) {
                                          Color backgroundColor = index.isOdd ? Color(0xFFF8F8F8) : Color(0xFFF7F6FA);
                                      
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
                                                      Text('ABC Company', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600,)),
                                                      SizedBox(height: 3.h,),
                                                      Text('Next order 27/8/2023', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400,)),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      // Get.to(AddCustomerSettingLarge());
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
                                          );
                                        }
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 15.h,),
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12))
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(top: 5.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Item in Transit (Local)', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(SeeAllSalesOrder());
                                            },
                                            child: Text('See All', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400, color: Color(0xFF2A85FF)))
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.h,),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: (MediaQuery.of(context).size.height - 433.h),
                                      child: ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (BuildContext context, int index) {
                                          Color backgroundColor = index.isOdd ? Color(0xFFF8F8F8) : Color(0xFFF7F6FA);
                                      
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
                                                      Text('ABC Company', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600,)),
                                                      SizedBox(height: 3.h,),
                                                      Text('Next order 27/8/2023', style: TextStyle(fontSize: 3.sp, fontWeight: FontWeight.w400,)),
                                                    ],
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      // Get.to(AddCustomerSettingLarge());
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
                                          );
                                        }
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 15.h,),
                            ],
                          ),
                        ),
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