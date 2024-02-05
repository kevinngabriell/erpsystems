
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/services/settings/companydataservices.dart';
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


class InternalSettingLarge extends StatefulWidget {
  const InternalSettingLarge({super.key});

  @override
  State<InternalSettingLarge> createState() => _InternalSettingLargeState();
}

class _InternalSettingLargeState extends State<InternalSettingLarge>  with TickerProviderStateMixin {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String companyId = '';
  String companyPhoneNumber = '021 2590 9871';
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtWebsite = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtIndustry = TextEditingController();

  TextEditingController txtTarget2024 = TextEditingController();
  TextEditingController txtTarget2025 = TextEditingController();
  TextEditingController txtTarget2026 = TextEditingController();
  TextEditingController txtTarget2027 = TextEditingController();
  TextEditingController txtTarget2028 = TextEditingController();
  TextEditingController txtTarget2029 = TextEditingController();
  TextEditingController txtTarget2030 = TextEditingController();
  TextEditingController txtTarget2031 = TextEditingController();

  late TabController tabController;
  late Future<List<Map<String, dynamic>>> userManagementList;
  List<Map<String, String>> limitUsers = [];
  String refferalIDValue = '';
  String limitUserValue = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    userManagementList = allUserService();
    getRefferalID();
  }

  Future<void> getRefferalID() async {
    final response = await http.get(
        Uri.parse(ApiEndpoints.limitUser)
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['StatusCode'] == 200) {
        setState(() {
          limitUsers = (data['Data'] as List)
              .map((limituser) => Map<String, String>.from(limituser))
              .toList();
          if (limitUsers.isNotEmpty) {
            refferalIDValue = limitUsers[0]['refferal_id']!;
            limitUserValue = limitUsers[0]['limit_user']!;
          }
        });
      } else {
        // Handle API error
        print('API, Failed to fetch data');
      }
    } else {
      // Handle HTTP error
      print('HTTP, Failed to fetch data');
    }
  }

  Future<void> updateRefferalandLimit ()async {
    
  }

  Future<void> getDetailUserPermission ()async {
    
  }

  Future<void> updateUserPermission () async {

  }

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();
    companyId = storage.read('companyId').toString();

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
                              child: Text('Internal settings', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),)
                            ),
                            SizedBox(height: 10.h,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: CompanyDataService(companyId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      Map<String, dynamic> apiResponse = snapshot.data!;
                                      List<dynamic> data = apiResponse['Data'];
                                      CompanyData company = CompanyData.fromJson(data[0]);

                                      txtCompanyName.text = company.companyName;
                                      txtAddress.text = company.companyAddress;
                                      txtPhoneNumber.text = company.companyPhone;
                                      txtWebsite.text = company.companyWeb;
                                      txtIndustry.text = company.companyIndustry;
                                      txtEmail.text = company.companyEmail;

                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          TabBar(
                                            isScrollable: false,
                                            controller: tabController,
                                            labelColor: const Color.fromRGBO(78, 195, 252, 1),
                                            unselectedLabelColor: Colors.black,
                                            tabs: [
                                              Tab( 
                                                child: Text(
                                                  'Company setting', 
                                                  style: TextStyle(
                                                    fontSize: 4.sp, 
                                                    fontWeight: FontWeight.w400,
                                                    //color: tabController.index == 0 ? Color.fromRGBO(78, 195, 252, 1) : Colors.black
                                                  ),
                                                ),
                                              ),
                                              Tab( 
                                                child: Text(
                                                  'Company target', 
                                                  style: TextStyle(
                                                    fontSize: 4.sp, 
                                                    fontWeight: FontWeight.w400,
                                                    //color: tabController.index == 0 ? Color.fromRGBO(78, 195, 252, 1) : Colors.black
                                                  ),
                                                ),
                                              ),
                                              Tab( 
                                                child: Text(
                                                  'User management', 
                                                  style: TextStyle(
                                                    fontSize: 4.sp, 
                                                    fontWeight: FontWeight.w400,
                                                    //color: tabController.index == 0 ? Color.fromRGBO(78, 195, 252, 1) : Colors.black
                                                  ),
                                                ),
                                              ),
                                            ]
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height,
                                            child: TabBarView(
                                              controller: tabController,
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                      child: Text('Company setting', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                                    ),
                                                    //Company Name & Phone Form
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          //Company Name
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company name', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    controller: txtCompanyName,
                                                                    readOnly: false,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: 'PT. ABXXXXXX'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 15.w,),
                                                          //Company Phone
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company phone number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    controller: txtPhoneNumber,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: '021 xxxxxxxx'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    //Company Website & Email
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          //Company Website        
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company website', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    controller: txtWebsite,
                                                                    readOnly: false,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: 'www.ABXX.com'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 15.w,),
                                                          //Company Email
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company email', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    controller: txtEmail,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: 'democompany@demo.id'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    //Company Address & Industry
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          //Company Address
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company address', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    maxLines: 3,
                                                                    controller: txtAddress,
                                                                    readOnly: false,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: 'Jl. Abcd'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(width: 15.w,),
                                                          //Company Industry
                                                          SizedBox(
                                                            width: (MediaQuery.of(context).size.width - 490) / 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company industry', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w500),),
                                                                SizedBox(height: 15.h,),
                                                                SizedBox(
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: TextFormField(
                                                                    controller: txtIndustry,
                                                                    decoration: InputDecoration(
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderSide: const BorderSide(width: 0.0),
                                                                        borderRadius: BorderRadius.circular(10.0),
                                                                      ),
                                                                      hintText: 'Finance'
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 50.h,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: (){
                                                              updateCompanyData(companyId, txtCompanyName.text, txtAddress.text, txtPhoneNumber.text, txtWebsite.text, txtIndustry.text, txtEmail.text, context);
                                                            }, 
                                                            style: ElevatedButton.styleFrom(
                                                              elevation: 0,
                                                              alignment: Alignment.center,
                                                              minimumSize: const Size(60, 50),
                                                              foregroundColor: Colors.white,
                                                              backgroundColor: Color(0xFF2A85FF),
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            ),
                                                            child: Text('Update')
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(height: 50.h,),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                          child: Text('Company target', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: (){
                                                                  // updateCompanyData(companyId, txtCompanyName.text, txtAddress.text, txtPhoneNumber.text, txtWebsite.text, txtIndustry.text, txtEmail.text, context);
                                                                }, 
                                                                style: ElevatedButton.styleFrom(
                                                                  elevation: 0,
                                                                  alignment: Alignment.center,
                                                                  minimumSize: const Size(60, 50),
                                                                  foregroundColor: Colors.white,
                                                                  backgroundColor: Color(0xFF2A85FF),
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                ),
                                                                child: Text('Add target')
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, top: 5.sp),
                                                          child: Text('User management', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              ElevatedButton(
                                                                onPressed: (){
                                                                  showDialog(
                                                                    context: context, 
                                                                    builder: (_) {
                                                                      return AlertDialog(
                                                                        title: Text('Edit refferal code'),
                                                                        contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                                                                        content: SizedBox(
                                                                          width: 300.0, // Set the width of the AlertDialog content
                                                                          height: 200.0,
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text('Refferal ID'),
                                                                              SizedBox(height: 5.h,),
                                                                              TextFormField(
                                                                                initialValue: refferalIDValue,
                                                                                decoration: InputDecoration(
                                                                                  hintText: 'Refferal Code',
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
                                                                              SizedBox(height: 20.h,),
                                                                              Text('User Limit'),
                                                                              SizedBox(height: 5.h,),
                                                                              TextFormField(
                                                                                initialValue: limitUserValue,
                                                                                keyboardType: TextInputType.number,
                                                                                decoration: InputDecoration(
                                                                                  hintText: 'Input user limit',
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
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            onPressed: (){
                                                                      
                                                                            }, 
                                                                            style: ElevatedButton.styleFrom(
                                                                              elevation: 0,
                                                                              alignment: Alignment.centerLeft,
                                                                              minimumSize: Size(20.w, 50.h),
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: const Color(0xFF2A85FF),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            ),
                                                                            child: Text('Update')
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  );
                                                                }, 
                                                                style: ElevatedButton.styleFrom(
                                                                  elevation: 0,
                                                                  alignment: Alignment.center,
                                                                  minimumSize: const Size(60, 50),
                                                                  foregroundColor: Colors.white,
                                                                  backgroundColor: Color(0xFF2A85FF),
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                ),
                                                                child: Text('Edit refferal')
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 10.sp),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: FutureBuilder<List<Map<String, dynamic>>>(
                                                          future: userManagementList,
                                                          builder: (context, snapshot) {
                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return const Center(child: CircularProgressIndicator());
                                                            } else if (snapshot.hasError) {
                                                              return Center(child: Text('Error: ${snapshot.error}'));
                                                            } else if (snapshot.hasData) {
                                                              print(snapshot.data?.length);                                                            
                                                              return DataTable(
                                                                showCheckboxColumn: false,
                                                                columns: const <DataColumn> [
                                                                  DataColumn(label: Text('No')),
                                                                  DataColumn(label: Text('Username')),
                                                                  DataColumn(label: Text('Name')),
                                                                  DataColumn(label: Text('Permission')),
                                                                ], 
                                                                rows: snapshot.data!.asMap().entries.map<DataRow>((entry) {
                                                                  int index = entry.key + 1;
                                                                  Map<String, dynamic> users = entry.value;
                                                                  return DataRow(
                                                                    cells: <DataCell>[
                                                                      DataCell(Text('$index')),
                                                                      DataCell(Text(users['username'])),
                                                                      DataCell(Text(users['first_name'])),
                                                                      DataCell(Text(users['permission_access'])),
                                                                    ],
                                                                    onSelectChanged: (selected) {
                                                                      if (selected!) {
                                                                        showDialog(
                                                                          context: context, 
                                                                          builder: (_) {
                                                                            return AlertDialog(
                                                                              title: Text('Edit permission'),
                                                                              contentPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                                                                              content: SizedBox(
                                                                                width: 300.0, // Set the width of the AlertDialog content
                                                                                height: 200.0,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text('Username'),
                                                                                    SizedBox(height: 5.h,),
                                                                                    TextFormField(
                                                                                      readOnly: true,
                                                                                      initialValue: users['username'],
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'Refferal Code',
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
                                                                                    SizedBox(height: 20.h,),
                                                                                    Text('Permission'),
                                                                                    SizedBox(height: 5.h,),
                                                                                    TextFormField(
                                                                                      initialValue: users['permission_access'],
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: InputDecoration(
                                                                                        hintText: 'Input user limit',
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
                                                                              actions: [
                                                                                ElevatedButton(
                                                                                  onPressed: (){
                                                                            
                                                                                  }, 
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    elevation: 0,
                                                                                    alignment: Alignment.centerLeft,
                                                                                    minimumSize: Size(20.w, 50.h),
                                                                                    foregroundColor: Colors.white,
                                                                                    backgroundColor: const Color(0xFF2A85FF),
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                                  ),
                                                                                  child: Text('Update')
                                                                                )
                                                                              ],
                                                                            );
                                                                          }
                                                                        );
                                                                        // Get.to(DetailCustomerSettingLarge(customer['company_id']));
                                                                      }
                                                                    },
                                                                  );
                                                                }).toList(),
                                                              );
                                                            } else {
                                                              return const Center(child: Text('No data available'));
                                                            }
                                                          }
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]
                                            ),
                                          )
                                         
                                          
                                          
                                      
                                        ],
                                      );
                                    }
                                    
                                  }
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