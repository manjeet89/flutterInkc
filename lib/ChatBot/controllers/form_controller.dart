import 'package:get/get.dart';
import '../models/user_form_model.dart';

class FormController extends GetxController {
  var name = "".obs;
  var mobile = "".obs;
  var email = "".obs;
  var address = "".obs;
  var gender = "".obs;
  var dob = "".obs;

  void setData(UserFormModel data) {
    name.value = data.name;
    mobile.value = data.mobile;
    email.value = data.email;
    address.value = data.address;
    gender.value = data.gender;
    dob.value = data.dob;
  }
}
