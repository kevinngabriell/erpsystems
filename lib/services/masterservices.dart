class ApiEndpoints {
  static const String baseUrl = 'https://kevinngabriell.com/erpAPI-v.1.0/';

  static String get apiCountry => '${baseUrl}master/origin/getorigin.php';
  static String apiCustomer(String companyId) => '${baseUrl}master/customer/getallcustomer.php?company=$companyId';
  static String get limitUser => '${baseUrl}company/companyData/getlistuser.php';
  static String get permissionList => '${baseUrl}company/permission/getlistpermission.php';
  static String target2years(String companyId) => '${baseUrl}company/targeting/gettargeting.php?company_id=$companyId';
  // Add more API endpoints as needed
}

