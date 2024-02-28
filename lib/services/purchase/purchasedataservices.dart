// ignore_for_file: non_constant_identifier_names, unused_local_variable, unused_import

import 'dart:async';
import 'dart:typed_data';
import 'package:erpsystems/large/purchasing%20module/purchasingindex.dart';
import 'package:erpsystems/services/masterservices.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data' show Uint8List;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> createExcelLocal(
  List<String> poNumbers, List<String> poDate, List<String> poStatus, List<String> poSupplier, 
  List<String> poShipmentDate, List<String> poPayment, List<String> poProductName1, List<String> poQuantity1, 
  List<String> poPackagingSize1, List<String> poUnitPrice1, 
  List<String> poProductName2, List<String> poQuantity2, 
  List<String> poPackagingSize2, List<String> poUnitPrice2,
  List<String> poProductName3, List<String> poQuantity3, 
  List<String> poPackagingSize3, List<String> poUnitPrice3,
  List<String> poProductName4, List<String> poQuantity4, 
  List<String> poPackagingSize4, List<String> poUnitPrice4,
  List<String> poProductName5, List<String> poQuantity5, 
  List<String> poPackagingSize5, List<String> poUnitPrice5,) async {
  // Create an Excel workbook
  var excel = Excel.createExcel();

  // Add data to the Excel workbook
  var sheet = excel['Sheet1'];
  sheet.merge(
    CellIndex.indexByString('A1'),
    CellIndex.indexByString('AG1'),
    customValue: const TextCellValue('Laporan PO Local'),
  );

  sheet.appendRow([TextCellValue('Nomor PO'), TextCellValue('Tanggal PO'), TextCellValue('Supplier'), TextCellValue('Shipment'), TextCellValue('Payment'), TextCellValue('Status'),
   TextCellValue('Product Name'), TextCellValue('Product Quantity'), TextCellValue('Packaging Size'), TextCellValue('Unit Price'), TextCellValue('Total Price'), 
   TextCellValue('Product Name'), TextCellValue('Product Quantity'), TextCellValue('Packaging Size'), TextCellValue('Unit Price'), TextCellValue('Total Price'), 
   TextCellValue('Product Name'), TextCellValue('Product Quantity'), TextCellValue('Packaging Size'), TextCellValue('Unit Price'), TextCellValue('Total Price'), 
   TextCellValue('Product Name'), TextCellValue('Product Quantity'), TextCellValue('Packaging Size'), TextCellValue('Unit Price'), TextCellValue('Total Price'),
   TextCellValue('Product Name'), TextCellValue('Product Quantity'), TextCellValue('Packaging Size'), TextCellValue('Unit Price'), TextCellValue('Total Price'), TextCellValue('VAT'), TextCellValue('Total Price'),]);
  

  List<Future<Map<String, dynamic>>> fetchFutures = [];

  for (int i = 0; i < poNumbers.length; i++) {
    // Collect futures of fetchDetailPurchase
    fetchFutures.add(fetchDetailPurchase(poNumbers[i]).then((result) {
      return Future.value({
        
      }); 
    }));
  }

  // Wait for all fetchDetailPurchase to complete
  List<Map<String, dynamic>> results = await Future.wait(fetchFutures);
  print(results);

  for (int i = 0; i < poNumbers.length; i++) {
    sheet.appendRow([
      TextCellValue(poNumbers[i]),
      TextCellValue(poDate[i]),
      TextCellValue(poSupplier[i]),
      TextCellValue(poShipmentDate[i]),
      TextCellValue(poPayment[i]),
      TextCellValue(poStatus[i]),
      TextCellValue(poProductName1[i]),
      TextCellValue(poQuantity1[i]),
      TextCellValue(poPackagingSize1[i]),
      TextCellValue(poUnitPrice1[i]),
      TextCellValue(poProductName2[i]),
      TextCellValue(poQuantity2[i]),
      TextCellValue(poPackagingSize2[i]),
      TextCellValue(poUnitPrice2[i]),
      TextCellValue(poProductName3[i]),
      TextCellValue(poQuantity3[i]),
      TextCellValue(poPackagingSize3[i]),
      TextCellValue(poUnitPrice3[i]),
      TextCellValue(poProductName4[i]),
      TextCellValue(poQuantity4[i]),
      TextCellValue(poPackagingSize4[i]),
      TextCellValue(poUnitPrice4[i]),
      TextCellValue(poProductName5[i]),
      TextCellValue(poQuantity5[i]),
      TextCellValue(poPackagingSize5[i]),
      TextCellValue(poUnitPrice5[i]),
    ]);

    
    
    // Consume details from the fetched result
    if (results[i]['Data'] != null && results[i]['Data']['Details'] != null) {
      for (var item in results[i]['Data']['Details']) {
        if (item.containsKey('POProductNameOne')) {
          sheet.appendRow([
            TextCellValue(item['POProductNameOne'] ?? ''),
            TextCellValue(item['POQuantityOne'] ?? ''),
            TextCellValue(item['POPackagingSizeOne'] ?? ''),
            TextCellValue(item['POUnitPriceOne'] ?? ''),
          ]);
        }
        // Repeat the above block for 'POProductNameTwo', 'POProductNameThree', and so on if needed
      }
    }
  }

  // Save the workbook to a file
  List<int>? excelBytes = excel.encode();
  final blob = html.Blob([Uint8List.fromList(excelBytes!)], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.AnchorElement(href: url)
    ..target = 'blank'
    ..download = 'data_excel.xlsx';

  // Trigger a click on the anchor element to start the download
  html.document.body?.append(anchor);
  anchor.click();

  // Clean up
  html.Url.revokeObjectUrl(url);
  anchor.remove();
}

Future<Uint8List> generatePDF(String poNumber, String companyName, String companyAddress, DateTime purchaseDate, 
String PICName, String supplierName, String paymentName, String deliveryName, String productNameOne, String quantityOne, 
String packagingOne, String unitPriceOne, String totalOne, String productNameTwo, String quantityTwo, String packagingTwo, 
String unitPriceTwo, String totalTwo, String productNameThree, String quantityThree, String packagingThree, 
String unitPriceThree, String totalThree, String productNameFour, String quantityFour, String packagingFour, 
String unitPriceFour, String totalFour, String productNameFive, String quantityFive, String packagingFive, 
String unitPriceFive, String totalFive, String VAT, String totalPrice) async{
  final pdf = pw.Document();
  final completer = Completer<Uint8List>();

  pdf.addPage(
    pw.Page(
      margin: const pw.EdgeInsets.all(20),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        final image = pw.MemoryImage(
          base64Decode('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'),
        );
        return pw.Column(
          children: [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      // pw.Image(image),
                      pw.SizedBox(width: 30),
                      pw.Column(
                        children: [
                          pw.Text('PT. VENKEN INTERNATIONAL KIMIA', style: 
                            pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 18.0,
                              color: PdfColor.fromHex('#333333'), // Replace with your desired color
                            ),
                          ),
                          pw.SizedBox(height: 2),
                          pw.Text('FOOD AND INDUSTRIAL CHEMICALS SUPPLIER', style: pw.TextStyle(fontSize: 12.0,color: PdfColor.fromHex('#555555'),),),
                          pw.SizedBox(height: 2),
                        ]
                      )
                    ]

                  )
                ]
              ),
              pw.Divider(thickness: 1.0, color: PdfColor.fromHex('#333333')),
              pw.SizedBox(height: 4),
              pw.Expanded(
                child: pw.Padding(
                padding: const pw.EdgeInsets.only(),
                child: pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 350,
                          child: pw.Text('Purchase Order'),
                        ),
                        pw.Text('To : $supplierName')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 350,
                          child: pw.Text('No     : $poNumber'),
                        ),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 350,
                          child: pw.Text('Date  : $purchaseDate'),
                        ),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 350,
                          child: pw.Text(' '),
                        ),
                        pw.Text('Attn : $PICName')
                      ]
                    ), 
                    pw.SizedBox(height: 10),
                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: const pw.FlexColumnWidth(1),  // No
                        1: const pw.FlexColumnWidth(3),  // Product
                        2: const pw.FlexColumnWidth(2),  // Quantity (Kg)
                        3: const pw.FlexColumnWidth(2),  // Packaging Size (Kg)
                        4: const pw.FlexColumnWidth(2),  // Unit Price (IDR)
                        5: const pw.FlexColumnWidth(2),  // Total (IDR)
                      },
                      children: [
                        pw.TableRow(
                          children: [
                            pw.Container(
                              alignment: pw.Alignment.center,
                              child: pw.Text('No'),
                            ),
                            pw.Text('Product', textAlign: pw.TextAlign.center),
                            pw.Text('Quantity (Kg)', textAlign: pw.TextAlign.center),
                            pw.Text('Packaging Size (Kg)', textAlign: pw.TextAlign.center),
                            pw.Text('Unit Price (IDR)', textAlign: pw.TextAlign.center),
                            pw.Text('Total (IDR)', textAlign: pw.TextAlign.center),
                          ]
                        ),
                        pw.TableRow(
                          children: [
                            pw.Text('1', textAlign: pw.TextAlign.center),
                            pw.Text(' $productNameOne'),
                            pw.Text(quantityOne, textAlign: pw.TextAlign.center),
                            pw.Text(packagingOne, textAlign: pw.TextAlign.center),
                            pw.Text(unitPriceOne, textAlign: pw.TextAlign.center),
                            pw.Text(' $totalOne'),
                          ]
                        ),
                        if(productNameTwo != '')
                          pw.TableRow(
                            children: [
                              pw.Text('2', textAlign: pw.TextAlign.center),
                              pw.Text(' $productNameTwo'),
                              pw.Text(quantityTwo, textAlign: pw.TextAlign.center),
                              pw.Text(packagingTwo, textAlign: pw.TextAlign.center),
                              pw.Text(unitPriceTwo, textAlign: pw.TextAlign.center),
                              pw.Text(' $totalTwo'),
                            ]
                          ),
                        if(productNameThree != '')
                          pw.TableRow(
                            children: [
                              pw.Text('3', textAlign: pw.TextAlign.center),
                              pw.Text(' $productNameThree'),
                              pw.Text(quantityThree, textAlign: pw.TextAlign.center),
                              pw.Text(packagingThree, textAlign: pw.TextAlign.center),
                              pw.Text(unitPriceThree, textAlign: pw.TextAlign.center),
                              pw.Text(' $totalThree'),
                            ]
                          ),
                        if(productNameFour != '')
                          pw.TableRow(
                            children: [
                              pw.Text('4', textAlign: pw.TextAlign.center),
                              pw.Text(' $productNameFour'),
                              pw.Text(quantityFour, textAlign: pw.TextAlign.center),
                              pw.Text(packagingFour, textAlign: pw.TextAlign.center),
                              pw.Text(unitPriceFour, textAlign: pw.TextAlign.center),
                              pw.Text(' $totalFour'),
                            ]
                          ),
                        if(productNameFive != '')
                          pw.TableRow(
                            children: [
                              pw.Text('5', textAlign: pw.TextAlign.center),
                              pw.Text(' $productNameFive'),
                              pw.Text(quantityFive, textAlign: pw.TextAlign.center),
                              pw.Text(packagingFive, textAlign: pw.TextAlign.center),
                              pw.Text(unitPriceFive, textAlign: pw.TextAlign.center),
                              pw.Text(' $totalFive'),
                            ]
                          ),
                        pw.TableRow(
                          children: [
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text('Vat 11 %'),
                            pw.Text(VAT),
                          ]
                        ),
                        pw.TableRow(
                          children: [
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text(''),
                            pw.Text('Total'),
                            pw.Text(totalPrice),
                          ]
                        ),
                      ]
                    ),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Payment   : $paymentName'),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Delivery    : $deliveryName'),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Delivery Address   : Pergudangan Taman Tekno\n                                Sektor XI Blok K3 No. 47, BSD - Tangerang\n                                Telp : 021-75880017'),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Invoice Under : '),
                        pw.Text(' ')
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 104,
                          child: pw.Text(' '),
                        ),
                        pw.Text(companyName)
                      ]
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 104,
                          child: pw.Text(' '),
                        ),
                        pw.Text(companyAddress)
                      ]
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Documents : COA send By E-mail to purchasing.vik@gmail.com'),
                        pw.Text(' ')
                      ]
                    ),
                  ],
                ),
              ),
              ),
          ]
        );
      }
    )
  );

  return pdf.save();
}

Future<void> generatePOPDF(String poNumber, String companyName, String companyAddress, DateTime purchaseDate, String PICName, String supplierName, String paymentName, String deliveryName, String productNameOne, String quantityOne, String packagingOne, String unitPriceOne, String totalOne, String productNameTwo, String quantityTwo, String packagingTwo, String unitPriceTwo, String totalTwo, String productNameThree, String quantityThree, String packagingThree, String unitPriceThree, String totalThree, String productNameFour, String quantityFour, String packagingFour, String unitPriceFour, String totalFour, String productNameFive, String quantityFive, String packagingFive, String unitPriceFive, String totalFive, String VAT, String totalPrice) async {
    // Generate PDF
    final Uint8List pdfBytes = await generatePDF(poNumber, companyName, companyAddress, purchaseDate, PICName, supplierName, paymentName, deliveryName, productNameOne, quantityOne, packagingOne, unitPriceOne, totalOne, productNameTwo, quantityTwo, packagingTwo, unitPriceTwo, totalTwo, productNameThree, quantityThree, packagingThree, unitPriceThree, totalThree, productNameFour, quantityFour, packagingFour, unitPriceFour, totalFour, productNameFive, quantityFive, packagingFive, unitPriceFive, totalFive, VAT, totalPrice);

    // Convert Uint8List to Blob
    final html.Blob blob = html.Blob([pdfBytes]);

    // Create a data URL
    final String url = html.Url.createObjectUrlFromBlob(blob);

    // Create a download link
    final html.AnchorElement anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = '$poNumber.pdf'
      ..click();

    // Clean up
    html.Url.revokeObjectUrl(url);
}

Future <PurchaseDetail> fetchDetailPurchase(PONumber) async {
  final response = await http.get(Uri.parse('${ApiEndpoints.baseUrl}purchase/getdetailpurchaselocal.php?PONumber=$PONumber'));

  if (response.statusCode == 200) {
    return PurchaseDetail.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future <List<Map<String, dynamic>>> allPurchaseLocal() async{
 final response = await http.get(Uri.parse('${ApiEndpoints.baseUrl}purchase/getallpurchaselocal.php'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['Data'];
    return List<Map<String, dynamic>>.from(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future <List<Map<String, dynamic>>> topPurchaseLocal() async{
 final response = await http.get(Uri.parse('${ApiEndpoints.baseUrl}purchase/gettoppurchaselocal.php'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['Data'];
    return List<Map<String, dynamic>>.from(data);
  } else {
    throw Exception('Failed to load data');
  }
}

class PurchaseDetail {
  final Map<String, dynamic> data;

  PurchaseDetail({required this.data});

  factory PurchaseDetail.fromJson(Map<String, dynamic> json){
    return PurchaseDetail(
      data: json['Data']
    );
  } 
}

class PurchaseStatistic {
  final String pendingOrder;
  final String topItem;
  final String totalPurchase;

  PurchaseStatistic({
    required this.pendingOrder,
    required this.topItem,
    required this.totalPurchase
  });

  factory PurchaseStatistic.fromJson(Map<String, dynamic> json) {
    return PurchaseStatistic(
      pendingOrder: json['Pending'] ?? '0',
      topItem: json['Top'] ?? 'N/A',
      totalPurchase: json['Total'] ?? '0',
    );
  }
}

Future <Map<String, dynamic>> getPurchaseStatistic() async {
  final response = await http.get(
        Uri.parse('https://kevinngabriell.com/erpAPI-v.1.0/purchase/getstatisticpurchase.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
}

Future<void> rejectPurchase(purchaseOrderNumber, username, BuildContext context) async {
  try{
      String apiUpdatePurchase = "${ApiEndpoints.baseUrl}purchase/rejectpurchase.php";

      final response = await http.post(
        Uri.parse(apiUpdatePurchase),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_status" : "ee1d682c-d157-11ee-8",
          "update_by" : username
        }
      );

      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your purchase order has been rejected'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const PurchasingIndexLarge());
                  }, 
                  child: const Text('Oke')
                ),
              ],
            );
          }
        );
      }

    } catch (e){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }
}

Future<void> approvePurchase(purchaseOrderNumber, username, BuildContext context) async {
  try{
      String apiUpdatePurchase = "${ApiEndpoints.baseUrl}purchase/approvepurchase.php";

      final response = await http.post(
        Uri.parse(apiUpdatePurchase),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_status" : "e71e4fc4-d157-11ee-8",
          "update_by" : username
        }
      );

      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your purchase order has been approved'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const PurchasingIndexLarge());
                  }, 
                  child: const Text('Oke')
                ),
              ],
            );
          }
        );
      }

    } catch (e){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }
}

Future <void>  updatePurchaseLocal(purchaseOrderNumber, purchaseOrderDate, purchaseOrderSupplier, purchaseOrderShipment, purchaseOrderPayment, purchaseOrderCurrency, username, 
productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, 
productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour, 
productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive, BuildContext context) async {

  try{
      String apiUpdatePurchase = "${ApiEndpoints.baseUrl}purchase/updatepurchaselocal.php";

      final response = await http.post(
        Uri.parse(apiUpdatePurchase),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_date" : purchaseOrderDate, 
          "purchase_order_supplier" : purchaseOrderSupplier,
          "purchase_order_shipment" : purchaseOrderShipment,
          "purchase_order_payment" : purchaseOrderPayment,
          "purchase_order_origin" : "10",
          "purchase_order_status" : "d7ab6134-d157-11ee-8",
          "purchase_order_type" : "741ead94-d157-11ee-8",
          "purchase_order_currency" : purchaseOrderCurrency,
          "update_by" : username
        }
      );

      if(response.statusCode == 200){
        updatePurchaseLocalItem(purchaseOrderNumber, productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour, productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive, username, context);
      }

    } catch (e){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }

}

Future <void> updatePurchaseLocalItem(purchaseOrderNumber, productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, 
productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour,
 productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive,  username, context) async {

  try{
    String apiUpdatePurchaseItem = "${ApiEndpoints.baseUrl}purchase/updatepurchaselocalitem.php";

    final response = await http.post(
        Uri.parse(apiUpdatePurchaseItem),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_product_name_1" : productNameOne,
          "purchase_order_product_quantity_1" : productQuantityOne, 
          "purchase_order_product_packaging_size_1" : productPackagingOne,
          "purchase_order_product_unit_price_1" : productUnitPriceOne,
          "purchase_order_product_name_2" : productNameTwo,
          "purchase_order_product_quantity_2"  : productQuantityTwo,
          "purchase_order_product_packaging_size_2" : productPackagingTwo,
          "purchase_order_product_unit_price_2" : productUnitPriceTwo,
          "purchase_order_product_name_3" : productNameThree,
          "purchase_order_product_quantity_3" : productQuantityThree, 
          "purchase_order_product_packaging_size_3" : productPackagingThree,
          "purchase_order_product_unit_price_3" : productUnitPriceThree,
          "purchase_order_product_name_4" : productNameFour,
          "purchase_order_product_quantity_4"  : productQuantityFour,
          "purchase_order_product_packaging_size_4" : productPackagingFour,
          "purchase_order_product_unit_price_4" : productUnitPriceFour,
          "purchase_order_product_name_5" : productNameFive,
          "purchase_order_product_quantity_5"  : productQuantityFive,
          "purchase_order_product_packaging_size_5" : productPackagingFive,
          "purchase_order_product_unit_price_5" : productUnitPriceFive
        }
      );

      if(response.statusCode == 200){
        insertPurchaseLocalHistory(purchaseOrderNumber, username, context);
      }

  } catch (e){
    showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
  }

}

Future <void> insertPurchaseLocal(purchaseOrderNumber, purchaseOrderDate, purchaseOrderSupplier, purchaseOrderShipment, purchaseOrderPayment, purchaseOrderCurrency, username, 
productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, 
productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour,
 productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive, BuildContext context) async {

  if(purchaseOrderNumber.isEmpty || purchaseOrderNumber == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Purchase order number cannot be blank. Please input purchase order number !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (purchaseOrderDate.isEmpty || purchaseOrderDate == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Purchase order date cannot be blank. Please input purchase order date !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (purchaseOrderSupplier.isEmpty || purchaseOrderSupplier == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Purchase order supplier cannot be blank. Please input purchase order supplier !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (purchaseOrderShipment.isEmpty || purchaseOrderShipment == ''){ 
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Purchase order shipment cannot be blank. Please input purchase order shipment !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (purchaseOrderPayment.isEmpty || purchaseOrderPayment == ''){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Purchase order payment cannot be blank. Please input purchase order payment !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else if (productNameOne.isEmpty || productNameOne == '' || productQuantityOne.isEmpty || productQuantityOne == '' || productPackagingOne.isEmpty || productPackagingOne == '' || productUnitPriceOne.isEmpty || productUnitPriceOne == '' ){
    showDialog(
      context: context, 
      builder: (_){
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('First product cannot be null and must be filled !!'),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
              }, 
              child: const Text('Ok')
            )
          ],
        );
      }
    );
  } else {
    try{
      String apiInsertPurchase = "${ApiEndpoints.baseUrl}purchase/insertpurchaselocal.php";

      final response = await http.post(
        Uri.parse(apiInsertPurchase),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_date" : purchaseOrderDate, 
          "purchase_order_supplier" : purchaseOrderSupplier,
          "purchase_order_shipment" : purchaseOrderShipment,
          "purchase_order_payment" : purchaseOrderPayment,
          "purchase_order_origin" : "10",
          "purchase_order_status" : "d7ab6134-d157-11ee-8",
          "purchase_order_type" : "741ead94-d157-11ee-8",
          "purchase_order_currency" : purchaseOrderCurrency,
          "insert_by" : username
        }
      );

      if(response.statusCode == 200){
        insertPurchaseLocalItem(purchaseOrderNumber, productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour, productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive, username, context);
      }

    } catch (e){
      showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
    }
  }
}

Future <void> insertPurchaseLocalItem(purchaseOrderNumber, productNameOne, productQuantityOne, productPackagingOne, productUnitPriceOne, productNameTwo, productQuantityTwo, productPackagingTwo, productUnitPriceTwo, 
productNameThree, productQuantityThree, productPackagingThree, productUnitPriceThree, productNameFour, productQuantityFour, productPackagingFour, productUnitPriceFour,
 productNameFive, productQuantityFive, productPackagingFive, productUnitPriceFive,  username, context) async {

  try{
    String apiInsertPurchaseItem = "${ApiEndpoints.baseUrl}purchase/insertpurchaselocalitem.php";

    final response = await http.post(
        Uri.parse(apiInsertPurchaseItem),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "purchase_order_product_name_1" : productNameOne,
          "purchase_order_product_quantity_1" : productQuantityOne, 
          "purchase_order_product_packaging_size_1" : productPackagingOne,
          "purchase_order_product_unit_price_1" : productUnitPriceOne,
          "purchase_order_product_name_2" : productNameTwo,
          "purchase_order_product_quantity_2"  : productQuantityTwo,
          "purchase_order_product_packaging_size_2" : productPackagingTwo,
          "purchase_order_product_unit_price_2" : productUnitPriceTwo,
          "purchase_order_product_name_3" : productNameThree,
          "purchase_order_product_quantity_3" : productQuantityThree, 
          "purchase_order_product_packaging_size_3" : productPackagingThree,
          "purchase_order_product_unit_price_3" : productUnitPriceThree,
          "purchase_order_product_name_4" : productNameFour,
          "purchase_order_product_quantity_4"  : productQuantityFour,
          "purchase_order_product_packaging_size_4" : productPackagingFour,
          "purchase_order_product_unit_price_4" : productUnitPriceFour,
          "purchase_order_product_name_5" : productNameFive,
          "purchase_order_product_quantity_5"  : productQuantityFive,
          "purchase_order_product_packaging_size_5" : productPackagingFive,
          "purchase_order_product_unit_price_5" : productUnitPriceFive
        }
      );

      if(response.statusCode == 200){
        insertPurchaseLocalHistory(purchaseOrderNumber, username, context);
      }

  } catch (e){
    showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
  }

}

Future <void> insertPurchaseLocalHistory (purchaseOrderNumber, username, context) async{

  try{
    String apiInsertPurchaseHistory = "${ApiEndpoints.baseUrl}purchase/insertpurchaselocalhistory.php";

    final response = await http.post(
        Uri.parse(apiInsertPurchaseHistory),
        body: {
          "purchase_order_number" : purchaseOrderNumber,
          "insert_by" : username,
        }
      );

      if(response.statusCode == 200){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your purchase order has been inserted/updated to systems'),
              actions: [
                TextButton(
                  onPressed: (){
                    Get.to(const PurchasingIndexLarge());
                  }, 
                  child: const Text('Oke')
                ),
              ],
            );
          }
        );
      }

  } catch (e){
    showDialog(
        context: context, 
        builder: (_){
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.toString()),
          );
        }
      );
  }

}

