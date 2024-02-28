import 'dart:convert';
import 'package:erpsystems/currencyformatter.dart';
import 'package:erpsystems/services/settings/internaldataservices.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:erpsystems/medium/setting/settingindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:erpsystems/services/settings/companydataservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:erpsystems/medium/analytics/analyticsindex.dart';
import 'package:erpsystems/medium/document/documentindex.dart';
import 'package:erpsystems/medium/finance/financeindex.dart';
import 'package:erpsystems/medium/hr/hrindex.dart';
import 'package:erpsystems/medium/login.dart';
import 'package:erpsystems/medium/purchase/purchaseindex.dart';
import 'package:erpsystems/medium/sales/salesindex.dart';
import 'package:erpsystems/medium/template/indextemplatemedium.dart';
import 'package:erpsystems/medium/warehouse/warehouseindex.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class InternalMediumIndex extends StatefulWidget {
  const InternalMediumIndex({super.key});

  @override
  State<InternalMediumIndex> createState() => _InternalMediumIndexState();
}

class _InternalMediumIndexState extends State<InternalMediumIndex> with TickerProviderStateMixin {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String companyId = '';
  String profileName = '';
  String companyName = '';
  bool isLoading = false;
  bool isMenu = false;

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtWebsite = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtIndustry = TextEditingController();
  TextEditingController txtInputTarget = TextEditingController();
  String yearSelected = '';
  late TabController tabController;
  late Future<List<Map<String, dynamic>>> userManagementList;

  List<Map<String, String>> limitUsers = [];
  String refferalIDValue = '';

  
  TextEditingController limitUserValue = TextEditingController();
  String permissionID = '';
  String year1 = '';
  String year2 = '';
  int? target1;
  int? target2;

  int salesyear1 = 50000000;
  int salesyear2 = 10000000;

  double? percentageyear1;
  double? percentageyear2;

  double? percent1;
  double? percent2;
  String percentageText1 = '';
  String percentageText2 = '';

  List<Map<String, String>> permissions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    userManagementList = allUserService();
    getRefferalID();
    getPermissionList();
    getTargeting();
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
            limitUserValue.text = limitUsers[0]['limit_user']!;
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

  Future<void> getPermissionList() async {
    final response = await http.get(
      Uri.parse(ApiEndpoints.permissionList)
    );

  if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['StatusCode'] == 200) {
        setState(() {
          permissions = (data['Data'] as List)
              .map((reason) => Map<String, String>.from(reason))
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


  }

  Future<void> getTargeting() async {

    companyId = storage.read('companyId').toString();
    final response = await http.get(
        Uri.parse(ApiEndpoints.target2years(companyId))
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      Map<String, dynamic> dataYear1 = responseData['Data'][0];
      Map<String, dynamic> dataYear2 = responseData['Data'][1];

      setState(() {
        year1 = dataYear1['target_year'];
        year2 = dataYear2['target_year'];
        target1 = int.parse(dataYear1['target_value']);
        target2 = int.parse(dataYear2['target_value']);

        percentageyear1 = target1 != null ? salesyear1 / target1! : null;
        percentageyear2 = target2 != null ? salesyear2 / target2! : null;

        percent1 = (percentageyear1! * 100);
        percentageText1 = '$percent1 %'; 

        percent2 = (percentageyear2! * 100);
        percentageText2 = '$percent2 %'; 

      });
    } else {
      print('HTTP, Failed to fetch data');
    }

  }

  String formatCurrency(int value) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(value);
  }

  @override
  Widget build(BuildContext context) {
    profileName = storage.read('firstName').toString();
    
    return MaterialApp(
      title: 'Venken ERP Systems',
      home: Scaffold(
        body: isLoading ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
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
                            Get.to(IndexTemplateMedium());
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
                            foregroundColor: const Color(0xFF6F767E),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 10.w,
                                alignment: Alignment.centerLeft,
                                child: Image.asset('Icon/DocumentInactive.png'),
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
                                child: Image.asset('Icon/SettingActive.png'),
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
                            Get.off(LoginMedium());
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
                              child: Text('Menu')
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
                                child: Text('Internal settings', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600),)
                              ),
                              SizedBox(height: 10.h,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: CompanyDataService(companyId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
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
                                                    fontSize: 7.sp, 
                                                    fontWeight: FontWeight.w400,
                                                    //color: tabController.index == 0 ? Color.fromRGBO(78, 195, 252, 1) : Colors.black
                                                  ),
                                                ),
                                              ),
                                              Tab( 
                                                child: Text(
                                                  'Company target', 
                                                  style: TextStyle(
                                                    fontSize: 7.sp, 
                                                    fontWeight: FontWeight.w400,
                                                    //color: tabController.index == 0 ? Color.fromRGBO(78, 195, 252, 1) : Colors.black
                                                  ),
                                                ),
                                              ),
                                              Tab( 
                                                child: Text(
                                                  'User management', 
                                                  style: TextStyle(
                                                    fontSize: 7.sp, 
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
                                                      child: Text('Company setting', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600,)),
                                                    ),
                                                    //Company Name & Phone Form
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          //Company Name
                                                          SizedBox(
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company name'),
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
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company phone number'),
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
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company website'),
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
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company email'),
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
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company address'),
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
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Company industry'),
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
                                                              backgroundColor: const Color(0xFF2A85FF),
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            ),
                                                            child: const Text('Update')
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
                                                          child: Text('Company target', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600,)),
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
                                                                        title: Text('Add target', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.w600,)),
                                                                        contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                                                                        content: SizedBox(
                                                                          width: 300.0, // Set the width of the AlertDialog content
                                                                          height: 250.0,
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text('Year', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w400, color: const Color(0xFF787878))),
                                                                              SizedBox(height: 5.h,),
                                                                              DropdownButtonFormField(
                                                                                value: 2024,
                                                                                decoration: InputDecoration(
                                                                                  prefixIcon: Image.asset('Icon/addTargetYear.png'),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(width: 0.0),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: const BorderSide(width: 0.0),
                                                                                    borderRadius: BorderRadius.circular(10.0),
                                                                                  )
                                                                                ),  
                                                                                items: const [
                                                                                  DropdownMenuItem(
                                                                                    value: 2024,
                                                                                    child: Text('2024')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2025,
                                                                                    child: Text('2025')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2026,
                                                                                    child: Text('2026')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2027,
                                                                                    child: Text('2027')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2028,
                                                                                    child: Text('2028')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2029,
                                                                                    child: Text('2029')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2030,
                                                                                    child: Text('2030')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2031,
                                                                                    child: Text('2031')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2032,
                                                                                    child: Text('2030')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2033,
                                                                                    child: Text('2031')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2034,
                                                                                    child: Text('2030')
                                                                                  ),
                                                                                  DropdownMenuItem(
                                                                                    value: 2035,
                                                                                    child: Text('2031')
                                                                                  )
                                                                                ], 
                                                                                onChanged: (value){
                                                                                  yearSelected = value.toString();
                                                                                }
                                                                              ),
                                                                              SizedBox(height: 20.h,),
                                                                              Text('Target', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w400, color: const Color(0xFF787878))),
                                                                              SizedBox(height: 5.h,),
                                                                              TextFormField(
                                                                                controller: txtInputTarget,
                                                                                keyboardType: TextInputType.number,
                                                                                inputFormatters: [
                                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                                  CurrencyFormatter(),
                                                                                ],
                                                                                decoration: InputDecoration(
                                                                                  prefixIcon: Image.asset('Icon/addTarget.png'),
                                                                                  hintText: 'Rp. 1.xxx.xxx.xxx',
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
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            onPressed: (){
                                                                              insertTargeting(companyId, yearSelected, txtInputTarget.text.replaceAll(RegExp(r'[^0-9]'), ''), context);
                                                                            }, 
                                                                            style: ElevatedButton.styleFrom(
                                                                              elevation: 0,
                                                                              alignment: Alignment.centerLeft,
                                                                              minimumSize: Size(20.w, 50.h),
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: const Color(0xFF2A85FF),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            ),
                                                                            child: const Text('Save')
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
                                                                  backgroundColor: const Color(0xFF2A85FF),
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                ),
                                                                child: const Text('Add target +')
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 10.h,),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Card(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                                    child: Text('Target $year1', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600,)),
                                                                  ),
                                                                  SizedBox(height: 15.h,),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                                                                    child: Center(
                                                                      child: CircularPercentIndicator(
                                                                        radius: 100.0,
                                                                        animation: true,
                                                                        animationDuration: 1000,
                                                                        lineWidth: 30.0,
                                                                        percent: percentageyear1!,
                                                                        reverse: false,
                                                                        arcType: ArcType.FULL,
                                                                        startAngle: 0.0,
                                                                        center: Text(percentageText1, style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
                                                                        progressColor: Colors.blue,
                                                                      )
                                                                    )
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp, bottom: 7.sp),
                                                                    child: Center(
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          text: 'Target : ',
                                                                          style: const TextStyle(color: Color(0xFF1A1D1F), fontWeight: FontWeight.bold),
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: '${formatCurrency(salesyear1)} / ', style: const TextStyle(color: Color(0xFF787878), fontWeight: FontWeight.bold)),
                                                                            TextSpan(text: formatCurrency(target1!), style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox( 
                                                            width: isMenu ? (MediaQuery.of(context).size.width - 130.w)/ 2 : (MediaQuery.of(context).size.width - 45.w)/ 2,
                                                            child: Card(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp),
                                                                    child: Text('Target $year2', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600,)),
                                                                  ),
                                                                  SizedBox(height: 15.h,),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp),
                                                                    child: Center(
                                                                      child: CircularPercentIndicator(
                                                                        radius: 100.0,
                                                                        animation: true,
                                                                        animationDuration: 1000,
                                                                        lineWidth: 30.0,
                                                                        percent: percentageyear2!,
                                                                        reverse: false,
                                                                        arcType: ArcType.FULL,
                                                                        startAngle: 0.0,
                                                                        center: Text(percentageText2, style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
                                                                        progressColor: Colors.blue,
                                                                      )
                                                                    )
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 5.sp, right: 5.sp, top: 5.sp, bottom: 7.sp),
                                                                    child: Center(
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          text: 'Target : ',
                                                                          style: const TextStyle(color: Color(0xFF1A1D1F), fontWeight: FontWeight.bold),
                                                                          children: <TextSpan>[
                                                                            TextSpan(text: '${formatCurrency(salesyear2)} / ', style: const TextStyle(color: Color(0xFF787878), fontWeight: FontWeight.bold)),
                                                                            TextSpan(text: formatCurrency(target2!), style: const TextStyle(color: Color(0xFF2A85FF), fontWeight: FontWeight.bold)),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ) 
                                                        ],
                                                      ),
                                                    )
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
                                                          child: Text('User management', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600,)),
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
                                                                        title: const Text('Edit refferal code'),
                                                                        contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                                                                        content: SizedBox(
                                                                          width: 300.0, // Set the width of the AlertDialog content
                                                                          height: 200.0,
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Text('Refferal ID'),
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
                                                                                readOnly: true,
                                                                              ),
                                                                              SizedBox(height: 20.h,),
                                                                              const Text('User Limit'),
                                                                              SizedBox(height: 5.h,),
                                                                              TextFormField(
                                                                                controller: limitUserValue,
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
                                                                              updateUserLimit(limitUserValue.text, refferalIDValue, context);
                                                                            }, 
                                                                            style: ElevatedButton.styleFrom(
                                                                              elevation: 0,
                                                                              alignment: Alignment.centerLeft,
                                                                              minimumSize: Size(20.w, 50.h),
                                                                              foregroundColor: Colors.white,
                                                                              backgroundColor: const Color(0xFF2A85FF),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            ),
                                                                            child: const Text('Update')
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
                                                                  backgroundColor: const Color(0xFF2A85FF),
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                ),
                                                                child: const Text('Edit refferal')
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
                                                                              title: const Text('Edit permission'),
                                                                              contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                                                                              content: SizedBox(
                                                                                width: 300.0, // Set the width of the AlertDialog content
                                                                                height: 200.0,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    const Text('Username'),
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
                                                                                    const Text('Permission'),
                                                                                    SizedBox(height: 5.h,),
                                                                                    DropdownButtonFormField<String>(
                                                                                      value: users['permission_id'],
                                                                                      items: permissions.map<DropdownMenuItem<String>>(
                                                                                        (Map<String, String> permission) {
                                                                                          return DropdownMenuItem<String>(
                                                                                            value: permission['permission_id'],
                                                                                            child: Text(permission['permission_access']!),
                                                                                          );
                                                                                        },
                                                                                      ).toList(),
                                                                                      onChanged: (String? newValue){
                                                                                        permissionID = newValue!;
                                                                                      }
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: [
                                                                                ElevatedButton(
                                                                                  onPressed: (){
                                                                                    updatePermission(permissionID, users['username'], context);
                                                                                  }, 
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    elevation: 0,
                                                                                    alignment: Alignment.centerLeft,
                                                                                    minimumSize: Size(20.w, 50.h),
                                                                                    foregroundColor: Colors.white,
                                                                                    backgroundColor: const Color(0xFF2A85FF),
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                                  ),
                                                                                  child: const Text('Update')
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
            ]
          )
        )
      ),
    );
  }
}