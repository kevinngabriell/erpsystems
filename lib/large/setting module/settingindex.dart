
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/customersettings.dart';
import 'package:erpsystems/large/setting%20module/internalsettings.dart';
import 'package:erpsystems/large/setting%20module/originsettings.dart';
import 'package:erpsystems/large/setting%20module/packagingsettings.dart';
import 'package:erpsystems/large/setting%20module/paymentsetting.dart';
import 'package:erpsystems/large/setting%20module/productsettings.dart';
import 'package:erpsystems/large/setting%20module/shippingsettingslarge.dart';
import 'package:erpsystems/large/setting%20module/termsetting.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
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


class SettingIndexLarge extends StatefulWidget {
  const SettingIndexLarge({super.key});

  @override
  State<SettingIndexLarge> createState() => _SettingIndexLargeState();
}

class _SettingIndexLargeState extends State<SettingIndexLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();

    return MaterialApp(
      title: 'Settings',
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
                            Text('Setting', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                            SizedBox(height: 10.h,),
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12))
                              ),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  //4 Cards
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Customer Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(CustomerSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Customer.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Customer', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Shipping Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(ShippingSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Shipping.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Supplier', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Payment Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(PaymentSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Payment.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Payment', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Term Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(TermSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Term.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Term', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  //4 Cards
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        //Product Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(ProductSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Product.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Product', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Packaging Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(PackagingSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Packaging.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Packaging', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Origin Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(OriginSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Flag.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Origin', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Internal Card
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(InternalSettingLarge());
                                          },
                                          child: SizedBox(
                                            width: (MediaQuery.of(context).size.width - 100.w) / 4,
                                            child: Card(
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 15.h,),
                                                  Image.asset('Icon/Settings.png'),
                                                  SizedBox(height: 10.h,),
                                                  Text('Internal', style: TextStyle(color: Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w400),),
                                                  SizedBox(height: 15.h,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
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