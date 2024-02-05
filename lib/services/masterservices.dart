class ApiEndpoints {
  static final String baseUrl = 'https://kevinngabriell.com/erpAPI-v.1.0/';

  static String get apiCountry => baseUrl + 'master/origin/getorigin.php';
  static String apiCustomer(String companyId) => baseUrl + 'master/customer/getallcustomer.php?company=$companyId';
  static String get limitUser => baseUrl + 'company/companyData/getlistuser.php';
  // Add more API endpoints as needed
}

