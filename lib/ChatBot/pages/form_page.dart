import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/form_controller.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final FormController controller = Get.find<FormController>();

  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController genderController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: controller.name.value);
    mobileController = TextEditingController(text: controller.mobile.value);
    emailController = TextEditingController(text: controller.email.value);
    addressController = TextEditingController(text: controller.address.value);
    genderController = TextEditingController(text: controller.gender.value);
    dobController = TextEditingController(text: controller.dob.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Page")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: "Mobile")),
            TextField(
                controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address")),
            TextField(
                controller: genderController,
                decoration: const InputDecoration(labelText: "Gender")),
            TextField(
                controller: dobController,
                decoration: const InputDecoration(labelText: "Date of Birth")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Success", "Form Submitted");
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
