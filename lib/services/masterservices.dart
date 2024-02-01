class ApiEndpoints {
  static final String baseUrl = 'http://localhost/erpAPI-v.1.0/';

  static String get apiCountry => baseUrl + 'master/origin/getorigin.php';
  static String apiCustomer(String companyId) => baseUrl + 'master/customer/getallcustomer.php?company=$companyId';

  // Add more API endpoints as needed
}

