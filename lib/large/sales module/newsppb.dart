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
import 'package:flutter_typeahead/flutter_typeahead.dart';
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
  bool showSuggestions = false;
  late DateTime today;
  late DateTime tomorrow;

  List<Item> items = [
    Item(salesOrderNumber: 'SO/123/12/123/12', poCustomer: 'PO/123/12/123/12', dikirimKe: DateTime.now(), tanggalKirim: DateTime.now().add(Duration(days: 1)), namaBarang: 'A', Qty: 1, SAT: 'KG', Keterangan: ''),
    Item(salesOrderNumber: 'SO/123/12/123/13', poCustomer: 'PO/123/12/123/13', dikirimKe: DateTime.now(), tanggalKirim: DateTime.now().add(Duration(days: 1)), namaBarang: 'B', Qty: 2, SAT: 'KG', Keterangan: ''),
    Item(salesOrderNumber: 'SO/123/12/123/14', poCustomer: 'PO/123/12/123/14', dikirimKe: DateTime.now(), tanggalKirim: DateTime.now().add(Duration(days: 1)), namaBarang: 'C', Qty: 3, SAT: 'KG', Keterangan: ''),
    // Add more items as needed
  ];

  List<Item> selectedItems = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      
    today = DateTime.now();
    tomorrow = today.add(Duration(days: 1));
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
                                          child: TypeAheadField<Item>(
                                            builder: (context, controller, focusNode) {
                                              return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                autofocus: true,
                                                onTap: () {
                                                  setState(() {
                                                    showSuggestions = true; // Open suggestions when the TextField is tapped
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Browse Product',
                                                )
                                              );
                                            },
                                            suggestionsCallback: (String search) async {
                                              if (showSuggestions) {
                                                await Future.delayed(Duration(milliseconds: 300));
                                                return items
                                                    .where((item) =>
                                                        item.salesOrderNumber.toLowerCase().contains(search.toLowerCase()))
                                                    .toList();
                                              } else {
                                                return [];
                                              }
                                            },
                                            itemBuilder: (context, Item) {
                                              return ListTile(
                                                title: Text(Item.salesOrderNumber),
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
                                        rows: [
                                          ...selectedItems.asMap().entries.map((entry) {
                                            int index = entry.key;
                                            Item item = entry.value;
                                            // TextEditingController hargaController = TextEditingController(text: item.harga.toString());
                                            // int? harga = int.tryParse(hargaController.text);
                                            // int quantity = item.quantity;
                                            // int? total = (harga != null) ? (harga * quantity) : null;
                                            // double ppn = (total! * 0.01);
                                            // TextEditingController txtDataTablePPN = TextEditingController(text: ppn.toString());
                                            // TextEditingController txtDataTableTotal = TextEditingController(text: total.toString());

                                            return DataRow(cells: [
                                              DataCell(Text((index + 1).toString())),
                                              DataCell(Text(item.poCustomer)),
                                              DataCell(Text(item.dikirimKe.toString())),
                                              DataCell(Text(item.tanggalKirim.toString())),
                                              DataCell(Text(item.namaBarang)),
                                              DataCell(Text(item.Qty.toString())),
                                              DataCell(Text(item.SAT)),
                                              DataCell(Text(item.Keterangan)),
                                            ]);
                                          }).toList(),

                                          // Add an extra row for totals
                                          // DataRow(cells: [
                                          //   DataCell(Text('Total:')),
                                          //   DataCell(Text('')),
                                          //   DataCell(
                                          //     Text(selectedItems.fold<int>(0, (sum, item) => sum + item.quantity).toString()),
                                          //   ),
                                          //   DataCell(Text('')), // Placeholder for 'SAT'
                                          //   DataCell(Text('')), // Placeholder for 'Curr'
                                          //   DataCell(
                                          //     Text(selectedItems.fold<int>(0, (sum, item) => sum + (item.harga * item.quantity)).toString()),
                                          //   ),
                                          //   DataCell(
                                          //     Text(selectedItems.fold<int>(0, (sum, item) => sum + (item.harga * item.quantity)).toString()),
                                          //   ),
                                          //   DataCell(Text('')), // Placeholder for 'Kurs'
                                          //   DataCell(Text('')), // Placeholder for 'DPP'
                                          //   DataCell(
                                          //     Text(selectedItems.fold<double>(0.0, (sum, item) => sum + (item.harga * item.quantity * 0.01)).toString()),
                                          //   ),
                                          // ]),
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
  final String salesOrderNumber;
  final String poCustomer;
  final DateTime dikirimKe;
  final DateTime tanggalKirim;
  final String namaBarang;
  final int Qty;
  final String SAT;
  final String Keterangan;

   Item({
    required this.salesOrderNumber, required this.poCustomer,
    required this.dikirimKe, required this.tanggalKirim,
    required this.namaBarang, required this.Qty,
    required this.SAT, required this.Keterangan,
  });
}