import 'dart:convert';

import 'package:erpsystems/medium/analytics/analyticsindex.dart';
import 'package:erpsystems/medium/document/documentindex.dart';
import 'package:erpsystems/medium/finance/financeindex.dart';
import 'package:erpsystems/medium/hr/hrindex.dart';
import 'package:erpsystems/medium/login.dart';
import 'package:erpsystems/medium/purchase/purchaseindex.dart';
import 'package:erpsystems/medium/sales/salesindex.dart';
import 'package:erpsystems/medium/setting/settingindex.dart';
import 'package:erpsystems/medium/warehouse/warehouseindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class IndexTemplateMedium extends StatefulWidget {
  const IndexTemplateMedium({super.key});

  @override
  State<IndexTemplateMedium> createState() => _IndexTemplateMediumState();
}

class _IndexTemplateMediumState extends State<IndexTemplateMedium> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String jumlahAttandance = '3';
  String jumlahLate = '3';
  String jumlahAbsence = '3';
  String jumlahLeaveReaming = '3';
  String companyId = '';
  String year1 = '';
  String year2 = '';
  int? target1;
  int? target2;
  bool isLoading = false;
  bool isMenu = false;
  int salesyear1 = 50000000;
  int salesyear2 = 10000000;
  double? percent1;
  double? percent2;
  String percentageText1 = '';
  String percentageText2 = '';
  double? percentageyear1;
  double? percentageyear2;

  String formatCurrency(int value) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0).format(value);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTargeting();
  }

  Future<void> getTargeting() async {
    setState(() {
      isLoading = true;
    });

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

        isLoading = false;

      });
    } else {
      print('HTTP, Failed to fetch data');
    }

  }
  
  @override
  Widget build(BuildContext context) {
    companyName = storage.read('companyName').toString();
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
                            // Get.to(IndexLarge(widget.companyName));
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
                                child: Image.asset('Icon/DashboardActive.png'),
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
                    )
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
                    if(txtSearchText.text == '')
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
                              Text('Dashboard', style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
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
                                          Text('Overview', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600),),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 7,
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
                                            width: isMenu ? (MediaQuery.of(context).size.width - 125.w) / 4 : (MediaQuery.of(context).size.width - 65.w) / 4,
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
                                                        Text(isMenu ? 'Attandance\n ' : 'Attandance', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahAttandance, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Late Card
                                          SizedBox(
                                            width: isMenu ? (MediaQuery.of(context).size.width - 125.w) / 4 : (MediaQuery.of(context).size.width - 65.w) / 4,
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
                                                        Text(isMenu ? 'Late\n ' : 'Late', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahLate, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Absent Card
                                          SizedBox(
                                            width: isMenu ? (MediaQuery.of(context).size.width - 125.w) / 4 : (MediaQuery.of(context).size.width - 65.w) / 4,
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
                                                        Text(isMenu ? 'Absent\n ' :'Absent', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahAbsence, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                          //Leave Card
                                          SizedBox(
                                            width: isMenu ? (MediaQuery.of(context).size.width - 125.w) / 4 : (MediaQuery.of(context).size.width - 65.w) / 4,
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
                                                        Text(isMenu ? 'Remaining\nLeave' : 'Remaining Leave', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 5.sp, bottom: 5.sp),
                                                    child: Text(jumlahLeaveReaming, style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w600),),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: isMenu ? (MediaQuery.of(context).size.width - 100.w) / 2 : (MediaQuery.of(context).size.width - 20.w)/ 2,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 7.sp, right: 5.sp),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Target $year1', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15.h,),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
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
                                            ),
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
                                      )
                                    ),
                                  ),
                                  SizedBox(
                                    width: isMenu ? (MediaQuery.of(context).size.width - 100.w) / 2 : (MediaQuery.of(context).size.width - 20.w)/ 2,
                                    child: Card(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(12))
                                      ),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.sp, top: 5.sp, bottom: 7.sp, right: 5.sp),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('Target $year1', style: TextStyle(fontSize: 7.sp, fontWeight: FontWeight.w600),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 15.h,),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
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
                                            ),
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
                                      )
                                    ),
                                  ),
                                ],
                              )
                            ]
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