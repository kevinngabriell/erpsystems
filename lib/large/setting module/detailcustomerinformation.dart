
import 'package:erpsystems/large/sales%20module/salesindex.dart';
import 'package:erpsystems/large/setting%20module/settingindex.dart';
import 'package:erpsystems/large/template/purchasingtemplatelarge.dart';
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


class DetailCustomerSettingLarge extends StatefulWidget {
  final String customerId;
  const DetailCustomerSettingLarge(this.customerId);

  @override
  State<DetailCustomerSettingLarge> createState() => _DetailCustomerSettingLargeState();
}

class _DetailCustomerSettingLargeState extends State<DetailCustomerSettingLarge> {
  TextEditingController txtSearchText = TextEditingController();
  final storage = GetStorage();
  String profileName = '';
  String companyName = '';
  String customerID = '';

  TextEditingController txtCustomerName = TextEditingController();
  TextEditingController txtCustomerAddress = TextEditingController();
  TextEditingController txtCustomerPhoneNumber = TextEditingController();
  TextEditingController txtCustomerPICName = TextEditingController();
  TextEditingController txtCustomerPICContact = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Read session
    companyName = storage.read('companyName').toString();
    profileName = storage.read('firstName').toString();

    return MaterialApp(
      title: 'Customer Detail Information',
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
                                child: FutureBuilder<Map<String, dynamic>>(
                                  future: getDetailCustomerData(widget.customerId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      Map<String, dynamic> apiResponse = snapshot.data!;
                                      List<dynamic> data = apiResponse['Data'];
                                      CustomerData customer = CustomerData.fromJson(data[0]);
                                      
                                      txtCustomerName.text = customer.customerName;
                                      txtCustomerAddress.text = customer.companyAddress;
                                      txtCustomerPhoneNumber.text = customer.companyPhone;
                                      txtCustomerPICName.text = customer.companyPicName;
                                      txtCustomerPICContact.text = customer.companyPicContact;
                                      customerID = customer.customerID;

                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //Customer Information Title
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.sp, top: 5.sp, right: 5.sp),
                                            child: Text('Customer Information', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                          ),
                                          SizedBox(height: 10.h,),
                                          //Text Form Customer
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
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Customer Name'),
                                                            SizedBox(height: 5.h,),
                                                            TextFormField(
                                                              controller: txtCustomerName,
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
                                                            Text('Customer Address'),
                                                            SizedBox(height: 5.h,),
                                                            TextFormField(
                                                              controller: txtCustomerAddress,
                                                              maxLines: 3,
                                                              decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(width: 0.0),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(width: 0.0),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                hintText: 'Jl. XXXXXX XXXXX, DKI Jakarta'
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20.h,),
                                                  //Customer Phone & PIC Name
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      //Customer Phone                                                      
                                                      SizedBox(
                                                        width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Customer Phone Number'),
                                                            SizedBox(height: 5.h,),
                                                            TextFormField(
                                                              controller: txtCustomerPhoneNumber,
                                                              decoration: InputDecoration(
                                                                enabledBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(width: 0.0),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: const BorderSide(width: 0.0),
                                                                  borderRadius: BorderRadius.circular(10.0),
                                                                ),
                                                                hintText: '021 5978 08932'
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
                                                            Text('Customer PIC Name'),
                                                            SizedBox(height: 5.h,),
                                                            TextFormField(
                                                              controller: txtCustomerPICName,
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
                                                      //Customer Phone                                                      
                                                      SizedBox(
                                                        width: (MediaQuery.of(context).size.width - 500)/ 2,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Customer PIC Contact'),
                                                            SizedBox(height: 5.h,),
                                                            TextFormField(
                                                              controller: txtCustomerPICContact,
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
                                                          updateCustomerData(widget.customerId, txtCustomerName.text, txtCustomerAddress.text, txtCustomerPhoneNumber.text, txtCustomerPICName.text, txtCustomerPICContact.text, context);
                                                        }, 
                                                        style: ElevatedButton.styleFrom(
                                                          elevation: 0,
                                                          alignment: Alignment.centerLeft,
                                                          minimumSize: Size(25.w, 40.h),
                                                          foregroundColor: Colors.white,
                                                          backgroundColor: const Color(0xFF2A85FF),
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                        ),
                                                        child: Text('Update', style: TextStyle(fontSize: 4.sp),)
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                              
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  }
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //Customer Information Title
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, top: 5.sp, right: 5.sp),
                                      child: Text('Order History Information', style: TextStyle(fontSize: 5.sp, fontWeight: FontWeight.w600,)),
                                    ),
                                    SizedBox(height: 10.h,),
                                    //Text Form Customer
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.sp, right: 5.sp, bottom: 10.sp),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: DataTable(
                                          showCheckboxColumn: false,
                                          columns: const <DataColumn> [
                                            DataColumn(label: Text('Sales Number')),
                                            DataColumn(label: Text('Item')),
                                            DataColumn(label: Text('Quantity')),
                                            DataColumn(label: Text('Status')),
                                          ],  
                                          rows: <DataRow>[
                                            DataRow(
                                              cells: <DataCell> [
                                                DataCell(Text('1')),
                                                DataCell(Text('PT. AXXX XXXX XXXX')),
                                                DataCell(Text('1')),
                                                DataCell(Text('PT. AXXX XXXX XXXX')),
                                              ],
                                              onSelectChanged: (selected) {
                                                if (selected!) {
                                                  // Get.to(DetailCustomerSettingLarge());
                                                }
                                              },
                                            ),
                                          ]
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