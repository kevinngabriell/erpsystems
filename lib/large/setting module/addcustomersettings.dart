
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/services/settings/customerdataservices.dart';
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


class AddCustomerSettingLarge extends StatefulWidget {
  const AddCustomerSettingLarge({super.key});

  @override
  State<AddCustomerSettingLarge> createState() => _AddCustomerSettingLargeState();
}

class _AddCustomerSettingLargeState extends State<AddCustomerSettingLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String companyId = '';

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtCompanyAddress = TextEditingController();
  TextEditingController txtCompanyPhone = TextEditingController();
  TextEditingController txtCompanyPICName = TextEditingController();
  TextEditingController txtCompanyPICContact = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();
    companyId = storage.read('companyId').toString();

    return MaterialApp(
      title: 'Add New Customer Configuration',
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
                              child: Text('Customer settings', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 10.h,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Add New Customer Information Title
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, right: 5.sp),
                                      child: Text('Add New Customer', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                    ),
                                    SizedBox(height: 10.h,),
                                    //Text Form New Customer
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 10.sp),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          children: [
                                            //Customer Name & Address
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                //Customer Name 
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Customer Name'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtCompanyName,
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
                                                //Customer Address
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Customer Address'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        maxLines: 3,
                                                        controller: txtCompanyAddress,
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
                                              ],
                                            ),
                                            SizedBox(height: 20.h,),
                                            //Customer Phone Number & PIC Name
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                //Customer Phone Number
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Customer Phone Number'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtCompanyPhone,
                                                        decoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: const BorderSide(width: 0.0),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          hintText: '(021) xxxx xxxx'
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ),
                                                //Customer PIC Name
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Customer PIC Name'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtCompanyPICName,
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
                                            //Customer PIC Contact
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                //Customer PIC Contact
                                                SizedBox(
                                                  width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text('Customer PIC Contact'),
                                                      SizedBox(height: 5.h,),
                                                      TextFormField(
                                                        controller: txtCompanyPICContact,
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
                                            SizedBox(height: 50.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: (){
                                                    insertCustomerData(txtCompanyName.text, txtCompanyAddress.text, txtCompanyPhone.text, txtCompanyPICName.text, txtCompanyPICContact.text, companyId, context);
                                                  }, 
                                                  style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    alignment: Alignment.centerLeft,
                                                    minimumSize: Size(25.w, 40.h),
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