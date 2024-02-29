import 'package:erpsystems/medium/analytics/analyticsindex.dart';
import 'package:erpsystems/medium/finance/financeindex.dart';
import 'package:erpsystems/medium/hr/hrindex.dart';
import 'package:erpsystems/medium/login.dart';
import 'package:erpsystems/medium/purchase/purchaseindex.dart';
import 'package:erpsystems/medium/sales/salesindex.dart';
import 'package:erpsystems/medium/setting/settingindex.dart';
import 'package:erpsystems/medium/template/indextemplatemedium.dart';
import 'package:erpsystems/medium/warehouse/warehouseindex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DocumentMediumIndex extends StatefulWidget {
  const DocumentMediumIndex({super.key});

  @override
  State<DocumentMediumIndex> createState() => _DocumentMediumIndexState();
}

class _DocumentMediumIndexState extends State<DocumentMediumIndex> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String companyId = '';
  String profileName = '';
  String companyName = '';
  bool isLoading = false;
  bool isMenu = false;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venken ERP Systems',
      home: Scaffold(
        body: isLoading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Menu
              if(isMenu == true)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.sp, right: 3.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60.h,),
                        //Dashboard Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const IndexTemplateMedium());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/DashboardInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Dashboard', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Sales Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const SalesMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/SalesInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Sales Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Purchasing Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const PurchaseMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/PurchasingInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Purchasing Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Finance Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const FinanceMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/FinanceInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Finance Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Warehouse Module Button
                        ElevatedButton(
                        onPressed: (){
                          Get.to(const WarehouseMediumIndex());
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
                              width: 10.w,
                              alignment: Alignment.centerLeft,
                              child: Image.asset('Icon/WarehouseInactive.png'),
                            ),
                            SizedBox(width: 3.w),
                            Text('Warehouse Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                          ],
                        )
                      ),
                        SizedBox(height: 10.h,),
                        //HR Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const HRMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/HRInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('HR Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Analytics Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const AnalyticsMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/AnalyticsInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Analytics Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Document Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const DocumentMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/DocumentActive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Document Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 35.h,),
                        const Divider(),
                        //Setting Module Button
                        ElevatedButton(
                          onPressed: (){
                            Get.to(const SettingMediumIndex());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/SettingInactive.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Setting Module', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                        SizedBox(height: 10.h,),
                        //Logout Button
                        ElevatedButton(
                          onPressed: (){
                            // GetStorage().
                            Get.off(const LoginMedium());
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
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/Logout.png'),
                              ),
                              SizedBox(width: 3.w),
                              Text('Logout', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w400),)
                            ],
                          )
                        ),
                      ],
                    ),
                  )
                ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Search Bar and Profile
                    Padding(
                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 5.sp, right: 7.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if(isMenu == true){
                                  isMenu = false;
                                } else if (isMenu == false){
                                  isMenu = true;
                                }
                              });
                            },
                            child: const Text('Menu')
                          ),
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
                                title: Text(profileName, style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w300),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //Content
                  ],
                )
              )
            ]
          )
        )
      ),
    );
  }
}