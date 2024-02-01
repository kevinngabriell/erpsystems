import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/sales%20module/newprofit.dart';
import 'package:erpsystems/large/sales%20module/newsalesorder.dart';
import 'package:erpsystems/large/sales%20module/newsppb.dart';
import 'package:erpsystems/large/sales%20module/seeallprofitlist.dart';
import 'package:erpsystems/large/sales%20module/seeallrepeatorder.dart';
import 'package:erpsystems/large/sales%20module/seeallsalesorder.dart';
import 'package:erpsystems/large/sales%20module/seeallsppb.dart';
import 'package:erpsystems/large/sales%20module/seeallundernego.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
import 'package:erpsystems/large/template/settingtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SalesIndexLarge extends StatefulWidget {
  const SalesIndexLarge({super.key});

  @override
  State<SalesIndexLarge> createState() => _SalesIndexLargeState();
}

class _SalesIndexLargeState extends State<SalesIndexLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String jumlahSales = '2';
  String KPITarget = '4';
  String InTransit = '5';
  String TopItem = 'xxxx Product';

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();

    return MaterialApp(
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
                          foregroundColor: const Color(0xFF2A85FF),
                          backgroundColor: const Color(0xfFF4F4F4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/SalesActive.png'),
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
                          Get.to(const PurchasingTemplateLarge());
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
                          Get.to(const SettingTemplateLarge());
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sales Module', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
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
                                        value: 'NEW-SO-002',
                                        child: Text('New Sales Order', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                      ),
                                      DropdownMenuItem(
                                        value: 'NEW-SO-003',
                                        child: Text('New SPPB', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                      ),
                                      DropdownMenuItem(
                                        value: 'NEW-SO-004',
                                        child: Text('New Profit', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                      ),
                                      DropdownMenuItem(
                                        value: 'NEW-SO-005',
                                        child: Text('Calculator CIF', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                      )
                                    ], 
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(3.sp)
                                    ),
                                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                                    onChanged: (value){
                                      if(value == 'NEW-SO-002'){
                                        Get.to(NewSalesIndexLarge());
                                      } else if (value == 'NEW-SO-003'){
                                        Get.to(NewSPPBLarge());
                                      } else if (value == 'NEW-SO-004'){
                                        Get.to(NewProfitLarge());
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
                                                      Text('Current Sales', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp, top: 3.sp),
                                                  child: Text(jumlahSales, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                ),
                                              ],
                                            )
                                          ),
                                        ),
                                        //Late Card
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
                                                      Image.asset('Icon/Late.png'),
                                                      SizedBox(width: 2.w,),
                                                      Text('KPI Target', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp, top: 3.sp),
                                                  child: Text(KPITarget, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                ),
                                              ],
                                            )
                                          ),
                                        ),
                                        //Absent Card
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
                                                      Image.asset('Icon/Absent.png'),
                                                      SizedBox(width: 2.w,),
                                                      Text('In Transit', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp, top: 3.sp),
                                                  child: Text(InTransit, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                ),
                                              ],
                                            )
                                          ),
                                        ),
                                        //Leave Card
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
                                                      Image.asset('Icon/Leave.png'),
                                                      SizedBox(width: 2.w,),
                                                      Text('Top Item', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w600),),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp, top: 3.sp),
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
                            //2 Card
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width - 90.w)/ 2,
                                  child: Card(
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
                                                Text('Repeat Order Reminder', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(SeeAllRepeatOrderLarge());
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
                                ),
                                SizedBox(
                                  width: (MediaQuery.of(context).size.width - 90.w)/ 2,
                                  child: Card(
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
                                                Text('Under Negotiation List', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(SeeAllUnderNego());
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
                                ),
                              ],
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
                                          Text('Sales Order List', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(SeeAllSalesOrder());
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
                                          Text('SPPB List', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(SeeAllSPPBLarge());
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
                                          Text('Profit List', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: () {
                                              Get.to(SeeAllProfitLarge());
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
                            SizedBox(height: 5.h,),
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