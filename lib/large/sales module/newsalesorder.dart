import 'package:date_time_picker/date_time_picker.dart';
import 'package:erpsystems/large/index.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/analyticstemplatelarge.dart';
import 'package:erpsystems/large/template/documenttemplatelarge.dart';
import 'package:erpsystems/large/template/financetemplatelarge.dart';
import 'package:erpsystems/large/template/hrtemplatelarge.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
import 'package:erpsystems/large/template/warehousetemplatelarge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

import 'salesindex.dart';

class NewSalesIndexLarge extends StatefulWidget {
  const NewSalesIndexLarge({super.key});

  @override
  State<NewSalesIndexLarge> createState() => _NewSalesIndexLargeState();
}

class _NewSalesIndexLargeState extends State<NewSalesIndexLarge> {
  TextEditingController txtSearchText = TextEditingController();
  String profileName = 'Kevin';
  String jumlahSales = '2';
  String selectedItem = '';
  TextEditingController hargaController = TextEditingController();
  TextEditingController txtDataTableTotal = TextEditingController();
  TextEditingController txtDataTablePPN = TextEditingController();
  int? harga;
  int? quantity;
  int? total;
  int? ppn;

  List<Item> items = [
    Item(name: 'Item 1', quantity: 10, harga: 10000),
    Item(name: 'Item 2', quantity: 20, harga: 10000),
    Item(name: 'Item 3', quantity: 15, harga: 10000),
    // Add more items as needed
  ];

  List<Item> selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
                                    child: Text('New Sales Order', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600),),
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
                                              Text('Sales Order Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
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
                                                dateHintText: 'Input sales date',
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
                                              Text('PPN / No. PPN', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DropdownButtonFormField(
                                                value: 'PPN01',
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'PPN01',
                                                    child: Text('NPWP', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'PPN02',
                                                    child: Text('Non-NPWP', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
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
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Address', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              Text('Jln. M. H. Thamrin No. A1, Jakarta Pusat, DKI Jakarta', style: TextStyle(color: const Color(0xFF2A85FF), fontSize: 4.sp, fontWeight: FontWeight.w500,),)
                                              
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('PO Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DropdownButtonFormField(
                                                value: 'PO-LIST-001',
                                                items: const [
                                                  DropdownMenuItem(
                                                    value: 'PO-LIST-001',
                                                    child: Text('PO/11/2023/0001', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'PO-LIST-002',
                                                    child: Text('PO/11/2023/0002', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'PO-LIST-003',
                                                    child: Text('PO/11/2023/0003', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                                  ),
                                                  DropdownMenuItem(
                                                    value: 'PO-LIST-004',
                                                    child: Text('PO/11/2023/0004', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
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
                                          child: TypeAheadField<Item>(
                                            suggestionsCallback: (String search) async {
                                              // Use a Future to simulate an asynchronous call for suggestions
                                              await Future.delayed(Duration(milliseconds: 300)); // Simulating a delay for demo purposes

                                              // Replace the next line with your actual logic to fetch suggestions
                                              return items.where((item) => item.name.toLowerCase().contains(search.toLowerCase())).toList();
                                            },

                                            builder: (context, controller, focusNode) {
                                              return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Browse Product',
                                                )
                                              );
                                            },
                                            itemBuilder: (context, Item) {
                                              return ListTile(
                                                title: Text(Item.name),
                                              );
                                            },
                                            onSelected: (Item selectedItem) {
                                              setState(() {
                                                selectedItems.add(selectedItem);
                                              });
                                            },
                                          )
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.sp, bottom: 7.sp, right: 5.sp),
                                    child: SizedBox(
                                      width: (MediaQuery.of(context).size.width),
                                      child: DataTable(
                                        columns: [
                                          DataColumn(label: Text('No')),
                                          DataColumn(label: Text('Product Name')),
                                          DataColumn(label: Text('QTY')),
                                          DataColumn(label: Text('SAT')),
                                          DataColumn(label: Text('Curr')),
                                          DataColumn(label: Text('Harga@')),
                                          DataColumn(label: Text('Total')),
                                          DataColumn(label: Text('Kurs')),
                                          DataColumn(label: Text('DPP')),
                                          DataColumn(label: Text('PPN')),
                                        ],
                                        rows: [
                                          ...selectedItems.asMap().entries.map((entry) {
                                            int index = entry.key;
                                            Item item = entry.value;
                                            TextEditingController hargaController = TextEditingController(text: item.harga.toString());
                                            int? harga = int.tryParse(hargaController.text);
                                            int quantity = item.quantity;
                                            int? total = (harga != null) ? (harga * quantity) : null;
                                            double ppn = (total! * 0.01);
                                            TextEditingController txtDataTablePPN = TextEditingController(text: ppn.toString());
                                            TextEditingController txtDataTableTotal = TextEditingController(text: total.toString());

                                            return DataRow(cells: [
                                              DataCell(Text((index + 1).toString())),
                                              DataCell(Text(item.name)),
                                              DataCell(
                                                TextField(
                                                  controller: TextEditingController(text: item.quantity.toString()),
                                                  readOnly: true,
                                                ),
                                              ),
                                              DataCell(Text('')), // Placeholder for 'SAT'
                                              DataCell(Text('')), // Placeholder for 'Curr'
                                              DataCell(
                                                TextField(
                                                  controller: hargaController,
                                                  onChanged: (value) {
                                                    int? harga = int.tryParse(value);
                                                    int quantity = selectedItems[index].quantity;
                                                    int total = (harga != null) ? (harga * quantity) : 0;
                                                    double ppn = (total * 0.01);
                                                    txtDataTableTotal.text = total.toString();
                                                    txtDataTablePPN.text = ppn.toString();
                                                    selectedItems[index].harga = harga ?? 0;
                                                  },
                                                ),
                                              ),
                                              DataCell(
                                                TextField(
                                                  controller: txtDataTableTotal,
                                                  readOnly: true,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                              DataCell(Text('')), // Placeholder for 'Kurs'
                                              DataCell(Text('')), // Placeholder for 'DPP'
                                              DataCell(
                                                TextField(
                                                  controller: txtDataTablePPN,
                                                  readOnly: true,
                                                  onChanged: (value) {},
                                                ),
                                              ),
                                            ]);
                                          }).toList(),

                                          // Add an extra row for totals
                                          DataRow(cells: [
                                            DataCell(Text('Total:')),
                                            DataCell(Text('')),
                                            DataCell(
                                              Text(selectedItems.fold<int>(0, (sum, item) => sum + item.quantity).toString()),
                                            ),
                                            DataCell(Text('')), // Placeholder for 'SAT'
                                            DataCell(Text('')), // Placeholder for 'Curr'
                                            DataCell(
                                              Text(selectedItems.fold<int>(0, (sum, item) => sum + (item.harga * item.quantity)).toString()),
                                            ),
                                            DataCell(
                                              Text(selectedItems.fold<int>(0, (sum, item) => sum + (item.harga * item.quantity)).toString()),
                                            ),
                                            DataCell(Text('')), // Placeholder for 'Kurs'
                                            DataCell(Text('')), // Placeholder for 'DPP'
                                            DataCell(
                                              Text(selectedItems.fold<double>(0.0, (sum, item) => sum + (item.harga * item.quantity * 0.01)).toString()),
                                            ),
                                          ]),
                                        ],
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
                                          width: (MediaQuery.of(context).size.width - 150.w) / 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Dikirim Tanggal', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DateTimePicker(
                                                dateHintText: 'Input tanggal kirim',
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
                                              Text('Dikirim Ke', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              SizedBox(height: 5.h,),
                                              DateTimePicker(
                                                dateHintText: 'Input dikirim ke',
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
                                              // Text('PO Number', style: TextStyle(fontSize: 4.sp, fontWeight: FontWeight.w400,)),
                                              // SizedBox(height: 5.h,),
                                              // DropdownButtonFormField(
                                              //   value: 'PO-LIST-001',
                                              //   items: const [
                                              //     DropdownMenuItem(
                                              //       value: 'PO-LIST-001',
                                              //       child: Text('PO/11/2023/0001', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                              //     ),
                                              //     DropdownMenuItem(
                                              //       value: 'PO-LIST-002',
                                              //       child: Text('PO/11/2023/0002', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                              //     ),
                                              //     DropdownMenuItem(
                                              //       value: 'PO-LIST-003',
                                              //       child: Text('PO/11/2023/0003', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                              //     ),
                                              //     DropdownMenuItem(
                                              //       value: 'PO-LIST-004',
                                              //       child: Text('PO/11/2023/0004', style: TextStyle(color: Color.fromRGBO(111, 118, 126, 1)),)
                                              //     )
                                              //   ], 
                                              //   decoration: InputDecoration(
                                              //     enabledBorder: OutlineInputBorder(
                                              //       borderSide: const BorderSide(width: 0.0),
                                              //       borderRadius: BorderRadius.circular(10.0),
                                              //     ),
                                              //     focusedBorder: OutlineInputBorder(
                                              //       borderSide: const BorderSide(width: 0.0),
                                              //       borderRadius: BorderRadius.circular(10.0),
                                              //     )
                                              //   ),
                                              //   onChanged: (value){
                                                  
                                              //   }
                                              // ),
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
  String name;
  int quantity;
  int harga;

  Item({required this.name, required this.quantity, required this.harga});
}