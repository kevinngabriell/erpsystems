import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NewProfitLarge extends StatefulWidget {
  const NewProfitLarge({super.key});

  @override
  State<NewProfitLarge> createState() => _NewProfitLargeState();
}

class _NewProfitLargeState extends State<NewProfitLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String jumlahSales = '2';
  String SONumberSelected = '';

  List<Map<String, String>> tableData = [
    {'SalesOrderNumber': 'SLS-01', 'ProductName': 'Product A', 'Qty': '10', 'UnitPrice': '20.0', 'LandedCost': '150.0', 'Profit': '50.0'},
    {'SalesOrderNumber': 'SLS-02', 'ProductName': 'Product B', 'Qty': '8', 'UnitPrice': '25.0', 'LandedCost': '120.0', 'Profit': '80.0'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                            Text('Sales Module', style: TextStyle(fontSize: 6.sp, fontWeight: FontWeight.w600),),
                            SizedBox(height: 10.h,),
                            //Card Overview
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
                                    child: Text('New Profit', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //Sales Order Number 
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Sales Order Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DropdownButtonFormField(
                                                value: 'SLS-01',
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'SLS-01',
                                                    child: Text('SLS/IND/001/001/001', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'SLS-02',
                                                    child: Text('SLS/IND/001/001/002', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'SLS-03',
                                                    child: Text('SLS/IND/001/001/003', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
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
                                                  SONumberSelected = value.toString();
                                                  print(SONumberSelected);
                                                }
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Customer', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DropdownButtonFormField(
                                                value: 'CUST-001',
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'CUST-001',
                                                    child: Text('PT. ABC', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'CUST-002',
                                                    child: Text('PT. DEF', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'CUST-003',
                                                    child: Text('PT. GHI', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
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
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: SizedBox(
                                      width: (MediaQuery.of(context).size.width) ,
                                      child: DataTable(
                                        columns: [
                                          DataColumn(label: Text('No')),
                                          DataColumn(label: Text('Nama Barang')),
                                          DataColumn(label: Text('QTY')),
                                          DataColumn(label: Text('Harga Jual Satuan')),
                                          DataColumn(label: Text('Landed Cost')),
                                          DataColumn(label: Text('Profit')),
                                          DataColumn(label: Text('Profit %')),
                                        ],
                                        rows: tableData
                                            .where((row) =>
                                                SONumberSelected.isNotEmpty ||
                                                row['SalesOrderNumber']?.toLowerCase() == SONumberSelected.toLowerCase())
                                            .map((row) {
                                          return DataRow(
                                            cells: [
                                              DataCell(Text(row['SalesOrderNumber']!)),
                                              DataCell(Text(row['ProductName']!)),
                                              DataCell(Text(row['Qty']!)),
                                              DataCell(Text(row['UnitPrice']!)),
                                              DataCell(Text(row['LandedCost']!)),
                                              DataCell(Text(row['Profit']!)),
                                              DataCell(Text(row['Profit']!)),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 4,
                                          child: ElevatedButton(
                                              onPressed: (){
                                                // Get.to(AddCustomerSettingLarge());
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                alignment: Alignment.centerLeft,
                                                minimumSize: Size(20.w, 50.h),
                                                foregroundColor: Colors.white,
                                                backgroundColor: const Color(0xFF2A85FF),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              ),
                                              child: Center(child: Text('Export as PDF', style: TextStyle(fontSize: 4.sp),))
                                            ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 4,
                                          child: ElevatedButton(
                                              onPressed: (){
                                                // Get.to(AddCustomerSettingLarge());
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                alignment: Alignment.centerLeft,
                                                minimumSize: Size(20.w, 50.h),
                                                foregroundColor: Colors.white,
                                                backgroundColor: const Color(0xFF2A85FF),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              ),
                                              child: Center(child: Text('Approve', style: TextStyle(fontSize: 4.sp),))
                                            ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 4,
                                          child: ElevatedButton(
                                              onPressed: (){
                                                // Get.to(AddCustomerSettingLarge());
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                alignment: Alignment.centerLeft,
                                                minimumSize: Size(20.w, 50.h),
                                                foregroundColor: Colors.white,
                                                backgroundColor: const Color(0xFF2A85FF),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              ),
                                              child: Center(child: Text('Reject', style: TextStyle(fontSize: 4.sp),))
                                            ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 4,
                                          child: ElevatedButton(
                                              onPressed: (){
                                                // Get.to(AddCustomerSettingLarge());
                                              }, 
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                alignment: Alignment.centerLeft,
                                                minimumSize: Size(20.w, 50.h),
                                                foregroundColor: Colors.white,
                                                backgroundColor: const Color(0xFF2A85FF),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                              ),
                                              child: Center(child: Text('Submit', style: TextStyle(fontSize: 4.sp),))
                                            ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
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

class Item {
  final String name;
  final int quantity;

  Item({required this.name, required this.quantity});
}