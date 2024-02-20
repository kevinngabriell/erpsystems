class ApiEndpoints {
  static const String baseUrl = 'https://kevinngabriell.com/erpAPI-v.1.0/';

  static String get apiCountry => '${baseUrl}master/origin/getorigin.php';
  static String apiCustomer(String companyId) => '${baseUrl}master/customer/getallcustomer.php?company=$companyId';
  static String get limitUser => '${baseUrl}company/companyData/getlistuser.php';
  static String get permissionList => '${baseUrl}company/permission/getlistpermission.php';
  static String target2years(String companyId) => '${baseUrl}company/targeting/gettargeting.php?company_id=$companyId';
  static String listSupplier(String companyId) => '${baseUrl}master/supplier/getallsupplier.php?company=$companyId';
  static String supplierOrigin(String supplier) => '${baseUrl}master/origin/getoriginbasedonsupplier.php?supplier=$supplier';
  static String supplierPICName(String supplier) => '${baseUrl}master/supplier/getpicnamebasedonsupplier.php?supplier=$supplier';
  static String get termList => '${baseUrl}master/term/getallterm.php';
  static String get shippingList => '${baseUrl}master/shipping/getallshipping.php';
  static String get paymentList => '${baseUrl}master/payment/getallpayment.php';
  // Add more API endpoints as needed
}

