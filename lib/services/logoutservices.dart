// GetStorage().remove('username');
// GetStorage().remove('permissionAccess');
// GetStorage().remove('companyId');
// GetStorage().remove('companyName');
// GetStorage().remove('firstName');

import 'package:erpsystems/large/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future <void> Logout() async {
  GetStorage().remove('username');
  GetStorage().remove('permissionAccess');
  GetStorage().remove('companyId');
  GetStorage().remove('companyName');
  GetStorage().remove('firstName');

  Get.off(LoginLarge());
}