import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:erpsystems/large/index.dart';
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

class NewSPPBLarge extends StatefulWidget {
  const NewSPPBLarge({super.key});

  @override
  State<NewSPPBLarge> createState() => _NewSPPBLargeState();
}

class _NewSPPBLargeState extends State<NewSPPBLarge> {
  TextEditingController txtSearchText = TextEditingController();
  String profileName = 'Kevin';
  String jumlahSales = '2';
  String KPITarget = '4';
  String InTransit = '5';
  String TopItem = 'xxxx Product';
  TextEditingController _textEditingController = TextEditingController();
  AutoCompleteTextField<Item>? _autocompleteTextField;
  GlobalKey<AutoCompleteTextFieldState<Item>> _autocompleteKey = GlobalKey();


  List<Item> items = [
    Item(name: 'Item 1', quantity: 10),
    Item(name: 'Item 2', quantity: 20),
    Item(name: 'Item 3', quantity: 15),
    // Add more items as needed
  ];

  List<Item> selectedItems = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    _autocompleteTextField = AutoCompleteTextField<Item>(
      key: _autocompleteKey,
      clearOnSubmit: true,
      suggestions: items,
      decoration: InputDecoration(labelText: 'Type sales order number'),
      itemFilter: (item, query) =>
          item.name.toLowerCase().startsWith(query.toLowerCase()),
      itemSorter: (a, b) => a.name.compareTo(b.name),
      itemSubmitted: (item) {
        setState(() {
          _textEditingController.text = item.name;
          selectedItems.add(item);
          print(item.name);
        });
      },
      itemBuilder: (context, item) => ListTile(
        title: Text(item.name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          Get.to(const IndexLarge());
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
                                    child: Text('New SPPB', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Nomor SPPB', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              Text('#24122178', style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 5.sp, fontWeight: FontWeight.w600,),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Date', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DateTimePicker(
                                                dateHintText: 'Input SPPB date',
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2100),
                                                initialDate: DateTime.now(),
                                                dateMask: 'd MMM yyyy',
                                                onChanged: (value) {
                                                  setState(() {
                                                    // TanggalPulangAwal = DateFormat('yyyy-MM-dd').parse(value);
                                                    //selectedDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(txtTanggal);
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 100.w) ,
                                          child: _autocompleteTextField!,
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
                                          DataColumn(label: Text('PO Customer')),
                                          DataColumn(label: Text('Dikirim Ke')),
                                          DataColumn(label: Text('Tanggal Kirim')),
                                          DataColumn(label: Text('Nama Barang')),
                                          DataColumn(label: Text('QTY')),
                                          DataColumn(label: Text('SAT')),
                                          DataColumn(label: Text('Keterangan')),
                                        ],
                                        rows: selectedItems.map((item) {
                                          return DataRow(cells: [
                                            DataCell(Text('item.name')),
                                            DataCell(Text(item.quantity.toString())),
                                            DataCell(Text(item.name)),
                                            DataCell(Text(item.quantity.toString())),
                                            DataCell(Text(item.name)),
                                            DataCell(Text(item.quantity.toString())),
                                            DataCell(Text(item.name)),
                                            DataCell(Text(item.quantity.toString())),
                                          ]);
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